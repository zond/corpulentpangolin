package data

import (
	"time"

	"github.com/zond/godip/state"
)

func PhaseFromGodip(ordinal int, state *state.State) *Phase {
	godipPhase := state.Phase()
	phase := &Phase{
		Meta: PhaseMeta{
			Ordinal: ordinal,
			Year:    godipPhase.Year(),
			Season:  string(godipPhase.Season()),
			Type:    string(godipPhase.Type()),
		},
		Units:       map[string]Unit{},
		SCs:         map[string]string{},
		Dislodgeds:  map[string]Unit{},
		Dislodgers:  map[string]string{},
		Bounces:     map[string]map[string]bool{},
		Resolutions: map[string]string{},
	}
	units, scs, dislodgeds, dislodgers, bounces, resolutions := state.Dump()
	for prov, unit := range units {
		phase.Units[string(prov)] = Unit{
			Type:   string(unit.Type),
			Nation: string(unit.Nation),
		}
	}
	for prov, nation := range scs {
		phase.SCs[string(prov)] = string(nation)
	}
	for prov, unit := range dislodgeds {
		phase.Dislodgeds[string(prov)] = Unit{
			Type:   string(unit.Type),
			Nation: string(unit.Nation),
		}
	}
	for dislodgerProv, dislodgedProv := range dislodgers {
		phase.Dislodgers[string(dislodgerProv)] = string(dislodgedProv)
	}
	for prov, bounceMap := range bounces {
		phase.Bounces[string(prov)] = map[string]bool{}
		for prov := range bounceMap {
			phase.Bounces[string(prov)][string(prov)] = true
		}
	}
	for prov, err := range resolutions {
		phase.Resolutions[string(prov)] = err.Error()
	}
	return phase
}

type Unit struct {
	Type   string
	Nation string
}

type PhaseMeta struct {
	Ordinal               int
	Season                string
	Year                  int
	Type                  string
	ResolutionScheduledAt time.Time
	ResolvedAt            time.Time
	Resolved              bool
	GracesUsed            int
	ExtensionsUsed        int
	CreatedAt             time.Time
}

type Phase struct {
	Meta           PhaseMeta
	Units          map[string]Unit
	SCs            map[string]string
	Dislodgeds     map[string]Unit
	Dislodgers     map[string]string
	ForcedDisbands []string
	Bounces        map[string]map[string]bool
	Resolutions    map[string]string
}
