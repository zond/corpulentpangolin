// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(c, p) => "${c} of ${p} players joined";

  static String m1(v) => "Created by: ${v}";

  static String m2(date) => "Created: ${date}";

  static String m3(v) => "Description: ${v}";

  static String m4(err) => "Failed creating game: ${err}";

  static String m5(err) => "Failed saving game: ${err}";

  static String m6(err) => "Failed saving profile: ${err}";

  static String m7(date) => "Finished: ${date}";

  static String m8(variant) => "Game variant: ${variant}";

  static String m9(v) => "Minimum quickness: ${v}";

  static String m10(v) => "Minimum rating: ${v}";

  static String m11(v) => "Minimum reliability: ${v}";

  static String m12(type) => "Nation selection: ${type}";

  static String m13(deadline) => "Non movement phase deadline: ${deadline}";

  static String m14(deadline) => "Phase deadline: ${deadline}";

  static String m15(v) => "Rules: ${v}";

  static String m16(date) => "Started: ${date}";

  static String m17(err) => "Unable to load URL: ${err}";

  static String m18(v) => "Username: ${v}";

  static String m19(v) => "Votes required for extension: ${v}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Adjustment"),
        "anonymous": MessageLookupByLibrary.simpleMessage("Anonymous"),
        "appName": MessageLookupByLibrary.simpleMessage("corpulentpangolin"),
        "army": MessageLookupByLibrary.simpleMessage("Army"),
        "asGameMasterYouCan": MessageLookupByLibrary.simpleMessage(
            "As game master, you can pause/resume games and control who joins (and as what nation). To play yourself, you need to join as a player after creating your game."),
        "c_of_p_playersJoined": m0,
        "cantChangeVariant": MessageLookupByLibrary.simpleMessage(
            "You can\'t change variant of an existing game"),
        "changeProfilePicture":
            MessageLookupByLibrary.simpleMessage("Change profile picture"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "committedPhases_":
            MessageLookupByLibrary.simpleMessage("Committed phases:"),
        "createGame": MessageLookupByLibrary.simpleMessage("Create game"),
        "createdBy_V_": m1,
        "created_Date_": m2,
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "description_V_": m3,
        "edit": MessageLookupByLibrary.simpleMessage("Edit"),
        "editGame": MessageLookupByLibrary.simpleMessage("Edit game"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "failedCreatingGame_Err_": m4,
        "failedSavingGame_Err_": m5,
        "failedSavingProfile_Err_": m6,
        "fall": MessageLookupByLibrary.simpleMessage("Fall"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Finished games"),
        "finished_Date_": m7,
        "fleet": MessageLookupByLibrary.simpleMessage("Fleet"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Game created"),
        "gameFullNoReplacements": MessageLookupByLibrary.simpleMessage(
            "Game is already full and has no replaceable players"),
        "gameJoined": MessageLookupByLibrary.simpleMessage("Game joined"),
        "gameMasterOnlyAllowedInPrivateGames":
            MessageLookupByLibrary.simpleMessage(
                "Game master only allowed in private games due to risk of abuse."),
        "gameVariant_Var_": m8,
        "groupChat": MessageLookupByLibrary.simpleMessage("Group chat"),
        "groupChatDisabled":
            MessageLookupByLibrary.simpleMessage("Group chat disabled"),
        "h": MessageLookupByLibrary.simpleMessage("h"),
        "hasAutoReplacements":
            MessageLookupByLibrary.simpleMessage("NMR players can be replaced"),
        "hasEitherMinRelOrMinQuick": MessageLookupByLibrary.simpleMessage(
            "Has either minimum reliability or minimum quickness"),
        "hasExtensions": MessageLookupByLibrary.simpleMessage("Has extensions"),
        "hasGraceOrExt": MessageLookupByLibrary.simpleMessage(
            "Has grace periods or extensions"),
        "hasGracePeriods":
            MessageLookupByLibrary.simpleMessage("Has grace periods"),
        "hasMinimumRating":
            MessageLookupByLibrary.simpleMessage("Has minimum rating"),
        "hasMustering":
            MessageLookupByLibrary.simpleMessage("Start with roll call"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "join": MessageLookupByLibrary.simpleMessage("Join"),
        "leave": MessageLookupByLibrary.simpleMessage("Leave"),
        "leftGame": MessageLookupByLibrary.simpleMessage("Left game"),
        "liveGames": MessageLookupByLibrary.simpleMessage("Live games"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "logInToSeeYourGames":
            MessageLookupByLibrary.simpleMessage("Log in to see your games"),
        "logInToSeeYourProfile":
            MessageLookupByLibrary.simpleMessage("Log in to see your profile."),
        "loggedIn": MessageLookupByLibrary.simpleMessage("Logged in"),
        "loggedOut": MessageLookupByLibrary.simpleMessage("Logged out"),
        "login": MessageLookupByLibrary.simpleMessage("Log in"),
        "logout": MessageLookupByLibrary.simpleMessage("Log out"),
        "m": MessageLookupByLibrary.simpleMessage("m"),
        "manageAsGameMaster":
            MessageLookupByLibrary.simpleMessage("Manage as game master"),
        "map": MessageLookupByLibrary.simpleMessage("Map"),
        "minimumQuickness_V_": m9,
        "minimumRating_V_": m10,
        "minimumReliability_V_": m11,
        "movement": MessageLookupByLibrary.simpleMessage("Movement"),
        "myGames": MessageLookupByLibrary.simpleMessage("My games"),
        "nationSelection":
            MessageLookupByLibrary.simpleMessage("Nation selection"),
        "nationSelection_Type_": m12,
        "newProfilePictureURL":
            MessageLookupByLibrary.simpleMessage("New profile picture URL"),
        "nmrPhases_": MessageLookupByLibrary.simpleMessage("NMR phases:"),
        "noGamesFound": MessageLookupByLibrary.simpleMessage("No games found"),
        "nonCommittedPhases_":
            MessageLookupByLibrary.simpleMessage("Non committed phases:"),
        "nonMovementPhaseDeadline_Date_": m13,
        "nonNMRPhases_":
            MessageLookupByLibrary.simpleMessage("Non NMR phases:"),
        "onlyPlayersAssignedByGM": MessageLookupByLibrary.simpleMessage(
            "Only players assigned by the game master can join."),
        "openGames": MessageLookupByLibrary.simpleMessage("Open games"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "phaseDeadline_Date_": m14,
        "players": MessageLookupByLibrary.simpleMessage("Players"),
        "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
        "private": MessageLookupByLibrary.simpleMessage("Private"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Private chat"),
        "privateChatDisabled":
            MessageLookupByLibrary.simpleMessage("Private chat disabled"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profileUpdated":
            MessageLookupByLibrary.simpleMessage("Profile updated"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Public chat"),
        "publicChatDisabled":
            MessageLookupByLibrary.simpleMessage("Public chat disabled"),
        "quickness_": MessageLookupByLibrary.simpleMessage("Quickness:"),
        "random": MessageLookupByLibrary.simpleMessage("Random"),
        "rating_": MessageLookupByLibrary.simpleMessage("Rating:"),
        "reliability_": MessageLookupByLibrary.simpleMessage("Reliability:"),
        "requireAssignmentToJoin":
            MessageLookupByLibrary.simpleMessage("Require assignment to join"),
        "retreat": MessageLookupByLibrary.simpleMessage("Retreat"),
        "rules_V_": m15,
        "share": MessageLookupByLibrary.simpleMessage("Share"),
        "someChatsDisabled":
            MessageLookupByLibrary.simpleMessage("Some chats disabled"),
        "someoneYouBanned": MessageLookupByLibrary.simpleMessage(
            "Someone you banned, or someone banned by you, is already in the game"),
        "source": MessageLookupByLibrary.simpleMessage("Source"),
        "spring": MessageLookupByLibrary.simpleMessage("Spring"),
        "started_Date_": m16,
        "unableToLoadURL": m17,
        "unnamed": MessageLookupByLibrary.simpleMessage("unnamed"),
        "username": MessageLookupByLibrary.simpleMessage("Username"),
        "username_V_": m18,
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "votesRequiredForExtension_V_": m19,
        "w": MessageLookupByLibrary.simpleMessage("w"),
        "youAreAlreadyInGame": MessageLookupByLibrary.simpleMessage(
            "You have already joined this game"),
        "youAreNotLoggedIn":
            MessageLookupByLibrary.simpleMessage("You aren\'t logged in"),
        "youCantEditGamesYouDontOwn": MessageLookupByLibrary.simpleMessage(
            "You can\'t edit games you aren\'t game master for"),
        "youCantLeaveStartedGames": MessageLookupByLibrary.simpleMessage(
            "You can\'t leave started games"),
        "youDonMatchRequirements": MessageLookupByLibrary.simpleMessage(
            "Your reliability, quickness, or rating doesn\'t match the requirements for the game")
      };
}
