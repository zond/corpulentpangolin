package rules

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"reflect"
	"regexp"
	"sort"
	"strings"
	"text/template"
	"time"
)

var (
	timeType = reflect.TypeOf(time.Now())
)

type Collection struct {
	Name        string
	Type        interface{}
	Collections []Collection
	Functions   []string
}

func (c Collection) Generate() string {
	buf := &bytes.Buffer{}
	c.generate(buf, "")
	return buf.String()
}

func (c Collection) GetName() string {
	if c.Name != "" {
		return c.Name
	}
	if c.Type != nil {
		return reflect.TypeOf(c.Type).Name()
	}
	panic("Unnamed collection!")
}

var (
	preReg      = regexp.MustCompile("(\\s|^|\\()pre(\\s|$|[\\.\\)])")
	postReg     = regexp.MustCompile("(\\s|^|\\()post(\\s|$|[\\.\\)])")
	diffkeysReg = regexp.MustCompile("(\\s|^|\\()diffkeys(\\s|$|[\\.\\)])")
)

func (c Collection) generate(result io.Writer, prefix string) {
	fmt.Fprintf(result, "%s    match /%s/{%sID} {\n", prefix, c.GetName(), c.GetName())
	for _, function := range c.Functions {
		lines := strings.Split(function, "\n")
		for _, line := range lines {
			fmt.Fprintf(result, "%s      %s\n", prefix, line)
		}
	}
	for _, collection := range c.Collections {
		collection.generate(result, prefix+"  ")
	}
	for _, accessType := range AccessTypes {
		if c.Type != nil {
			typeValidator, defaultTrue, extras, found := typeValidator(c, accessType)
			if found || defaultTrue {
				lines := typeValidator(c)
				body := strings.Join(lines, "\n")
				fmt.Fprintf(result, "%s      function allow%s%s() {\n", prefix, accessType, c.GetName())
				hasDiffkey := diffkeysReg.MatchString(body)
				if accessType != createAccess && (preReg.MatchString(body) || hasDiffkey) {
					fmt.Fprintf(result, "%s        let pre = resource.data;\n", prefix)
				}
				if (accessType == createAccess || accessType == updateAccess) && (postReg.MatchString(body) || hasDiffkey) {
					fmt.Fprintf(result, "%s        let post = request.resource.data;\n", prefix)
				}
				if accessType == updateAccess && hasDiffkey {
					fmt.Fprintf(result, "%s        let diffkeys = pre.diff(post).affectedKeys();\n", prefix)
				}
				for _, ex := range extras {
					fmt.Fprintf(result, "%s        %s\n", prefix, ex)
				}
				fmt.Fprintf(result, "%s        return (\n", prefix)
				if len(lines) == 0 && defaultTrue {
					lines = append(lines, "true  // default accessible via empty rules tag")
				}
				for _, line := range lines {
					fmt.Fprintf(result, "%s          %s\n", prefix, line)
				}
				fmt.Fprintf(result, "%s        );\n%s      }\n", prefix, prefix)
				fmt.Fprintf(result, "%s      allow %s: if allow%s%s();\n", prefix, accessType, accessType, c.GetName())
			}
		} else if accessType == readAccess {
			fmt.Fprintf(result, "%s      allow %s;\n", prefix, accessType)
		}
	}
	fmt.Fprintf(result, "%s    }\n", prefix)
}

func tojs(i interface{}) string {
	js, err := json.Marshal(i)
	if err != nil {
		panic(err)
	}
	return string(js)
}

type validator func(c Collection) []string

func isStringValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("(post.get(%s, \"\") is string)", tojs(fieldName))}
	}
}

func isIntValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("(post.get(%s, 0) is int)", tojs(fieldName))}
	}
}

func isListValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("((post.get(%s, []) is list) || (post.%s == null))", tojs(fieldName), fieldName)}
	}
}

func isNumValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("(post.get(%s, 0) is number)", tojs(fieldName))}
	}
}

func isBoolValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("(post.get(%s, false) is bool)", tojs(fieldName))}
	}
}

func orValidator(validators ...validator) validator {
	return func(c Collection) []string {
		parts := []string{}
		for idx, v := range validators {
			vparts := v(c)
			if len(vparts) == 1 {
				parts = append(parts, fmt.Sprintf("%s", vparts[0]))
			} else {
				parts = append(parts, "(")
				for _, vpart := range vparts {
					parts = append(parts, fmt.Sprintf("  %s", vpart))
				}
				parts = append(parts, ")")
			}
			if idx+1 < len(validators) {
				parts = append(parts, "||")
			}
		}
		return parts
	}
}

func andValidator(validators ...validator) validator {
	return func(c Collection) []string {
		if len(validators) == 0 {
			panic("andValidator without children doesn't work")
		}
		if len(validators) == 1 {
			return validators[0](c)
		}
		parts := []string{}
		for idx, v := range validators {
			parts = append(parts, "(")
			for _, vpart := range v(c) {
				parts = append(parts, fmt.Sprintf("  %s", vpart))
			}
			parts = append(parts, ")")
			if idx+1 < len(validators) {
				parts = append(parts, "&&")
			}
		}
		return parts
	}
}

func commentValidator(v validator, comment string) validator {
	return func(c Collection) []string {
		parts := v(c)
		if len(parts) > 0 {
			parts[0] = fmt.Sprintf("%s  // %s", parts[0], comment)
		}
		return parts
	}
}

func isUnchangedValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("!(%s in diffkeys)", tojs(fieldName))}
	}
}

func trueValidator(c Collection) []string {
	return []string{"true"}
}

func tagValidator(c Collection, field reflect.StructField, access accessType) (result validator, defaultAccessible bool, extras []string, foundValidator bool) {
	if field.Tag == "" {
		return trueValidator, false, nil, false
	}
	tagMap := map[string]interface{}{}
	if err := json.Unmarshal([]byte(field.Tag), &tagMap); err != nil {
		panic(fmt.Errorf("Unable to parse JSON in tag for %v: %v", field.Name, err))
	}
	parentTemplate := template.New("").Funcs(template.FuncMap{
		"Absent": func() string {
			return strings.Join(isAbsentValidator(field.Name)(c), "\n")
		},
		"OtherUnchanged": func(name string) string {
			return strings.Join(isUnchangedValidator(name)(c), "\n")
		},
		"Unchanged": func() string {
			return strings.Join(isUnchangedValidator(field.Name)(c), "\n")
		},
		"Unique": func() string {
			return fmt.Sprintf("(!(%s in post) || (post.%s == null) || (post.%s.size() == post.%s.toSet().size()))", tojs(field.Name), field.Name, field.Name, field.Name)
		},
		"Ary": func(doc, name string) string {
			return fmt.Sprintf("(%s.%s == null ? [] : %s.get(%s, []))", doc, name, doc, tojs(name))
		},
		"Set": func(doc, name string) string {
			return fmt.Sprintf("(%s.%s == null ? [].toSet() : %s.get(%s, []).toSet())", doc, name, doc, tojs(name))
		},
		"Map": func(doc, name string) string {
			return fmt.Sprintf("(%s.%s == null ? {} : %s.get(%s, {}))", doc, name, doc, tojs(name))
		},
		"post": func() string {
			return "post"
		},
		"pre": func() string {
			return "pre"
		},
	})
	if ex, found := tagMap[fmt.Sprintf("%s_extras", access)]; found {
		if exAry, ok := ex.([]interface{}); ok {
			extras = make([]string, len(exAry))
			for idx := range extras {
				tmplt := template.Must(parentTemplate.Parse(fmt.Sprint(exAry[idx])))
				out := &bytes.Buffer{}
				if err := tmplt.Execute(out, nil); err != nil {
					panic(err)
				}
				extras[idx] = out.String()
			}
		}
	}
	if tag, found := tagMap[string(access)]; found {
		tagString := ""
		switch t := tag.(type) {
		case string:
			if t == "" {
				return commentValidator(trueValidator, "empty tag implies allowed access"), true, extras, false
			}
			tagString = t
		case []interface{}:
			parts := []string{}
			for _, p := range t {
				parts = append(parts, fmt.Sprint(p))
			}
			tagString = strings.Join(parts, "\n")
		}
		return func(c Collection) []string {
			tmplt := template.Must(parentTemplate.Parse(tagString))
			out := &bytes.Buffer{}
			if err := tmplt.Execute(out, nil); err != nil {
				panic(err)
			}
			res := strings.Split(out.String(), "\n")
			if len(res) > 0 {
				res[0] = fmt.Sprintf("%s  // from %v tag", res[0], field.Name)
			}
			return res
		}, false, extras, true
	}
	return trueValidator, false, extras, false
}

func isZeroOrAbsentValidator(fieldName string, typ reflect.Type) validator {
	var zeroValidator validator
	if typ.Kind() == reflect.Slice {
		zeroValidator = func(c Collection) []string {
			return []string{fmt.Sprintf("(post[%s] == []) || (post[%s] == null)", tojs(fieldName), tojs(fieldName))}
		}
	} else {
		zeroValidator = func(c Collection) []string {
			return []string{fmt.Sprintf("post[%s] == %s", tojs(fieldName), tojs(reflect.Zero(typ).Interface()))}
		}
	}
	return orValidator(
		isAbsentValidator(fieldName),
		zeroValidator,
	)
}

func typeValidator(c Collection, access accessType) (result validator, defaultAccessible bool, extras []string, foundValidator bool) {
	typ := reflect.TypeOf(c.Type)
	if typ.Kind() != reflect.Struct {
		panic(fmt.Errorf("%#v isn't a struct", c.Type))
	}
	validators := []validator{}
	fieldNames := sort.StringSlice{}
	for idx := 0; idx < typ.NumField(); idx++ {
		field := typ.Field(idx)
		var typeValidator validator
		switch field.Type.Kind() {
		case reflect.String:
			typeValidator = isStringValidator(field.Name)
		case reflect.Bool:
			typeValidator = isBoolValidator(field.Name)
		case reflect.Float64:
			typeValidator = isNumValidator(field.Name)
		case reflect.Int64:
			typeValidator = isIntValidator(field.Name)
		case reflect.Int:
			typeValidator = isIntValidator(field.Name)
		case reflect.Slice:
			typeValidator = isListValidator(field.Name)
		}
		fieldNames = append(fieldNames, field.Name)
		switch access {
		case createAccess:
			if createValidator, defaultTrue, ex, found := tagValidator(c, field, access); found {
				extras = ex
				validators = append(validators, createValidator)
				if typeValidator != nil {
					validators = append(validators, typeValidator)
				}
			} else if defaultTrue {
				if typeValidator != nil {
					validators = append(validators, typeValidator)
				}
				defaultAccessible = true
			} else {
				validators = append(validators, isAbsentValidator(field.Name))
			}
		case updateAccess:
			if updateValidator, defaultTrue, ex, found := tagValidator(c, field, access); found {
				extras = ex
				validators = append(validators, updateValidator)
				if typeValidator != nil {
					validators = append(validators, typeValidator)
				}
			} else if defaultTrue {
				if typeValidator != nil {
					validators = append(validators, typeValidator)
				}
				defaultAccessible = true
			} else {
				validators = append(validators, isUnchangedValidator(field.Name))
			}
		default:
			if validator, defaultTrue, ex, found := tagValidator(c, field, access); found {
				extras = ex
				validators = append(validators, validator)
			} else if defaultTrue {
				defaultAccessible = true
			}
		}
	}
	switch access {
	case createAccess:
		fallthrough
	case updateAccess:
		if len(fieldNames) > 0 {
			sort.Sort(fieldNames)
			validators = append(validators, func(c Collection) []string {
				firstJsFieldName, err := json.Marshal(fieldNames[0])
				if err != nil {
					panic(err)
				}
				if len(fieldNames) == 1 {
					return []string{fmt.Sprintf("post.keys().hasOnly([%s])  // default field presence validation", firstJsFieldName)}
				}
				parts := []string{}
				prefix := "post.keys().hasOnly(["
				space := strings.Repeat(" ", len(prefix))
				parts = append(parts, fmt.Sprintf("%s%s,  // default field presence validation", prefix, firstJsFieldName))
				for idx, fieldName := range fieldNames[1:] {
					jsFieldName, err := json.Marshal(fieldName)
					if err != nil {
						panic(err)
					}
					if idx+2 < len(fieldNames) {
						parts = append(parts, fmt.Sprintf("%s%s,", space, jsFieldName))
					} else {
						parts = append(parts, fmt.Sprintf("%s%s])", space, jsFieldName))
					}
				}
				return parts
			})
		}
	}
	if len(validators) == 0 {
		return trueValidator, defaultAccessible, extras, false
	}
	return andValidator(validators...), defaultAccessible, extras, true
}

func isAbsentValidator(fieldName string) validator {
	return func(c Collection) []string {
		return []string{fmt.Sprintf("!(%s in post)", tojs(fieldName))}
	}
}

type accessType string

const (
	readAccess   accessType = "read"
	writeAccess  accessType = "write"
	getAccess    accessType = "get"
	listAccess   accessType = "list"
	createAccess accessType = "create"
	updateAccess accessType = "update"
	deleteAccess accessType = "delete"
)

var AccessTypes = []accessType{readAccess, writeAccess, getAccess, listAccess, createAccess, updateAccess, deleteAccess}

func Generate(collections []Collection) string {
	result := &bytes.Buffer{}
	fmt.Fprintf(result, `rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if false;
    }
`)
	for _, collection := range collections {
		fmt.Fprint(result, collection.Generate())
	}
	fmt.Fprintf(result, `  }
}`)
	return result.String()
}
