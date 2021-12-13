import 'package:corpulentpangolin/cache.dart';
import 'package:corpulentpangolin/layout.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';

import 'app_user.dart';
import 'spinner_widget.dart';

@immutable
class PlayerWidget extends StatelessWidget {
  final String uid;
  const PlayerWidget({Key? key, required this.uid}) : super(key: key);
  @override
  Widget build(context) {
    final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
    return StreamProvider<AppUser?>.value(
        value: cacheDocSnapshots(
                FirebaseFirestore.instance.collection("User").doc(uid))
            .map((snap) {
          if (!snap.exists) {
            return AppUser.missing();
          }
          return AppUser(snap);
        }),
        catchError: (context, err) => AppUser.fromMap({"Error": err}),
        initialData: null,
        builder: (context, _) {
          final user = context.watch<AppUser?>();
          if (user == null) {
            return const SpinnerWidget();
          }
          return Row(
            children: [
              SizedBox(
                child: user.exists
                    ? Image.network(user.pictureURL)
                    : Image.asset("images/anon.png"),
                width: avatarIconWidth,
                height: avatarIconWidth,
              ),
              smallHorizSpace,
              Expanded(
                child: Text(user.exists ? user.username : l10n.anonymous),
              )
            ],
          );
        });
  }
}
