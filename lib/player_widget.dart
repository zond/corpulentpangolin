import 'package:corpulentpangolin/cache.dart';
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
            return AppUser.anon(context);
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
              Text(l10n.username),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Text(user.username),
              )
            ],
          );
        });
  }
}
