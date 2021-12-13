import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import 'router.gr.dart';
import 'app_user.dart';
import 'spinner_widget.dart';
import 'layout.dart';
import 'toast.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(context) {
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
          if (user == null)
            Text(l10n.logInToSeeYourProfile,
                style: Theme.of(context).textTheme.subtitle1),
          if (user != null && appUser == null) const SpinnerWidget(),
          if (user != null && appUser != null) ...[
            LayoutBuilder(
              builder: (context, constraints) {
                return Stack(
                  children: [
                    if (appUser.exists && appUser.pictureURL != "")
                      Image.network(appUser.pictureURL,
                          width: constraints.maxWidth / 2),
                    if (!appUser.exists || appUser.pictureURL == "")
                      Image.asset("images/anon.jpg",
                          width: constraints.maxWidth / 2),
                    Positioned(
                      right: 0.0,
                      bottom: 0.0,
                      child: FloatingActionButton(
                        child: const Icon(Icons.edit),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => _ChangePictureURLDialog(
                                user: user, appUser: appUser),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ],
      ),
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
  Widget build(context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return AlertDialog(
      title: Text(l10n.changeProfilePicture),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (verified) Image.network(url),
          TextField(
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
                  child: const Icon(Icons.cloud_download),
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
                      widget.appUser["PictureURL"] = url;
                      widget.appUser["ID"] = widget.user.uid;
                      widget.appUser.save().then((_) {
                        toast(context, l10n.profilePictureUpdated);
                        Navigator.of(context).pop();
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
