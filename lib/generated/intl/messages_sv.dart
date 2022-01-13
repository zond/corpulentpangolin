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

  static String m4(date) => "Avslutat: ${date}";

  static String m5(variant) => "Spelvariant: ${variant}";

  static String m6(v) => "Nödvändig snabbhet: ${v}";

  static String m7(v) => "Nödvändig rang: ${v}";

  static String m8(v) => "Nödvändig pålitlighet: ${v}";

  static String m9(type) => "Val av land: ${type}";

  static String m10(deadline) => "Faslängd ej förflyttning: ${deadline}";

  static String m11(F, T) => "Starta endast spelet mellan ${F} och ${T}";

  static String m12(deadline) => "Faslängd: ${deadline}";

  static String m13(v) => "Regler: ${v}";

  static String m14(date) => "Started: ${date}";

  static String m15(err) => "Kunde ej ladda URL: ${err}";

  static String m16(v) => "Användarnamn: ${v}";

  static String m17(v) => "Röster nödvändiga för förlängning: ${v}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Justering"),
        "allowExtensions":
            MessageLookupByLibrary.simpleMessage("Spelarvalda förlängningar"),
        "allowGracePeriods":
            MessageLookupByLibrary.simpleMessage("Automatiska förlängningar"),
        "anonymous": MessageLookupByLibrary.simpleMessage("Anonym"),
        "appName": MessageLookupByLibrary.simpleMessage("corpulentpangolin"),
        "army": MessageLookupByLibrary.simpleMessage("Armé"),
        "asGameMasterYouCan": MessageLookupByLibrary.simpleMessage(
            "Som spelledare kan du pausa/starta spel samt kontrollera vilka som deltar (och som vilket land). För att själva spela måste du delta som spelare efter att ha skapat spelet."),
        "c_of_p_playersJoined": m0,
        "cantChangeVariant": MessageLookupByLibrary.simpleMessage(
            "Du kan inte byta variant på ett existerande spel"),
        "changeProfilePicture":
            MessageLookupByLibrary.simpleMessage("Ändra profilbil"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "committedPhases_":
            MessageLookupByLibrary.simpleMessage("Faser redo för resolution:"),
        "copiedToClipboard":
            MessageLookupByLibrary.simpleMessage("Kopierat till urklipp"),
        "createGame": MessageLookupByLibrary.simpleMessage("Skapa spel"),
        "createdBy_V_": m1,
        "created_Date_": m2,
        "currentPhase": MessageLookupByLibrary.simpleMessage("Nuvarande fas"),
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "days": MessageLookupByLibrary.simpleMessage("Dagar"),
        "description": MessageLookupByLibrary.simpleMessage("Beskrivning"),
        "description_V_": m3,
        "differentPhaseForNonMovement": MessageLookupByLibrary.simpleMessage(
            "Annan längd för icke-förlyttningsfaser"),
        "dontStartGameAfter":
            MessageLookupByLibrary.simpleMessage("Starta inte spelet efter"),
        "dontStartGameBefore":
            MessageLookupByLibrary.simpleMessage("Starta inte spelet innan"),
        "edit": MessageLookupByLibrary.simpleMessage("Redigera"),
        "editGame": MessageLookupByLibrary.simpleMessage("Redigera spel"),
        "error": MessageLookupByLibrary.simpleMessage("Fel"),
        "extensionsPerPhase": MessageLookupByLibrary.simpleMessage(
            "Maximalt antal spelarvalda förlängningar per fas"),
        "extensionsPerPlayer": MessageLookupByLibrary.simpleMessage(
            "Maximalt antal spelarvalda förlängningar per spelare per spel"),
        "fall": MessageLookupByLibrary.simpleMessage("Höst"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Avslutade spel"),
        "finished_Date_": m4,
        "fleet": MessageLookupByLibrary.simpleMessage("Flotta"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Spel skapat"),
        "gameFull":
            MessageLookupByLibrary.simpleMessage("Spelet är redan fullt"),
        "gameJoined": MessageLookupByLibrary.simpleMessage("Deltar i spelet"),
        "gameMasterOnlyAllowedInPrivateGames":
            MessageLookupByLibrary.simpleMessage(
                "Spelledare endast möjligt i privata spel (risk för missbruk)."),
        "gameUpdated": MessageLookupByLibrary.simpleMessage("Spel uppdaterat"),
        "gameVariant_Var_": m5,
        "gracePeriodLength": MessageLookupByLibrary.simpleMessage(
            "Automatisk förlängning när en spelare är inaktiv"),
        "gracesPerPhase": MessageLookupByLibrary.simpleMessage(
            "Maximalt antal automatiska förlängningar per fas"),
        "gracesPerPlayer": MessageLookupByLibrary.simpleMessage(
            "Maximalt antal automatiska förlängningar per spelare per spel"),
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
        "hasGameMaster": MessageLookupByLibrary.simpleMessage("Har spelledare"),
        "hasGraceOrExt":
            MessageLookupByLibrary.simpleMessage("Har förlängningar"),
        "hasGracePeriods": MessageLookupByLibrary.simpleMessage(
            "Har automatiska förlängningar"),
        "hasMinimumRating":
            MessageLookupByLibrary.simpleMessage("Har krav på rang"),
        "hasMustering":
            MessageLookupByLibrary.simpleMessage("Börjar med upprop"),
        "home": MessageLookupByLibrary.simpleMessage("Hem"),
        "hours": MessageLookupByLibrary.simpleMessage("Timmar"),
        "join": MessageLookupByLibrary.simpleMessage("Delta"),
        "leave": MessageLookupByLibrary.simpleMessage("Lämna"),
        "leftGame": MessageLookupByLibrary.simpleMessage("Lämnade spelet"),
        "limitWhenGameStarts": MessageLookupByLibrary.simpleMessage(
            "Begränsa tiden på dygnet då spelet kan starta"),
        "liveGames": MessageLookupByLibrary.simpleMessage("Pågående spel"),
        "loading": MessageLookupByLibrary.simpleMessage("Laddar..."),
        "logInToEnableThisButton": MessageLookupByLibrary.simpleMessage(
            "Logga in för att aktivera den här knappen"),
        "logInToSeeYourGames": MessageLookupByLibrary.simpleMessage(
            "Logga in för att se dina spel"),
        "logInToSeeYourProfile": MessageLookupByLibrary.simpleMessage(
            "Logga in för att se din profil."),
        "loggedIn": MessageLookupByLibrary.simpleMessage("Loggade in"),
        "loggedInAs": MessageLookupByLibrary.simpleMessage("Inloggad som"),
        "loggedOut": MessageLookupByLibrary.simpleMessage("Loggade ut"),
        "login": MessageLookupByLibrary.simpleMessage("Logga in"),
        "logout": MessageLookupByLibrary.simpleMessage("Logga ut"),
        "m": MessageLookupByLibrary.simpleMessage("m"),
        "manageAsGameMaster":
            MessageLookupByLibrary.simpleMessage("Administrera som spelledare"),
        "map": MessageLookupByLibrary.simpleMessage("Karta"),
        "markedAsReady":
            MessageLookupByLibrary.simpleMessage("Markerad som redo"),
        "maxExtensionLength": MessageLookupByLibrary.simpleMessage(
            "Maximal längd av spelarvald förlängning"),
        "minimumQuicknessToJoin": MessageLookupByLibrary.simpleMessage(
            "Nödvändig snabbhet för att delta"),
        "minimumQuickness_V_": m6,
        "minimumRatingToJoin": MessageLookupByLibrary.simpleMessage(
            "Nödvändig rang för att delta"),
        "minimumRating_V_": m7,
        "minimumReliabilityToJoin": MessageLookupByLibrary.simpleMessage(
            "Nödvändig pålitlighet för att delta"),
        "minimumReliability_V_": m8,
        "minutes": MessageLookupByLibrary.simpleMessage("Minuter"),
        "movement": MessageLookupByLibrary.simpleMessage("Förflyttning"),
        "myGames": MessageLookupByLibrary.simpleMessage("Mina spel"),
        "nation": MessageLookupByLibrary.simpleMessage("Nation"),
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
        "nonMovementPhaseLength": MessageLookupByLibrary.simpleMessage(
            "Faslängd för icke-förflyttningsfaser"),
        "nonNMRPhases_":
            MessageLookupByLibrary.simpleMessage("Faser med order:"),
        "onlyPlayersAssignedByGM": MessageLookupByLibrary.simpleMessage(
            "Endast spelare godkända av spelledaren kan delta."),
        "onlyStartTheGameBetween_F_and_T": m11,
        "openGames": MessageLookupByLibrary.simpleMessage("Öppna spel"),
        "orders": MessageLookupByLibrary.simpleMessage("Order"),
        "phaseDeadline_Date_": m12,
        "phaseLength": MessageLookupByLibrary.simpleMessage("Faslängd"),
        "players": MessageLookupByLibrary.simpleMessage("Spelare"),
        "preferences": MessageLookupByLibrary.simpleMessage("Prioritetslista"),
        "private": MessageLookupByLibrary.simpleMessage("Privat"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Privat chat"),
        "privateChatDisabled":
            MessageLookupByLibrary.simpleMessage("Privat chat avstängd"),
        "profile": MessageLookupByLibrary.simpleMessage("Profil"),
        "profileUpdated":
            MessageLookupByLibrary.simpleMessage("Profil updaterad"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Offentlig chat"),
        "publicChatDisabled":
            MessageLookupByLibrary.simpleMessage("Offentlig chat avstängd"),
        "quickness_": MessageLookupByLibrary.simpleMessage("Snabbhet:"),
        "random": MessageLookupByLibrary.simpleMessage("Slumpvis"),
        "rating_": MessageLookupByLibrary.simpleMessage("Rang:"),
        "readyToStart": MessageLookupByLibrary.simpleMessage("Redo"),
        "reliability_": MessageLookupByLibrary.simpleMessage("Pålitlighet:"),
        "requireAssignmentToJoin":
            MessageLookupByLibrary.simpleMessage("Godkännande nödvändigt"),
        "retreat": MessageLookupByLibrary.simpleMessage("Reträtt"),
        "rules_V_": m13,
        "share": MessageLookupByLibrary.simpleMessage("Dela"),
        "someChatsDisabled":
            MessageLookupByLibrary.simpleMessage("Vissa chattar avstängda"),
        "someoneYouBanned": MessageLookupByLibrary.simpleMessage(
            "Någon du svartlistat, eller någon som svartlistat dig, är redan i spelet"),
        "source": MessageLookupByLibrary.simpleMessage("Källkod"),
        "spring": MessageLookupByLibrary.simpleMessage("Vår"),
        "started_Date_": m14,
        "thisGameRequiresAnInvitation": MessageLookupByLibrary.simpleMessage(
            "Det här spelet kräver en inbjudan för att delta"),
        "unableToLoadURL": m15,
        "unnamed": MessageLookupByLibrary.simpleMessage("namnlöst"),
        "unspecified": MessageLookupByLibrary.simpleMessage("Ospecificerat"),
        "userID": MessageLookupByLibrary.simpleMessage("Användar-ID"),
        "username": MessageLookupByLibrary.simpleMessage("Användarnamn"),
        "username_V_": m16,
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("Se"),
        "votesRequiredForExtension_V_": m17,
        "votesRequiredForExtraExtension": MessageLookupByLibrary.simpleMessage(
            "Röster nödvändiga för extra spelarvalda förlängningar"),
        "w": MessageLookupByLibrary.simpleMessage("v"),
        "youAreAlreadyInGame": MessageLookupByLibrary.simpleMessage(
            "Du deltar redan i det här spelet"),
        "youAreNotAMemberOfThisGame": MessageLookupByLibrary.simpleMessage(
            "Du är inte en medlem i det här spelet"),
        "youAreNotLoggedIn":
            MessageLookupByLibrary.simpleMessage("Du är inte inloggad"),
        "youCantEditGamesYouDontOwn": MessageLookupByLibrary.simpleMessage(
            "Du kan inte redigera spel du inte är spelledare för"),
        "youCantLeaveStartedGames": MessageLookupByLibrary.simpleMessage(
            "Du kan inte lämna startade spel"),
        "youDonMatchRequirements": MessageLookupByLibrary.simpleMessage(
            "Din pålitlighet, snabbhet, eller rang motsvarar inte kraven för spelet")
      };
}
