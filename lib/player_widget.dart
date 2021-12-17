// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:corpulentpangolin/cache.dart';
import 'package:corpulentpangolin/layout.dart';
import 'app_user.dart';
import 'router.gr.dart';
import 'spinner_widget.dart';

@immutable
class PlayerWidget extends StatelessWidget {
  final String uid;
  const PlayerWidget({Key? key, required this.uid}) : super(key: key);
  @override
  Widget build(context) {
    final appRouter = context.read<AppRouter>();
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
        catchError: (context, err) {
          debugPrint("PlayerWidget User: $err");
          AppUser.fromMap({"Error": err});
        },
        initialData: null,
        builder: (context, _) {
          final user = context.watch<AppUser?>();
          if (user == null) {
            return const SpinnerWidget();
          }
          return InkWell(
            onTap: () => appRouter.push(ProfilePageRoute(uid: uid)),
            child: Row(
              children: [
                SizedBox(
                  child: user.exists && user.pictureURL != ""
                      ? Image.network(user.pictureURL)
                      : Image.asset("assets/images/anon.png"),
                  width: avatarIconWidth,
                  height: avatarIconWidth,
                ),
                smallHorizSpace,
                Expanded(
                  child: Text(user.exists ? user.username : l10n.anonymous),
                )
              ],
            ),
          );
        });
  }
}
