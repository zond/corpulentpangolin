// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sv locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sv';

  static String m0(date) => "Skapat: ${date}";

  static String m1(err) => "Misslyckades med att skapa spel: \$err";

  static String m2(date) => "Avslutat: ${date}";

  static String m3(variant) => "Spelvariant: ${variant}";

  static String m4(v) => "Nödvändig snabbhet: ${v}";

  static String m5(v) => "Nödvändig gradering: ${v}";

  static String m6(v) => "Nödvändig pålitlighet: ${v}";

  static String m7(type) => "Val av land: ${type}";

  static String m8(deadline) => "Faslängd ej förflyttning: ${deadline}";

  static String m9(deadline) => "Faslängd: ${deadline}";

  static String m10(date) => "Started: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Justering"),
        "army": MessageLookupByLibrary.simpleMessage("Armé"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "createGame": MessageLookupByLibrary.simpleMessage("Skapa spel"),
        "created_Date_": m0,
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "description": MessageLookupByLibrary.simpleMessage("Beskrivning"),
        "error": MessageLookupByLibrary.simpleMessage("Fel"),
        "failedCreatingGame_Err_": m1,
        "fall": MessageLookupByLibrary.simpleMessage("Höst"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Avslutade spel"),
        "finished_Date_": m2,
        "fleet": MessageLookupByLibrary.simpleMessage("Flotta"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Spel skapat"),
        "gameVariant_Var_": m3,
        "groupChat": MessageLookupByLibrary.simpleMessage("Gruppchat"),
        "h": MessageLookupByLibrary.simpleMessage("t"),
        "home": MessageLookupByLibrary.simpleMessage("Hem"),
        "invite": MessageLookupByLibrary.simpleMessage("Inbjud"),
        "join": MessageLookupByLibrary.simpleMessage("Delta"),
        "liveGames": MessageLookupByLibrary.simpleMessage("Pågående spel"),
        "loading": MessageLookupByLibrary.simpleMessage("Laddar..."),
        "logInToSeeYourGames": MessageLookupByLibrary.simpleMessage(
            "Logga in för att se dina spel"),
        "loggedIn": MessageLookupByLibrary.simpleMessage("Loggade in"),
        "loggedOut": MessageLookupByLibrary.simpleMessage("Loggade ut"),
        "login": MessageLookupByLibrary.simpleMessage("Logga in"),
        "logout": MessageLookupByLibrary.simpleMessage("Logga ut"),
        "m": MessageLookupByLibrary.simpleMessage("m"),
        "map": MessageLookupByLibrary.simpleMessage("Karta"),
        "minimumQuickness_V_": m4,
        "minimumRating_V_": m5,
        "minimumReliability_V_": m6,
        "movement": MessageLookupByLibrary.simpleMessage("Förflyttning"),
        "myGames": MessageLookupByLibrary.simpleMessage("Mina spel"),
        "nationSelection": MessageLookupByLibrary.simpleMessage("Val av land"),
        "nationSelection_Type_": m7,
        "noGamesFound": MessageLookupByLibrary.simpleMessage("Inga spel funna"),
        "nonMovementPhaseDeadline_Date_": m8,
        "openGames": MessageLookupByLibrary.simpleMessage("Öppna spel"),
        "orders": MessageLookupByLibrary.simpleMessage("Order"),
        "phaseDeadline_Date_": m9,
        "preferences": MessageLookupByLibrary.simpleMessage("Prioritetslista"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Privat chat"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Offentlig chat"),
        "random": MessageLookupByLibrary.simpleMessage("Slumpvis"),
        "retreat": MessageLookupByLibrary.simpleMessage("Reträtt"),
        "source": MessageLookupByLibrary.simpleMessage("Källkod"),
        "spring": MessageLookupByLibrary.simpleMessage("Vår"),
        "started_Date_": m10,
        "unnamed": MessageLookupByLibrary.simpleMessage("namnlöst"),
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("Se"),
        "w": MessageLookupByLibrary.simpleMessage("v")
      };
}
