package data

import "time"

type ChatChannel struct {
	ParticipantUIDs []string `{
	"create": ["(request.auth.uid in post.ParticipantUIDs)",
	           "&&",
			   "{{Unique}}",
			   "&&",
			   "(post.ParticipantUIDs.toSet().hasOnly(get(/databases/$(database)/documents/Game/$(GameID)).Players.toSet()))"]
	}`
	ParticipantNations            []string
	LatestMessage                 ChatMessage
	NUnreadMessagesPerParticipant map[string]int
	LatestMessageTime             time.Time
}

type ChatMessage struct {
	SenderUID string `{
	"create": "post.SenderUID == request.auth.uid"
	}`
	SenderNation string
	Body         string
	CreatedAt    time.Time
	SeenByUID    map[string]time.Time
}
