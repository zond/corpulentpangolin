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

  static String m0(c, p) => "${c} av ${p} deltagare";

  static String m1(v) => "Skapad av: ${v}";

  static String m2(date) => "Skapat: ${date}";

  static String m3(v) => "Beskrivning: ${v}";

  static String m4(err) => "Misslyckades med att skapa spel: \$err";

  static String m5(date) => "Avslutat: ${date}";

  static String m6(variant) => "Spelvariant: ${variant}";

  static String m7(v) => "Nödvändig snabbhet: ${v}";

  static String m8(v) => "Nödvändig rang: ${v}";

  static String m9(v) => "Nödvändig pålitlighet: ${v}";

  static String m10(type) => "Val av land: ${type}";

  static String m11(deadline) => "Faslängd ej förflyttning: ${deadline}";

  static String m12(deadline) => "Faslängd: ${deadline}";

  static String m13(v) => "Regler: ${v}";

  static String m14(date) => "Started: ${date}";

  static String m15(err) => "Kunde ej ladda URL: ${err}";

  static String m16(v) => "Användarnamn: ${v}";

  static String m17(v) => "Röster nödvändiga för förlängning: ${v}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Justering"),
        "anonymous": MessageLookupByLibrary.simpleMessage("Anonym"),
        "appName": MessageLookupByLibrary.simpleMessage("corpulentpangolin"),
        "army": MessageLookupByLibrary.simpleMessage("Armé"),
        "asGameMasterYouCan": MessageLookupByLibrary.simpleMessage(
            "Som spelledare kan du pausa/starta spel samt kontrollera vilka som deltar (och som vilket land). För att själva spela måste du delta som spelare efter att ha skapat spelet."),
        "c_of_p_playersJoined": m0,
        "changeProfilePicture":
            MessageLookupByLibrary.simpleMessage("Ändra profilbil"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "committedPhases_":
            MessageLookupByLibrary.simpleMessage("Faser redo för resolution:"),
        "createGame": MessageLookupByLibrary.simpleMessage("Skapa spel"),
        "createdBy_V_": m1,
        "created_Date_": m2,
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "description": MessageLookupByLibrary.simpleMessage("Beskrivning"),
        "description_V_": m3,
        "error": MessageLookupByLibrary.simpleMessage("Fel"),
        "failedCreatingGame_Err_": m4,
        "fall": MessageLookupByLibrary.simpleMessage("Höst"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Avslutade spel"),
        "finished_Date_": m5,
        "fleet": MessageLookupByLibrary.simpleMessage("Flotta"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Spel skapat"),
        "gameFullNoReplacements": MessageLookupByLibrary.simpleMessage(
            "Spelet är redan fullt och saknar utbytbara spelare"),
        "gameJoined": MessageLookupByLibrary.simpleMessage("Deltar i spelet"),
        "gameMasterOnlyAllowedInPrivateGames":
            MessageLookupByLibrary.simpleMessage(
                "Spelledare endast möjligt i privata spel (risk för missbruk)."),
        "gameVariant_Var_": m6,
        "groupChat": MessageLookupByLibrary.simpleMessage("Gruppchat"),
        "groupChatDisabled":
            MessageLookupByLibrary.simpleMessage("Gruppchat avstängd"),
        "h": MessageLookupByLibrary.simpleMessage("t"),
        "hasAutoReplacements": MessageLookupByLibrary.simpleMessage(
            "Spelare utan order kan bli utbytta"),
        "hasEitherMinRelOrMinQuick": MessageLookupByLibrary.simpleMessage(
            "Har krav på antingen pålitlighet eller snabbhet"),
        "hasExtensions":
            MessageLookupByLibrary.simpleMessage("Har beställda förlängningar"),
        "hasGraceOrExt":
            MessageLookupByLibrary.simpleMessage("Har förlängningar"),
        "hasGracePeriods": MessageLookupByLibrary.simpleMessage(
            "Har automatiska förlängningar"),
        "hasMinimumRating":
            MessageLookupByLibrary.simpleMessage("Har krav på rang"),
        "hasMustering":
            MessageLookupByLibrary.simpleMessage("Börjar med upprop"),
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
        "minimumQuickness_V_": m7,
        "minimumRating_V_": m8,
        "minimumReliability_V_": m9,
        "movement": MessageLookupByLibrary.simpleMessage("Förflyttning"),
        "myGames": MessageLookupByLibrary.simpleMessage("Mina spel"),
        "nationSelection": MessageLookupByLibrary.simpleMessage("Val av land"),
        "nationSelection_Type_": m10,
        "newProfilePictureURL":
            MessageLookupByLibrary.simpleMessage("URL till ny profilbild"),
        "nmrPhases_":
            MessageLookupByLibrary.simpleMessage("Faser med missade order:"),
        "noGamesFound": MessageLookupByLibrary.simpleMessage("Inga spel funna"),
        "nonCommittedPhases_": MessageLookupByLibrary.simpleMessage(
            "Faser utan redo för resolution:"),
        "nonMovementPhaseDeadline_Date_": m11,
        "nonNMRPhases_":
            MessageLookupByLibrary.simpleMessage("Faser med order:"),
        "onlyPlayersAssignedByGM": MessageLookupByLibrary.simpleMessage(
            "Endast spelare godkända av spelledaren kan delta."),
        "openGames": MessageLookupByLibrary.simpleMessage("Öppna spel"),
        "orders": MessageLookupByLibrary.simpleMessage("Order"),
        "phaseDeadline_Date_": m12,
        "players": MessageLookupByLibrary.simpleMessage("Spelare"),
        "preferences": MessageLookupByLibrary.simpleMessage("Prioritetslista"),
        "private": MessageLookupByLibrary.simpleMessage("Privat"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Privat chat"),
        "privateChatDisabled":
            MessageLookupByLibrary.simpleMessage("Privat chat avstängd"),
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "profilePictureUpdated":
            MessageLookupByLibrary.simpleMessage("Profilbild uppdaterad"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Offentlig chat"),
        "publicChatDisabled":
            MessageLookupByLibrary.simpleMessage("Offentlig chat avstängd"),
        "quickness_": MessageLookupByLibrary.simpleMessage("Snabbhet:"),
        "random": MessageLookupByLibrary.simpleMessage("Slumpvis"),
        "rating_": MessageLookupByLibrary.simpleMessage("Rang:"),
        "reliability_": MessageLookupByLibrary.simpleMessage("Pålitlighet:"),
        "requireAssignmentToJoin":
            MessageLookupByLibrary.simpleMessage("Godkännande nödvändigt"),
        "retreat": MessageLookupByLibrary.simpleMessage("Reträtt"),
        "rules_V_": m13,
        "someChatsDisabled":
            MessageLookupByLibrary.simpleMessage("Vissa chattar avstängda"),
        "someoneYouBanned": MessageLookupByLibrary.simpleMessage(
            "Någon du svartlistat, eller någon som svartlistat dig, är redan i spelet"),
        "source": MessageLookupByLibrary.simpleMessage("Källkod"),
        "spring": MessageLookupByLibrary.simpleMessage("Vår"),
        "started_Date_": m14,
        "unableToLoadURL": m15,
        "unnamed": MessageLookupByLibrary.simpleMessage("namnlöst"),
        "username": MessageLookupByLibrary.simpleMessage("Användarnamn"),
        "usernameUpdated":
            MessageLookupByLibrary.simpleMessage("Användarnamn uppdaterat"),
        "username_V_": m16,
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("Se"),
        "votesRequiredForExtension_V_": m17,
        "w": MessageLookupByLibrary.simpleMessage("v"),
        "youAreAlreadyInGame": MessageLookupByLibrary.simpleMessage(
            "Du deltar redan i det här spelet"),
        "youAreNotLoggedIn":
            MessageLookupByLibrary.simpleMessage("Du är inte inloggad"),
        "youDonMatchRequirements": MessageLookupByLibrary.simpleMessage(
            "Din pålitlighet, snabbhet, eller rang motsvarar inte kraven för spelet")
      };
}
