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

// Package imports:
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'sv';

  static String m0(v) => "Skapad av: ${v}";

  static String m1(date) => "Skapat: ${date}";

  static String m2(v) => "Beskrivning: ${v}";

  static String m3(err) => "Misslyckades med att skapa spel: \$err";

  static String m4(date) => "Avslutat: ${date}";

  static String m5(variant) => "Spelvariant: ${variant}";

  static String m6(v) => "Nödvändig snabbhet: ${v}";

  static String m7(v) => "Nödvändig rank: ${v}";

  static String m8(v) => "Nödvändig pålitlighet: ${v}";

  static String m9(type) => "Val av land: ${type}";

  static String m10(deadline) => "Faslängd ej förflyttning: ${deadline}";

  static String m11(deadline) => "Faslängd: ${deadline}";

  static String m12(v) => "Regler: ${v}";

  static String m13(date) => "Started: ${date}";

  static String m14(err) => "Kunde ej ladda URL: ${err}";

  static String m15(v) => "Användarnamn: ${v}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Justering"),
        "anonymous": MessageLookupByLibrary.simpleMessage("Anonym"),
        "appName": MessageLookupByLibrary.simpleMessage("corpulentpangolin"),
        "army": MessageLookupByLibrary.simpleMessage("Armé"),
        "asGameMasterYouCan": MessageLookupByLibrary.simpleMessage(
            "Som spelledare kan du pausa/starta spel samt kontrollera vilka som deltar (och som vilket land). För att själva spela måste du delta som spelare efter att ha skapat spelet."),
        "changeProfilePicture":
            MessageLookupByLibrary.simpleMessage("Ändra profilbil"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "committedPhases_":
            MessageLookupByLibrary.simpleMessage("Faser redo för resolution:"),
        "createGame": MessageLookupByLibrary.simpleMessage("Skapa spel"),
        "createdBy_V_": m0,
        "created_Date_": m1,
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "description": MessageLookupByLibrary.simpleMessage("Beskrivning"),
        "description_V_": m2,
        "error": MessageLookupByLibrary.simpleMessage("Fel"),
        "failedCreatingGame_Err_": m3,
        "fall": MessageLookupByLibrary.simpleMessage("Höst"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Avslutade spel"),
        "finished_Date_": m4,
        "fleet": MessageLookupByLibrary.simpleMessage("Flotta"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Spel skapat"),
        "gameMasterOnlyAllowedInPrivateGames":
            MessageLookupByLibrary.simpleMessage(
                "Spelledare endast möjligt i privata spel (risk för missbruk)."),
        "gameVariant_Var_": m5,
        "groupChat": MessageLookupByLibrary.simpleMessage("Gruppchat"),
        "h": MessageLookupByLibrary.simpleMessage("t"),
        "home": MessageLookupByLibrary.simpleMessage("Hem"),
        "invite": MessageLookupByLibrary.simpleMessage("Inbjud"),
        "join": MessageLookupByLibrary.simpleMessage("Delta"),
        "liveGames": MessageLookupByLibrary.simpleMessage("Pågående spel"),
        "loading": MessageLookupByLibrary.simpleMessage("Laddar..."),
        "logInToSeeYourGames": MessageLookupByLibrary.simpleMessage(
            "Logga in för att se dina spel"),
        "logInToSeeYourProfile": MessageLookupByLibrary.simpleMessage(
            "Logga in för att se din profil."),
        "loggedIn": MessageLookupByLibrary.simpleMessage("Loggade in"),
        "loggedOut": MessageLookupByLibrary.simpleMessage("Loggade ut"),
        "login": MessageLookupByLibrary.simpleMessage("Logga in"),
        "logout": MessageLookupByLibrary.simpleMessage("Logga ut"),
        "m": MessageLookupByLibrary.simpleMessage("m"),
        "manageAsGameMaster":
            MessageLookupByLibrary.simpleMessage("Administrera som spelledare"),
        "map": MessageLookupByLibrary.simpleMessage("Karta"),
        "minimumQuickness_V_": m6,
        "minimumRating_V_": m7,
        "minimumReliability_V_": m8,
        "movement": MessageLookupByLibrary.simpleMessage("Förflyttning"),
        "myGames": MessageLookupByLibrary.simpleMessage("Mina spel"),
        "nationSelection": MessageLookupByLibrary.simpleMessage("Val av land"),
        "nationSelection_Type_": m9,
        "newProfilePictureURL":
            MessageLookupByLibrary.simpleMessage("URL till ny profilbild"),
        "nmrPhases_":
            MessageLookupByLibrary.simpleMessage("Faser med missade order:"),
        "noGamesFound": MessageLookupByLibrary.simpleMessage("Inga spel funna"),
        "nonCommittedPhases_": MessageLookupByLibrary.simpleMessage(
            "Faser utan redo för resolution:"),
        "nonMovementPhaseDeadline_Date_": m10,
        "nonNMRPhases_":
            MessageLookupByLibrary.simpleMessage("Faser med order:"),
        "onlyPlayersAssignedByGM": MessageLookupByLibrary.simpleMessage(
            "Endast spelare godkända av spelledaren kan delta."),
        "openGames": MessageLookupByLibrary.simpleMessage("Öppna spel"),
        "orders": MessageLookupByLibrary.simpleMessage("Order"),
        "phaseDeadline_Date_": m11,
        "players": MessageLookupByLibrary.simpleMessage("Spelare"),
        "preferences": MessageLookupByLibrary.simpleMessage("Prioritetslista"),
        "private": MessageLookupByLibrary.simpleMessage("Privat"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Privat chat"),
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "profilePictureUpdated":
            MessageLookupByLibrary.simpleMessage("Profilbild uppdaterad"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Offentlig chat"),
        "quickness_": MessageLookupByLibrary.simpleMessage("Snabbhet:"),
        "random": MessageLookupByLibrary.simpleMessage("Slumpvis"),
        "rating_": MessageLookupByLibrary.simpleMessage("Rank:"),
        "reliability_": MessageLookupByLibrary.simpleMessage("Pålitlighet:"),
        "requireAssignmentToJoin":
            MessageLookupByLibrary.simpleMessage("Godkännande nödvändigt"),
        "retreat": MessageLookupByLibrary.simpleMessage("Reträtt"),
        "rules_V_": m12,
        "source": MessageLookupByLibrary.simpleMessage("Källkod"),
        "spring": MessageLookupByLibrary.simpleMessage("Vår"),
        "started_Date_": m13,
        "unableToLoadURL": m14,
        "unnamed": MessageLookupByLibrary.simpleMessage("namnlöst"),
        "username": MessageLookupByLibrary.simpleMessage("Användarnamn"),
        "usernameUpdated":
            MessageLookupByLibrary.simpleMessage("Användarnamn uppdaterat"),
        "username_V_": m15,
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("Se"),
        "w": MessageLookupByLibrary.simpleMessage("v")
      };
}
