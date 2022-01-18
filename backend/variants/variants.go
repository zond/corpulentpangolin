package variants

import (
	"bytes"
	"context"
	"encoding/json"
	"fmt"
	"log"

	"github.com/andybalholm/brotli"
	"github.com/zond/corpulentpangolin/backend/firestore"
	"github.com/zond/godip"
	"github.com/zond/godip/variants"

	frstr "cloud.google.com/go/firestore"
	vrt "github.com/zond/godip/variants/common"
)

type Variant struct {
	vrt.Variant
	OrderTypes []godip.OrderType
	Start      RenderPhase
	Graph      godip.Graph `skip:"yes"`
}

type Blob struct {
	Bytes []byte
}

type RenderPhase struct {
	Year   int
	Season godip.Season
	Type   godip.PhaseType
	SCs    map[godip.Province]godip.Nation
	Units  map[godip.Province]godip.Unit
	Map    string
}

func storeBlob(ctx context.Context, f func() ([]byte, error), doc *frstr.DocumentRef) error {
	b, err := f()
	if err != nil {
		return err
	}
	buf := &bytes.Buffer{}
	w := brotli.NewWriterOptions(buf, brotli.WriterOptions{Quality: brotli.BestCompression, LGWin: 24})
	if _, err := w.Write(b); err != nil {
		return err
	}
	if err := w.Close(); err != nil {
		return err
	}
	if _, err := doc.Set(ctx, Blob{Bytes: buf.Bytes()}); err != nil {
		return err
	}
	return nil
}

func StoreVariantInfo(ctx context.Context) error {
	store, err := firestore.Firestore(ctx)
	if err != nil {
		return fmt.Errorf("Unable to connect to Firestore: %v", err)
	}
	variantCollection := store.Collection("Variant")
	errors := make(chan error, len(variants.Variants))
	for variantName := range variants.Variants {
		go func(variantName string) {
			v := variants.Variants[variantName]
			errors <- func() error {
				s, err := v.Start()
				if err != nil {
					return err
				}
				p := s.Phase()
				decoratedVariant := Variant{
					Variant:    v,
					OrderTypes: v.Parser.OrderTypes(),
					Start: RenderPhase{
						Year:   p.Year(),
						Season: p.Season(),
						Type:   p.Type(),
						SCs:    s.SupplyCenters(),
						Units:  s.Units(),
					},
					Graph: v.Graph(),
				}
				jsBytes, err := json.Marshal(decoratedVariant)
				if err != nil {
					return err
				}
				mapVariant := map[string]interface{}{}
				if err := json.Unmarshal(jsBytes, &mapVariant); err != nil {
					return err
				}
				firestore.FixJSONKeysForFirestore(mapVariant)
				variantDoc := variantCollection.Doc(variantName)
				if _, err := variantDoc.Set(ctx, mapVariant); err != nil {
					return err
				}
				if err := storeBlob(ctx, v.SVGMap, variantDoc.Collection("Map").Doc("Map")); err != nil {
					return err
				}
				for unitType, f := range v.SVGUnits {
					if err := storeBlob(ctx, f, variantDoc.Collection("Unit").Doc(string(unitType))); err != nil {
						return err
					}
				}
				for flagNation, f := range v.SVGFlags {
					if err := storeBlob(ctx, f, variantDoc.Collection("Flag").Doc(string(flagNation))); err != nil {
						return err
					}
				}
				log.Printf("Stored %v in Firestore...", variantName)
				return nil
			}()
		}(variantName)
	}
	nonNilErrors := []error{}
	for _ = range variants.Variants {
		if err := <-errors; err != nil {
			nonNilErrors = append(nonNilErrors, err)
		}
	}
	if len(nonNilErrors) > 0 {
		return fmt.Errorf("Errors updating variant info: %+v", nonNilErrors)
	}
	log.Printf("*** Success storing variants!")
	return nil
}
