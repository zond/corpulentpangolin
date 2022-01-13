// Flutter imports:
// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:corpulentpangolin/cache.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app_user.dart';
import 'layout.dart';
import 'onblur_text_form_field.dart';
import 'router.gr.dart';
import 'spinner_widget.dart';
import 'toast.dart';

@immutable
class ProfilePage extends StatelessWidget {
  final String uid;

  const ProfilePage({Key? key, @PathParam('uid') required this.uid})
      : super(key: key);

  @override
  Widget build(context) {
    return StreamProvider<AppUser?>.value(
      value: cacheDocSnapshots(
              FirebaseFirestore.instance.collection("User").doc(uid))
          .map((snapshot) {
        if (!snapshot.exists) {
          return AppUser.missing();
        }
        return AppUser(snapshot);
      }),
      initialData: null,
      builder: (context, _) {
        final appRouter = context.read<AppRouter>();
        final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
        final user = context.watch<User?>();
        final appUser = context.watch<AppUser?>();
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.appName),
            leading: context.router.canPopSelfOrChildren
                ? null
                : BackButton(
                    onPressed: () => appRouter.replace(const HomePageRoute())),
          ),
          body: Column(
            children: [
              Card(
                child: SmallPadding(
                  child: Column(
                    children: [
                      if (user != null && user.uid == uid)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(l10n.loggedInAs),
                            Text(user.email ?? l10n.unnamed),
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(l10n.userID),
                          TextButton(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: uid));
                              toast(context, l10n.copiedToClipboard);
                            },
                            child: Text(uid),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if (appUser == null) const SpinnerWidget(),
              if (appUser != null) ...[
                Column(
                  children: [
                    LayoutBuilder(
                      builder: (context, constraints) {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: constraints.maxWidth / 2,
                              child: SmallPadding(
                                child: Stack(
                                  children: [
                                    if (appUser.exists &&
                                        appUser.pictureURL != "")
                                      Image.network(appUser.pictureURL),
                                    if (!appUser.exists ||
                                        appUser.pictureURL == "")
                                      Image.asset("assets/images/anon.png"),
                                    if (user != null && user.uid == uid)
                                      Positioned(
                                        right: 0.0,
                                        bottom: 0.0,
                                        child: FloatingActionButton(
                                          child: const Icon(Icons.edit),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  _ChangePictureURLDialog(
                                                      user: user,
                                                      appUser: appUser),
                                            );
                                          },
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: constraints.maxWidth / 2,
                              child: user != null && user.uid == uid
                                  ? OnBlurTextFormField(
                                      label: l10n.username,
                                      initialValue: appUser.username,
                                      onBlur: (newValue, toastFunc) async {
                                        Future<Object?>? updater;
                                        if (appUser.exists) {
                                          updater = FirebaseFirestore.instance
                                              .collection("User")
                                              .doc(user.uid)
                                              .update({
                                            "Username": newValue,
                                          });
                                        } else {
                                          updater = FirebaseFirestore.instance
                                              .collection("User")
                                              .doc(user.uid)
                                              .set({
                                            "Username": newValue,
                                          });
                                        }
                                        updater.then((_) {
                                          toastFunc(l10n.profileUpdated);
                                        }).catchError((err) {
                                          debugPrint(
                                              "Failed saving profile: $err");
                                          toast(context,
                                              "Failed saving profile: $err");
                                        });
                                      },
                                    )
                                  : Text(
                                      appUser.exists
                                          ? appUser.username
                                          : l10n.anonymous,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline5),
                            ),
                          ],
                        );
                      },
                    ),
                    if (appUser.exists)
                      Card(
                        child: Column(
                          children: [
                            _StatRow(l10n.reliability_, appUser.reliability),
                            _StatRow(l10n.nmrPhases_, appUser.nmrPhases),
                            _StatRow(l10n.nonNMRPhases_, appUser.nonNMRPhases),
                            _StatRow(l10n.quickness_, appUser.quickness),
                            _StatRow(
                                l10n.committedPhases_, appUser.committedPhases),
                            _StatRow(l10n.nonCommittedPhases_,
                                appUser.nonCommittedPhases),
                            _StatRow(l10n.rating_, appUser.rating),
                          ],
                        ),
                      )
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

@immutable
class _StatRow extends StatelessWidget {
  final String label;
  final num value;

  const _StatRow(this.label, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Row(
          children: [
            SizedBox(
              width: constraints.maxWidth,
              child: SmallPadding(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label, style: Theme.of(context).textTheme.subtitle1),
                    Text("$value",
                        style: Theme.of(context).textTheme.subtitle1),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

class _ChangePictureURLDialog extends StatefulWidget {
  final AppUser appUser;
  final User user;

  const _ChangePictureURLDialog(
      {Key? key, required this.appUser, required this.user})
      : super(key: key);

  @override
  State<_ChangePictureURLDialog> createState() =>
      _ChangePictureURLDialogState();
}

class _ChangePictureURLDialogState extends State<_ChangePictureURLDialog> {
  bool verified = false;
  String url = "";

  @override
  void initState() {
    super.initState();
    url = widget.appUser.pictureURL;
  }

  @override
  Widget build(context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return AlertDialog(
      title: Text(l10n.changeProfilePicture),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (verified) Image.network(url),
          TextFormField(
            initialValue: widget.appUser.pictureURL,
            onChanged: (newValue) {
              setState(() {
                url = newValue;
                verified = false;
              });
            },
            decoration: InputDecoration(hintText: l10n.newProfilePictureURL),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SmallPadding(
                child: FloatingActionButton(
                  child: const Icon(Icons.insert_photo),
                  onPressed: () {
                    try {
                      get(Uri.parse(url)).then((resp) {
                        setState(() {
                          verified = true;
                        });
                      },
                          onError: (err) =>
                              toast(context, l10n.unableToLoadURL("$err")));
                    } on FormatException catch (err) {
                      toast(context, l10n.unableToLoadURL("$err"));
                    }
                  },
                ),
              ),
              if (verified)
                SmallPadding(
                  child: FloatingActionButton(
                    child: const Icon(Icons.check),
                    onPressed: () {
                      Future<Object?>? updater;
                      if (widget.appUser.exists) {
                        updater = FirebaseFirestore.instance
                            .collection("User")
                            .doc(widget.user.uid)
                            .update({
                          "PictureURL": url,
                        });
                      } else {
                        updater = FirebaseFirestore.instance
                            .collection("User")
                            .doc(widget.user.uid)
                            .set({
                          "PictureURL": url,
                        });
                      }
                      updater.then((_) {
                        toast(context, l10n.profileUpdated);
                        Navigator.of(context).pop();
                      }).catchError((err) {
                        debugPrint("Failed saving profile: $err");
                        toast(context, "Failed saving profile: $err");
                      });
                    },
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }
}
