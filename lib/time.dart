import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations_en.dart';
import 'package:flutter/material.dart';

String nanosToDuration(BuildContext context, num nanos, {bool short = true}) {
  final l10n = AppLocalizations.of(context) ?? AppLocalizationsEn();
  num minutes = nanos ~/ (1e9 * 60);
  var result = "";
  const aWeek = 60 * 24 * 7;
  if (minutes >= aWeek) {
    final weeks = minutes ~/ aWeek;
    minutes = minutes % aWeek;
    if (minutes == 0) {
      return result + "$weeks${l10n.w}";
    } else if (short) {
      return result + "<${weeks + 1}${l10n.w}";
    }
    result += "$weeks${l10n.w} ";
  }
  const aDay = 60 * 24;
  if (minutes >= aDay) {
    final days = minutes ~/ aDay;
    minutes = minutes % aDay;
    if (minutes == 0) {
      return result + "$days${l10n.d}";
    } else if (short) {
      return result + "<${days + 1}${l10n.d}";
    }
    result += "$days${l10n.d} ";
  }
  if (minutes >= 60) {
    final hours = minutes ~/ 60;
    minutes = minutes % 60;
    if (minutes == 0) {
      return result + "$hours${l10n.h}";
    } else if (short) {
      return result + "<${hours + 1}${l10n.h}";
    }
    result += "$hours${l10n.h} ";
  }
  return result + "$minutes${l10n.m}";
}
