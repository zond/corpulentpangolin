package data

type User struct {
	Username string `{
	"create": "",
	"update": ""
	}`
	PictureURL string `{
	"create": "",
	"update": ""
	}`
	Rating float64 `{
	"read": "",
	"create": ["{{Absent}}",
	           "&&",
			   "(UserID == request.auth.uid)"],
	"update": ["{{Unchanged}}",
			   "&&",
			   "(UserID == request.auth.uid)"]
	}`
	Reliability        float64
	NMRPhases          int
	NonNMRPhases       int
	Quickness          float64
	CommittedPhases    int
	NonCommittedPhases int
	BannedUsers        []string `{
	"create": "{{Absent}} && {{Unique}}",
	"update": "{{Unchanged}} && {{Unique}}"
	}`
	BannedByUsers []string
}
