package data

import (
	"fmt"
	"time"

	"github.com/zond/godip"
	"github.com/zond/godip/variants"
	"google.golang.org/api/iterator"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"

	hungarianAlgorithm "github.com/oddg/hungarian-algorithm"
)

type Preference struct {
	Prefs []string `{
	"create_extras": ["let game = get(/databases/$(database)/documents/Game/$(GameID)).data;",
	                  "let variant = get(/databases/$(database)/documents/Variant/$(game.Variant)).data;"],
	"create": ["(request.auth.uid == PreferenceID)",
			   "&&",
			   "{{Set post \"Prefs\"}}.hasOnly(variant.Nations.toSet())"],
	"update_extras": ["let game = get(/databases/$(database)/documents/Game/$(GameID)).data;",
	                  "let variant = get(/databases/$(database)/documents/Variant/$(game.Variant)).data;"],
	"update": ["(request.auth.uid == PreferenceID)",
	           "&&",
			   "{{Set post \"Prefs\"}}.hasOnly(variant.Nations.toSet())"],
	"delete": "request.auth.uid == PreferenceID",
	"read": "request.auth.uid == PreferenceID"
	}`
}

type Game struct {
	CreatorUID string `{
	"get": "",
	"create": "post.CreatorUID == request.auth.uid"
	}`
	// GM
	OwnerUID string `{
	"create": "(post.OwnerUID == \"\" || post.OwnerUID == request.auth.uid)  // ownerless, or creator is owner",
	"update": ["(",
	           "  (diffkeys.hasOnly([\"MusteredPlayers\", \"Players\", \"Members\", \"ReplaceablePlayers\"]))",
			   "  ||",
			   "  (request.auth.uid == pre.OwnerUID)  // only owner can edit other things than the above set",
			   ")",
			   "&&",
			   "(",
			   "  {{Unchanged}}",
			   "  ||",
			   "  (",
			   "    (post.OwnerUID == request.auth.uid)",
			   "    &&",
			   "    (post.ReplacementOwnerUID == request.auth.uid)",
			   "  )",
			   ")"]
	}`
	// New GM
	ReplacementOwnerUID string `{
	"create": "",
	"update": ""
	}`
	// Latest phase metadata
	PhaseMeta PhaseMeta
	// GM action necessary to join
	InvitationRequired bool `{
	"create": "",
	"update": ""
	}`
	Desc string `{
	"create": "",
	"update": ""
	}`
	NationSelection string `{
	"create": "post.NationSelection in [\"random\", \"preferences\"]",
	"update": "post.NationSelection in [\"random\", \"preferences\"]"
	}`
	// Roll call required to start
	MusteringRequired bool `{
	"create": "",
	"update": ""
	}`
	// Make players replaceable automatically after this many NMRs
	NMRsBeforeReplaceable int `{
	"create": "",
	"update": ""
	}`
	NMRsPerPlayer map[string]int
	// Time added if someone NMRs
	GraceLengthMinutes int `{
	"create": "",
	"update": ""
	}`
	// Nr of times allowed per player per game
	GracesPerPlayer int `{
	"create": "",
	"update": ""
	}`
	// Memory of above
	GracesUsedPerPlayer map[string]int
	// Nr ot times allowed per phase
	GracesPerPhase int `{
	"create": "",
	"update": ""
	}`
	// Max time added on request
	MaxExtensionLengthMinutes int `{
	"create": "",
	"update": ""
	}`
	// Nr of times allowed per player per game
	ExtensionsPerPlayer int `{
	"create": "",
	"update": ""
	}`
	// Memory of above
	ExtensionsUsedPerPlayer map[string]int
	// Nr of times allowed per phase
	ExtensionsPerPhase int `{
	"create": "",
	"update": ""
	}`
	// Vote ratio required for extensions not of the above type
	PlayerRatioForExtraExtensionVote float64 `{
	"create": "",
	"update": ""
	}`
	PhaseLengthMinutes int `{
	"create": "post.get(\"PhaseLengthMinutes\", 0) >= 0",
	"update": "post.get(\"PhaseLengthMinutes\", 0) >= 0"
	}`
	// ALL phases not regular movement
	NonMovementPhaseLengthMinutes int `{
	"create": "post.get(\"NonMovementPhaseLengthMinutes\", 0) >= 0",
	"update": "post.get(\"NonMovementPhaseLengthMinutes\", 0) >= 0"
	}`
	// Use this timezone when deciding if it's an OK time to start.
	DontStartLimitTimezone string `{
	"create": "",
	"update": ""
	}`
	// Don't start before this time.
	DontStartBeforeMinuteInDay int `{
	"create": "post.get(\"DontStartBeforeMinuteInDay\", 0) >= 0 && post.get(\"DontStartBeforeMinuteInDay\", 0) <= 1440",
	"update": "post.get(\"DontStartBeforeMinuteInDay\", 0) >= 0 && post.get(\"DontStartBeforeMinuteInDay\", 0) <= 1440"
	}`
	// Don't start after this time.
	DontStartAfterMinuteInDay int `{
	"create": "post.get(\"DontStartAfterMinuteInDay\", 0) >= 0 && post.get(\"DontStartAfterMinuteInDay\", 0) <= 1440",
	"update": "post.get(\"DontStartAfterMinuteInDay\", 0) >= 0 && post.get(\"DontStartAfterMinuteInDay\", 0) <= 1440"
	}`
	// (Non-NMR phases + 1) / (NMR phases + 1)
	MinReliability float64 `{
	"create": "post.get(\"MinReliability\", 0) >= 0",
	"update": "post.get(\"MinReliability\", 0) >= 0"
	}`
	// (Submitted phases + 1) / (Non-submitted phases + 1)
	MinQuickness float64 `{
	"create": "post.get(\"MinQuickness\", 0) >= 0",
	"update": "post.get(\"MinQuickness\", 0) >= 0"
	}`
	// TrueSkill, probably
	MinRating float64 `{
	"create": "post.get(\"MinRating\", 0) >= 0",
	"update": "post.get(\"MinRating\", 0) >= 0"
	}`
	// Unlisted
	Private bool `{
	"create": "",
	"update": ""
	}`
	// All player chat
	DisableConferenceChat bool `{
	"create": "",
	"update": ""
	}`
	// > 2 < all player chat
	DisableGroupChat bool `{
	"create": "",
	"update": ""
	}`
	// 2 player chat
	DisablePrivateChat bool `{
	"create": "",
	"update": ""
	}`
	Variant string `{
	"create": "exists(/databases/$(database)/documents/Variant/$(post.Variant))  // variant must exist"
	}`
	// Players replaceable according to GM or NMR counter
	ReplaceablePlayers []string `{
	"update": "{{Unique}}"
	}` // Controlled by `Players`
	InvitedPlayers []string `{
	"create": "{{Unique}}",
	"update": "{{Unique}}"
	}`
	InvitedNations []string `{
	"create": "",
	"update": ""
	}`
	MusteredPlayers []string `{
	"update": ["{{Unchanged}}",
	           "||",
			   "(",
			   "  request.auth.uid in {{Ary post \"Players\"}}",
			   "  &&",
			   "  {{Set post \"MusteredPlayers\"}}.difference({{Set pre \"MusteredPlayers\"}}) == [request.auth.uid].toSet()",
			   ")"]
	}`
	// Owner and all players
	Members []string `{
	"list": ["(pre.Private == false)",
	         "||",
			 "(",
			 "  (request.auth != null)",
			 "  &&",
			 "  (request.auth.uid in pre.Members)",
			 ")"],
	"create": ["{{Unique}}",
	           "&&",
			   "(",
			   "  (",
			   "    (post.OwnerUID == \"\")",
			   "    &&",
			   "    ({{Set post \"Members\"}} == {{Set post \"Players\"}})",
			   "  )",
			   "  ||",
			   "  (",
			   "    (post.OwnerUID != \"\")",
			   "    &&",
			   "    ({{Set post \"Members\"}} == {{Set post \"Players\"}}.union([post.OwnerUID].toSet()))",
			   "  )",
			   ")"],
	"update": ["{{Unique}}",
	           "&&",
			   "(",
			   "  (",
			   "    (post.OwnerUID == \"\")",
			   "    &&",
			   "    ({{Set post \"Members\"}} == {{Set post \"Players\"}})",
			   "  )",
			   "  ||",
			   "  (",
			   "    (post.OwnerUID != \"\")",
			   "    &&",
			   "    ({{Set post \"Members\"}} == {{Set post \"Players\"}}.union([post.OwnerUID].toSet()))",
			   "  )",
			   ")"]
	}`
	Players []string `{
	"create": ["{{Unique}}  // no double players",
	           "&&",
			   "(",
			   "  (",
			   "    (post.Players == [request.auth.uid])  // the user is the only player",
			   "    &&",
			   "    userAllowedInGame(post)  // and the user is allowed in the game",
			   "  )",
			   "  ||",
			   "  (",
			   "    (post.OwnerUID == request.auth.uid)  // or the user is the owner",
			   "    &&",
			   "    (post.Players == null || post.Players.size() == 0)  // and there is no player yet",
			   "  )",
			   ")"],
    "update_extras": ["let post_players = {{Set post \"Players\"}};",
	                  "let pre_players = {{Set pre \"Players\"}};",
					  "let added_players = post_players.difference(pre_players);",
					  "let removed_players = pre_players.difference(post_players);",
					  "let variant = get(/databases/$(database)/documents/Variant/$(post.Variant)).data;"],
	"update": ["(diffkeys.intersection([\"Players\", \"ReplaceablePlayers\", \"PlayerPreferences\"].toSet()).size() == 0)  // no change at all to the players, preferences, or replaceable players",
			   "||",
			   "(",
	           "  (post_players.size() <= variant.Nations.size())  // never more players than variant nations",
	           "  &&",
	           "  {{Unique}}  // no double players",
			   "  &&",
			   "  (",
			   "    (",
			   "      !(request.auth.uid in post_players)  // either the user isn't a player",
			   "      &&",
			   "      !exists(/databases/$(database)/documents/Game/$(GameID)/Preference/$(request.auth.uid))  // and doesn't have prefs",
			   "    )",
			   "    ||",
			   "    userAllowedInGame(pre)  // or the user is allowed in the game",
			   "  )",
			   "  &&",
			   "  (",
			   "    (",
			   "      (request.auth.uid == pre.OwnerUID)  // owner can mess with players and replaceable players",
			   "      &&",
			   "      (added_players.size() == 0)  // except add players arbitrarily",
			   "    )",
			   "    ||",
			   "    (",
			   "      {{OtherUnchanged \"ReplaceablePlayers\"}}",
			   "      &&",
			   "      (!pre.Started)",
			   "      &&",
			   "      (",
			   "        (",
			   "          (added_players == [request.auth.uid].toSet())  // user was added",
			   "          &&",
			   "          (removed_players.size() == 0)  // nobody was removed",
			   "        )",
			   "        ||",
			   "        (",
			   "          (added_players.size() == 0)  // nobody was added",
			   "          &&",
			   "          (removed_players == [request.auth.uid].toSet())  // user was removed",
			   "        )",
			   "      )",
			   "    )",
			   "    ||",
			   "    (",
			   "      (!pre.Finished)",
			   "      &&",
			   "      (post_players.size() == pre_players.size())  // same number of players",
			   "      &&",
			   "      (added_players == [request.auth.uid].toSet())  // added themselves",
			   "      &&",
			   "      ({{Set post \"ReplaceablePlayers\"}}.size() == {{Set pre \"ReplaceablePlayers\"}}.size() - 1)  // removed a replaceable player",
			   "      &&",
			   "      (removed_players == {{Set pre \"ReplaceablePlayers\"}}.difference({{Set post \"ReplaceablePlayers\"}}))  // removed players were also removed from replaceable players",
			   "    )",
			   "  )",
			   ")"]
	}`
	PlayerNations map[string]string
	// 1000 for unstarted games, 100 for started games, and 10000 for finished games, for the global game list of a player.
	CategorySortKey int `{
	"create": "post.CategorySortKey == 1000  // created games must have category sort key 1000"
	}`
	// Estimated start time for seeded games, next phase deadline for live games, or finished-at for finished games.
	TimeSortKey time.Time
	CreatedAt   time.Time
	// Game has received the first phase from the cloud functions.
	Seeded   bool
	SeededAt time.Time
	// All necessary players have reported as ready to play (or game didn't require that to happen).
	Mustered   bool
	MusteredAt time.Time
	// Game is possible to join.
	Open bool
	// Game has all necessary players.
	Started   bool
	StartedAt time.Time
	// Game has finished.
	Finished   bool
	FinishedAt time.Time
	// Last error that happened to the game.
	ErrorMessage string
}

func allocateNations(preferences []godip.Nations, nations godip.Nations) ([]godip.Nation, error) {
	// Track which prefs are valid.
	validNation := map[godip.Nation]bool{}
	for _, nation := range nations {
		validNation[nation] = true
	}
	// Build a cost map per prefs.
	costs := make([][]int, len(preferences))
	for prefIdx, prefs := range preferences {
		// For each prefs, create a cost map.
		costMap := map[godip.Nation]int{}
		for _, nation := range prefs {
			// For each valid nation preference, give it a cost of the current size of the cost map.
			if validNation[nation] {
				costMap[nation] = len(costMap)
			}
		}
		// Create a cost array for the prefs.
		costs[prefIdx] = make([]int, len(nations))
		// Populate it with the size of the costMap, or the value of costMap for each nation.
		for nationIdx, nation := range nations {
			// For each nation, create a new cost if we don't already have one.
			if _, found := costMap[nation]; !found {
				costMap[nation] = len(costMap)
			}
			// Add that cost to the cost array.
			costs[prefIdx][nationIdx] = costMap[nation]
		}
	}
	solution, err := hungarianAlgorithm.Solve(costs)
	if err != nil {
		return nil, err
	}
	result := make([]godip.Nation, len(nations))
	for memberIdx := range result {
		result[memberIdx] = nations[solution[memberIdx]]
	}
	return result, nil
}

func (g *Game) postMuster(dctx *DocumentContext) error {
	// TODO(zond): Add a ReprocessAt here that resolves the first phase.
	return dctx.TX.Set(dctx.Ref, g)
}

func (g *Game) musteringDuration() time.Duration {
	dur := time.Duration(g.PhaseLengthMinutes) * time.Minute
	if g.NonMovementPhaseLengthMinutes > 0 {
		dur = time.Duration(g.NonMovementPhaseLengthMinutes) * time.Minute
	}
	return dur
}

func (g *Game) remove(dctx *DocumentContext) error {
	phaseIterator := dctx.TX.Documents(dctx.Ref.Collection("Phase"))
	for phaseSnapshot, err := phaseIterator.Next(); ; phaseSnapshot, err = phaseIterator.Next() {
		if err == iterator.Done {
			break
		} else if err != nil {
			return err
		}
		if err := dctx.TX.Delete(phaseSnapshot.Ref); err != nil {
			return err
		}
	}
	// TODO(zond): Remove preferences!
	return dctx.TX.Delete(dctx.Ref)
}

func neededDelayUntil(tzName string, notBeforeMinuteInDay, notAfterMinuteInDay int) (time.Duration, error) {
	if notBeforeMinuteInDay == notAfterMinuteInDay {
		return 0, nil
	}
	nowTime := time.Now()
	location, err := time.LoadLocation(tzName)
	if err != nil {
		return 0, err
	}
	nowTime = nowTime.In(location)
	nowMinuteInDay := nowTime.Hour()*60 + nowTime.Minute()
	oneDay := 24 * 60
	if notBeforeMinuteInDay < notAfterMinuteInDay { // only within [notBefore, notAfter]
		if nowMinuteInDay < notBeforeMinuteInDay { // if before notBefore, wait until the notBefore time
			return time.Minute * time.Duration(notBeforeMinuteInDay-nowMinuteInDay), nil
		} else if nowMinuteInDay > notAfterMinuteInDay { // if after notAfter, wait until day end and then until notBefore time
			return time.Minute * time.Duration(oneDay-nowMinuteInDay+notBeforeMinuteInDay), nil
		} else {
			return 0, nil
		}
	} else if notBeforeMinuteInDay > notAfterMinuteInDay { // only process within [notBefore, end-of-day] or [start-of-day, notAfter]
		if nowMinuteInDay > notAfterMinuteInDay && nowMinuteInDay < notBeforeMinuteInDay { // if within [DontStartAfter, DontStartBefore], wait until notBefore
			return time.Minute * time.Duration(notBeforeMinuteInDay-nowMinuteInDay), nil
		} else {
			return 0, nil
		}
	}
	return 0, nil
}

func (g *Game) neededDelayUntilStart() (time.Duration, error) {
	return neededDelayUntil(g.DontStartLimitTimezone, g.DontStartBeforeMinuteInDay, g.DontStartAfterMinuteInDay)
}

func (g *Game) delayUntilStartIfNeeded(dctx *DocumentContext) (bool, error) {
	delay, err := g.neededDelayUntilStart()
	if err != nil {
		return false, g.recordAndReturnError(dctx, fmt.Errorf("Unable to compute start delay for %+v: %v", g, err))
	}
	if delay > 0 {
		newTime := time.Now().Add(delay)
		if err := dctx.ReprocessAt(newTime); err != nil {
			return false, g.recordAndReturnError(dctx, fmt.Errorf("Unable to reschedule start of game %+v to %v: %v", g, newTime, err))
		}
		return true, nil
	}
	return false, nil
}

func (g *Game) recordAndReturnError(dctx *DocumentContext, err error) error {
	g.ErrorMessage = err.Error()
	return dctx.TX.Set(dctx.Ref, g)
}

func ProcessGame(dctx *DocumentContext) error {
	gameSnapshot, err := dctx.TX.Get(dctx.Ref)
	if status.Code(err) == codes.NotFound {
		return nil
	} else if err != nil {
		return err
	}
	game := &Game{}
	if err := gameSnapshot.DataTo(game); err != nil {
		return err
	}
	variant, found := variants.Variants[game.Variant]
	if !found {
		return game.recordAndReturnError(dctx, fmt.Errorf("Variant for %+v not found!", game))
	}
	if !game.Seeded {
		start, err := variant.Start()
		if err != nil {
			return game.recordAndReturnError(dctx, fmt.Errorf("variant.Start() for %q: %v", game.Variant, err))
		}
		phase := PhaseFromGodip(0, start)
		game.CreatedAt = gameSnapshot.CreateTime
		game.Seeded = true
		game.SeededAt = time.Now()
		game.TimeSortKey = time.Now().Add(24 * 30 * time.Hour)
		game.PhaseMeta = phase.Meta
		game.Open = true
		if err := dctx.TX.Set(dctx.Ref.Collection("Phase").Doc(fmt.Sprint(phase.Meta.Ordinal)), phase); err != nil {
			return err
		}
		return dctx.TX.Set(dctx.Ref, game)
	} else if !game.Started {
		if len(game.Players) == 0 && game.OwnerUID == "" {
			return game.remove(dctx)
		}
		if len(game.Players) == len(variant.Nations) {
			isDelayed, err := game.delayUntilStartIfNeeded(dctx)
			if err != nil || isDelayed {
				return err
			}
			game.Open = false
			game.Started = true
			game.StartedAt = time.Now()
			if game.MusteringRequired {
				if err := dctx.TX.Set(dctx.Ref, game); err != nil {
					return err
				}
				if dctx.ReprocessAt != nil {
					return dctx.ReprocessAt(time.Now().Add(game.musteringDuration()))
				}
				return nil
			}
			game.Mustered = true
			game.MusteredAt = time.Now()
			return game.postMuster(dctx)
		}
	} else if !game.Mustered {
		if len(game.MusteredPlayers) == len(variant.Nations) {
			isDelayed, err := game.delayUntilStartIfNeeded(dctx)
			if err != nil || isDelayed {
				return err
			}
			game.Mustered = true
			game.MusteredAt = time.Now()
			return game.postMuster(dctx)
		}
		if time.Now().Sub(game.StartedAt) > game.musteringDuration() {
			if len(game.MusteredPlayers) == 0 && game.OwnerUID == "" {
				return game.remove(dctx)
			}
			game.Started = false
			game.StartedAt = time.Time{}
			game.Open = true
			game.Players = game.MusteredPlayers
			game.MusteredPlayers = nil
			return dctx.TX.Set(dctx.Ref, game)
		}
	}
	return nil
}
