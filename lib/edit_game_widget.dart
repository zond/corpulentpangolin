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
    return StreamProvider.value(
      value: variants.map[variant]!.svgs,
      initialData: null,
      builder: (context, _) {
        final svgs = context.watch<SVGBundle?>();
        if (svgs == null) {
          return _wrap(const SpinnerWidget());
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

class _EditGameWidgetState extends State<EditGameWidget> {
  late Game game;
  late _SplitTime phaseLength;
  late _SplitTime nonMovementPhaseLength;
  bool displayNonMovementPhaseLength = false;
  final gameCollection = FirebaseFirestore.instance.collection("Game");

  @override
  void initState() {
    super.initState();
    game = widget.game;
    phaseLength = _SplitTime(game.phaseLengthMinutes.toInt());
    nonMovementPhaseLength =
        _SplitTime(game.nonMovementPhaseLengthMinutes.toInt());
    displayNonMovementPhaseLength = game.nonMovementPhaseLengthMinutes != 0 &&
        game.nonMovementPhaseLengthMinutes != game.phaseLengthMinutes;
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
            ListTile(
              title: Text(game.exists ? l10n.editGame : l10n.createGame,
                  style: Theme.of(context).textTheme.headline5),
            ),
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
                        message: game.exists ? l10n.cantChangeVariant : "",
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
                                        game["Variant"] = newValue.toString();
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: constraints.maxWidth * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(l10n.createdBy_V_(variant.createdBy)),
                                    const SizedBox(height: 5),
                                    Text(l10n
                                        .description_V_(variant.description)),
                                    const SizedBox(height: 5),
                                    Text(l10n.rules_V_(variant.rules)),
                                  ],
                                ),
                              ),
                              ConditionalRebuild(
                                child: _VariantMapWidget(game.variant,
                                    height: 200,
                                    width: constraints.maxWidth * 0.5),
                                condition: (_, o, n) => o.variant != n.variant,
                              ),
                            ],
                          );
                        }),
                    ],
                  ),
            Row(
              children: [
                Expanded(child: Text(l10n.phaseLength)),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    initialValue: "${phaseLength.days}",
                    decoration: InputDecoration(
                      labelText: l10n.days,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (newValue) {
                      setState(() {
                        phaseLength.days = int.parse(newValue);
                        game["PhaseLengthMinutes"] = phaseLength.toMinutes();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    initialValue: "${phaseLength.hours}",
                    decoration: InputDecoration(
                      labelText: l10n.hours,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (newValue) {
                      setState(() {
                        phaseLength.hours = int.parse(newValue);
                        game["PhaseLengthMinutes"] = phaseLength.toMinutes();
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: 50,
                  child: TextFormField(
                    initialValue: "${phaseLength.minutes}",
                    decoration: InputDecoration(
                      labelText: l10n.minutes,
                    ),
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (newValue) {
                      setState(() {
                        phaseLength.minutes = int.parse(newValue);
                        game["PhaseLengthMinutes"] = phaseLength.toMinutes();
                      });
                    },
                  ),
                ),
              ],
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
              Row(
                children: [
                  Expanded(child: Text(l10n.nonMovementPhaseLength)),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      initialValue: "${nonMovementPhaseLength.days}",
                      decoration: InputDecoration(
                        labelText: l10n.days,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (newValue) {
                        setState(() {
                          nonMovementPhaseLength.days = int.parse(newValue);
                          game["NonMovementPhaseLengthMinutes"] =
                              nonMovementPhaseLength.toMinutes();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      initialValue: "${nonMovementPhaseLength.hours}",
                      decoration: InputDecoration(
                        labelText: l10n.hours,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (newValue) {
                        setState(() {
                          nonMovementPhaseLength.hours = int.parse(newValue);
                          game["NonMovementPhaseLengthMinutes"] =
                              nonMovementPhaseLength.toMinutes();
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: TextFormField(
                      initialValue: "${nonMovementPhaseLength.minutes}",
                      decoration: InputDecoration(
                        labelText: l10n.minutes,
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                          signed: false, decimal: false),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (newValue) {
                        setState(() {
                          nonMovementPhaseLength.minutes = int.parse(newValue);
                          game["NonMovementPhaseLengthMinutes"] =
                              nonMovementPhaseLength.toMinutes();
                        });
                      },
                    ),
                  ),
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
            InputDecorator(
              decoration: InputDecoration(
                labelText: l10n.nationSelection,
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: game["NationSelection"],
                  items: [
                    DropdownMenuItem(child: Text(l10n.random), value: "random"),
                    DropdownMenuItem(
                        child: Text(l10n.preferences), value: "preferences"),
                  ],
                  onChanged: (newValue) {
                    setState(
                        () => game["NationSelection"] = newValue.toString());
                  },
                ),
              ),
            ),
            Row(
              children: [
                Switch(
                  value: !(game["DisablePrivateChat"] as bool),
                  onChanged: (newValue) {
                    setState(() => game["DisablePrivateChat"] = !newValue);
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
                    setState(() => game["DisableConferenceChat"] = !newValue);
                  },
                ),
                Text(l10n.publicChat),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: FloatingActionButton(
                    child: const Icon(Icons.check),
                    onPressed: () {
                      Future<Object?>? updater;
                      final existed = game.exists;
                      if (existed) {
                        final _id = game.id;
                        game.remove("ID");
                        updater = gameCollection.doc(_id).update(game);
                      } else {
                        updater = gameCollection.add(game);
                      }
                      updater.then((_) {
                        appRouter.pop().then((_) {
                          toast(context,
                              existed ? l10n.gameUpdated : l10n.gameCreated);
                        });
                      }).catchError((err) {
                        debugPrint("$err");
                        toast(context, l10n.failedCreatingGame_Err_("$err"));
                      });
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
