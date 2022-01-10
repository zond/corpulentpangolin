import 'package:corpulentpangolin/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'spinner_widget.dart';
import 'variant.dart';
import 'map_widget.dart';
import 'game.dart';
import 'router.gr.dart';
import 'conditional_rebuild.dart';
import 'toast.dart';

@immutable
class _VariantMapWidget extends StatelessWidget {
  final String variant;
  final double? height;
  final double? width;

  const _VariantMapWidget(this.variant, {Key? key, this.height, this.width})
      : super(key: key);

  @override
  Widget build(context) {
    Widget _wrap(Widget w) {
      if (width != null || height != null) {
        return SizedBox(
          height: height,
          width: width,
          child: w,
        );
      }
      return w;
    }

    final variants = context.watch<Variants?>();
    if (variants == null) {
      return _wrap(const SpinnerWidget());
    }
    if (variants.err != null) {
      return Text("VariantMapWidget variants: ${variants.err}");
    }
    if (!variants.map.containsKey(variant)) {
      return Text("Variant $variant not recognized!");
    }
    return StreamProvider<SVGBundle?>.value(
      value: variants.map[variant]!.svgs,
      initialData: null,
      catchError: (context, err) {
        debugPrint("_VariantMapWidget SVGBundle: $err");
        SVGBundle(map: const [], units: const {}, err: err);
      },
      builder: (context, _) {
        final svgs = context.watch<SVGBundle?>();
        if (svgs == null) {
          return _wrap(const SpinnerWidget());
        }
        if (svgs.err != null) {
          return Text("_VariantMapWidget SVGBundle error: ${svgs.err}");
        }
        return _wrap(MapWidget(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor));
      },
    );
  }
}

class EditGameWidget extends StatefulWidget {
  final Game game;

  const EditGameWidget({Key? key, required this.game}) : super(key: key);

  @override
  _EditGameWidgetState createState() => _EditGameWidgetState();
}

class _SplitTime {
  late int days;
  late int hours;
  late int minutes;

  _SplitTime(int m) {
    days = m ~/ (60 * 24);
    m -= days * 60 * 24;
    hours = m ~/ 60;
    m -= hours * 60;
    minutes = m;
  }

  int toMinutes() {
    return days * 60 * 24 + hours * 60 + minutes;
  }
}

class _MinuteLengthField extends StatefulWidget {
  final int initialValue;
  final String label;
  final Function(int) onChange;
  const _MinuteLengthField(
      {Key? key,
      required this.initialValue,
      required this.label,
      required this.onChange})
      : super(key: key);
  @override
  State<_MinuteLengthField> createState() => _MinuteLengthFieldState();
}

class _MinuteLengthFieldState extends State<_MinuteLengthField> {
  late _SplitTime value;
  @override
  void initState() {
    super.initState();
    value = _SplitTime(widget.initialValue);
  }

  @override
  Widget build(context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return Row(
      children: [
        SizedBox(
          width: 50,
          child: TextFormField(
            initialValue: "${value.days}",
            decoration: InputDecoration(
              labelText: l10n.days,
            ),
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (newValue) {
              setState(() {
                try {
                  value.days = int.parse(newValue);
                  widget.onChange(value.toMinutes());
                } catch (_) {}
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            initialValue: "${value.hours}",
            decoration: InputDecoration(
              labelText: l10n.hours,
            ),
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (newValue) {
              setState(() {
                try {
                  value.hours = int.parse(newValue);
                  widget.onChange(value.toMinutes());
                } catch (_) {}
              });
            },
          ),
        ),
        SizedBox(
          width: 50,
          child: TextFormField(
            initialValue: "${value.minutes}",
            decoration: InputDecoration(
              labelText: l10n.minutes,
            ),
            keyboardType: const TextInputType.numberWithOptions(
                signed: false, decimal: false),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (newValue) {
              setState(() {
                try {
                  value.minutes = int.parse(newValue);
                  widget.onChange(value.toMinutes());
                } catch (_) {}
              });
            },
          ),
        ),
      ],
    );
  }
}

class _EditGameWidgetState extends State<EditGameWidget> {
  late Game game;
  late _SplitTime phaseLength;
  late _SplitTime nonMovementPhaseLength;
  late _SplitTime gracePeriodLength;
  bool displayNonMovementPhaseLength = false;
  bool displayStartTimeRequirements = false;
  bool displayGraceOptions = false;
  bool displayExtensionOptions = false;
  bool working = false;
  final gameCollection = FirebaseFirestore.instance.collection("Game");

  @override
  void initState() {
    super.initState();
    game = widget.game;
    phaseLength = _SplitTime(game.phaseLengthMinutes.toInt());
    nonMovementPhaseLength =
        _SplitTime(game.nonMovementPhaseLengthMinutes.toInt());
    gracePeriodLength = _SplitTime(game.graceLengtMinutes.toInt());
    displayNonMovementPhaseLength = game.nonMovementPhaseLengthMinutes != 0 &&
        game.nonMovementPhaseLengthMinutes != game.phaseLengthMinutes;
    displayStartTimeRequirements = game.dontStartAfter != game.dontStartBefore;
    displayGraceOptions = game.hasGrace;
    displayExtensionOptions = game.hasExtensions;
  }

  @override
  Widget build(BuildContext context) {
    final appRouter = context.read<AppRouter>();
    final variants = context.watch<Variants?>();
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    final user = context.watch<User?>();
    if (user == null) {
      return const Text("Can't edit game unless logged in!");
    }
    if (variants != null && variants.err != null) {
      return Text("Variants error: ${variants.err}");
    }
    final Variant? variant =
        variants != null && variants.map.containsKey(widget.game.variant)
            ? variants.map[game.variant]
            : null;
    return Stack(
      children: [
        ListView(
          children: [
            Card(
              child: SmallPadding(
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: game.desc,
                      decoration: InputDecoration(
                        labelText: l10n.description,
                      ),
                      onChanged: (newValue) {
                        setState(() => game["Desc"] = newValue);
                      },
                    ),
                    variants == null
                        ? const SpinnerWidget()
                        : Column(
                            children: [
                              Tooltip(
                                message:
                                    game.exists ? l10n.cantChangeVariant : "",
                                child: InputDecorator(
                                  decoration: InputDecoration(
                                    labelText: l10n.variant,
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                      value: game["Variant"],
                                      items: variants.list.map((variant) {
                                        return DropdownMenuItem(
                                          child: Text(variant.id),
                                          value: variant.id,
                                        );
                                      }).toList(),
                                      onChanged: game.exists
                                          ? null
                                          : (newValue) {
                                              setState(() {
                                                game["Variant"] = "$newValue";
                                              });
                                            },
                                    ),
                                  ),
                                ),
                              ),
                              if (variant != null)
                                LayoutBuilder(builder: (context, constraints) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth * 0.5,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const SizedBox(height: 5),
                                            Text(l10n.createdBy_V_(
                                                variant.createdBy)),
                                            const SizedBox(height: 5),
                                            Text(l10n.description_V_(
                                                variant.description)),
                                            const SizedBox(height: 5),
                                            Text(l10n.rules_V_(variant.rules)),
                                          ],
                                        ),
                                      ),
                                      ConditionalRebuild(
                                        child: _VariantMapWidget(game.variant,
                                            height: 200,
                                            width: constraints.maxWidth * 0.5),
                                        condition: (_, o, n) =>
                                            o.variant != n.variant,
                                      ),
                                    ],
                                  );
                                }),
                            ],
                          ),
                    Row(
                      children: [
                        Switch(
                          value: game.private,
                          onChanged: (newValue) {
                            setState(() {
                              game["Private"] = newValue;
                              game["OwnerUID"] = "";
                              game["InvitationRequired"] = false;
                            });
                          },
                        ),
                        Text(l10n.private),
                      ],
                    ),
                    Row(
                      children: [
                        Switch(
                          value: (game["OwnerUID"] as String) == user.uid,
                          onChanged: game.private
                              ? (newValue) {
                                  setState(() {
                                    if (newValue) {
                                      game["OwnerUID"] = user.uid;
                                    } else {
                                      game["OwnerUID"] = "";
                                      game["InvitationRequired"] = false;
                                    }
                                  });
                                }
                              : null,
                        ),
                        Text(l10n.manageAsGameMaster),
                      ],
                    ),
                    if (!game.private)
                      Text(l10n.gameMasterOnlyAllowedInPrivateGames,
                          style: Theme.of(context).textTheme.bodyText2),
                    if (game.private)
                      Text(l10n.asGameMasterYouCan,
                          style: Theme.of(context).textTheme.bodyText2),
                    if (game.private && game.ownerUID != "") ...[
                      Row(
                        children: [
                          Switch(
                            value: game.invitationRequired,
                            onChanged: (newValue) {
                              setState(() {
                                game["InvitationRequired"] = newValue;
                              });
                            },
                          ),
                          Text(l10n.requireAssignmentToJoin),
                        ],
                      ),
                      Text(l10n.onlyPlayersAssignedByGM,
                          style: Theme.of(context).textTheme.bodyText2),
                    ],
                  ],
                ),
              ),
            ),
            Card(
              child: SmallPadding(
                child: Column(
                  children: [
                    _MinuteLengthField(
                      initialValue: game.phaseLengthMinutes.toInt(),
                      label: l10n.phaseLength,
                      onChange: (m) => setState(() {
                        game["PhaseLengthMinutes"] = m;
                      }),
                    ),
                    Row(
                      children: [
                        Switch(
                          value: displayNonMovementPhaseLength,
                          onChanged: (newValue) {
                            setState(() {
                              displayNonMovementPhaseLength = newValue;
                              if (!newValue) {
                                game["NonMovementPhaseLengthMinutes"] = 0;
                              }
                            });
                          },
                        ),
                        Text(l10n.differentPhaseForNonMovement),
                      ],
                    ),
                    if (displayNonMovementPhaseLength)
                      Card(
                        elevation: smallSpace,
                        child: SmallPadding(
                          child: _MinuteLengthField(
                            initialValue:
                                game.nonMovementPhaseLengthMinutes.toInt(),
                            label: l10n.nonMovementPhaseLength,
                            onChange: (m) => setState(() {
                              game["NonMovementPhaseLengthMinutes"] = m;
                            }),
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Switch(
                          value: displayStartTimeRequirements,
                          onChanged: (newValue) {
                            setState(() {
                              displayStartTimeRequirements = newValue;
                              if (newValue) {
                                game["DontStartBeforeMinuteInDay"] = 0;
                                game["DontStartAfterMinuteInDay"] = 24 * 60;
                              } else {
                                game["DontStartBeforeMinuteInDay"] = 0;
                                game["DontStartAfterMinuteInDay"] = 0;
                              }
                            });
                          },
                        ),
                        Text(l10n.limitWhenGameStarts),
                      ],
                    ),
                    if (displayStartTimeRequirements)
                      ElevatedButton(
                        child: Text(l10n.onlyStartTheGameBetween_F_and_T(
                            game.dontStartBefore.format(context),
                            game.dontStartAfter.format(context))),
                        onPressed: () {
                          showTimePicker(
                                  context: context,
                                  initialTime: game.dontStartBefore,
                                  helpText: l10n.dontStartGameBefore)
                              .then((dontStartBefore) {
                            if (dontStartBefore != null) {
                              showTimePicker(
                                context: context,
                                initialTime: game.dontStartAfter,
                                helpText: l10n.dontStartGameAfter,
                              ).then((dontStartAfter) {
                                if (dontStartAfter != null) {
                                  setState(() {
                                    game["DontStartBeforeMinuteInDay"] =
                                        60 * dontStartBefore.hour +
                                            dontStartBefore.minute;
                                    game["DontStartAfterMinuteInDay"] =
                                        60 * dontStartAfter.hour +
                                            dontStartAfter.minute;
                                    game["DontStartLimitTimezone"] =
                                        DateTime.now().timeZoneName;
                                  });
                                }
                              });
                            }
                          });
                        },
                      ),
                    Row(
                      children: [
                        Switch(
                          value: displayGraceOptions,
                          onChanged: (newValue) {
                            setState(() {
                              displayGraceOptions = newValue;
                              if (!newValue) {
                                game["GraceLengthMinutes"] = 0;
                                game["GracesPerPlayer"] = 0;
                                game["GracesPerPhase"] = 0;
                              }
                            });
                          },
                        ),
                        Text(l10n.allowGracePeriods),
                      ],
                    ),
                    if (displayGraceOptions)
                      Card(
                        elevation: smallSpace,
                        child: SmallPadding(
                          child: Column(
                            children: [
                              _MinuteLengthField(
                                initialValue: game.graceLengtMinutes,
                                label: l10n.gracePeriodLength,
                                onChange: (m) => setState(() {
                                  game["GraceLengthMinutes"] = m;
                                }),
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text(l10n.gracesPerPlayer)),
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      initialValue: "${game.gracesPerPlayer}",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          try {
                                            game["GracesPerPlayer"] =
                                                int.parse(newValue);
                                          } catch (_) {}
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text(l10n.gracesPerPhase)),
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      initialValue: "${game.gracesPerPhase}",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          try {
                                            game["GracesPerPhase"] =
                                                int.parse(newValue);
                                          } catch (_) {}
                                        });
                                      },
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        Switch(
                          value: displayExtensionOptions,
                          onChanged: (newValue) {
                            setState(() {
                              displayExtensionOptions = newValue;
                              if (!newValue) {
                                game["MaxExtensionLengthMinutes"] = 0;
                                game["ExtensionsPerPlayer"] = 0;
                                game["PlayerRatioForExtraExtensionVote"] = 0;
                              }
                            });
                          },
                        ),
                        Text(l10n.allowExtensions),
                      ],
                    ),
                    if (displayExtensionOptions) ...[
                      Card(
                          elevation: smallSpace,
                          child: SmallPadding(
                              child: Column(
                            children: [
                              _MinuteLengthField(
                                initialValue: game.maxExtensionLengthMinutes,
                                label: l10n.maxExtensionLength,
                                onChange: (m) => setState(() {
                                  game["MaxExtensionLengthMinutes"] = m;
                                }),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(l10n.extensionsPerPlayer)),
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      initialValue:
                                          "${game.extensionsPerPlayer}",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          try {
                                            game["ExtensionsPerPlayer"] =
                                                int.parse(newValue);
                                          } catch (_) {}
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(l10n.extensionsPerPhase)),
                                  SizedBox(
                                    width: 50,
                                    child: TextFormField(
                                      initialValue:
                                          "${game.extensionsPerPhase}",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          try {
                                            game["ExtensionsPerPhase"] =
                                                int.parse(newValue);
                                          } catch (_) {}
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                          l10n.votesRequiredForExtraExtension)),
                                  SizedBox(
                                    width: 40,
                                    child: TextFormField(
                                      initialValue:
                                          "${(game.playerRatioForExtraExtensionVote * 100).toInt()}",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                              signed: false, decimal: false),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      onChanged: (newValue) {
                                        setState(() {
                                          try {
                                            game["PlayerRatioForExtraExtensionVote"] =
                                                int.parse(newValue) / 100.0;
                                          } catch (_) {}
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                    child: Text("%"),
                                  ),
                                ],
                              )
                            ],
                          )))
                    ],
                  ],
                ),
              ),
            ),
            Card(
                child: SmallPadding(
              child: Column(
                children: [
                  InputDecorator(
                    decoration: InputDecoration(
                      labelText: l10n.nationSelection,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: "${game["NationSelection"]}",
                        items: [
                          DropdownMenuItem(
                              child: Text(l10n.random), value: "random"),
                          DropdownMenuItem(
                              child: Text(l10n.preferences),
                              value: "preferences"),
                        ],
                        onChanged: (newValue) {
                          setState(() => game["NationSelection"] = "$newValue");
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Switch(
                        value: !(game["DisablePrivateChat"] as bool),
                        onChanged: (newValue) {
                          setState(
                              () => game["DisablePrivateChat"] = !newValue);
                        },
                      ),
                      Text(l10n.privateChat),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: !(game["DisableGroupChat"] as bool),
                        onChanged: (newValue) {
                          setState(() => game["DisableGroupChat"] = !newValue);
                        },
                      ),
                      Text(l10n.groupChat),
                    ],
                  ),
                  Row(
                    children: [
                      Switch(
                        value: !(game["DisableConferenceChat"] as bool),
                        onChanged: (newValue) {
                          setState(
                              () => game["DisableConferenceChat"] = !newValue);
                        },
                      ),
                      Text(l10n.publicChat),
                    ],
                  ),
                ],
              ),
            )),
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: Card(
                  elevation: smallSpace,
                  child: SmallPadding(
                      child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text(l10n.minimumReliabilityToJoin)),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              initialValue: "${game.minimumReliability}",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  try {
                                    game["MinimumReliability"] =
                                        num.parse(newValue);
                                  } catch (_) {}
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text(l10n.minimumQuicknessToJoin)),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              initialValue: "${game.minimumReliability}",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  try {
                                    game["MinimumQuickness"] =
                                        num.parse(newValue);
                                  } catch (_) {}
                                });
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(child: Text(l10n.minimumRatingToJoin)),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              initialValue: "${game.minimumReliability}",
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: false, decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.]'))
                              ],
                              onChanged: (newValue) {
                                setState(() {
                                  try {
                                    game["MinimumRating"] = num.parse(newValue);
                                  } catch (_) {}
                                });
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ))),
            )
          ],
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: FloatingActionButton(
            child: const Icon(Icons.check),
            onPressed: working
                ? null
                : () {
                    Future<Object?>? updater;
                    final existed = game.exists;
                    if (existed) {
                      game.removeTimestamps();
                      updater = gameCollection.doc(game.id).update(game);
                    } else {
                      updater = gameCollection.add(game);
                    }
                    setState(() {
                      working = true;
                    });
                    updater.then((_) {
                      setState(() {
                        working = false;
                      });
                      appRouter.pop().then((_) {
                        toast(context,
                            existed ? l10n.gameUpdated : l10n.gameCreated);
                      });
                    }).catchError((err) {
                      debugPrint("Failed saving game: $err");
                      toast(context, "Failed saving game: $err");
                    });
                  },
          ),
        )
      ],
    );
  }
}
