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

  static String m0(date) => "Created: ${date}";

  static String m1(err) => "Failed creating game: ${err}";

  static String m2(date) => "Finished: ${date}";

  static String m3(variant) => "Game variant: ${variant}";

  static String m4(v) => "Minimum quickness: ${v}";

  static String m5(v) => "Minimum rating: ${v}";

  static String m6(v) => "Minimum reliability: ${v}";

  static String m7(type) => "Nation selection: ${type}";

  static String m8(deadline) => "Non movement phase deadline: ${deadline}";

  static String m9(deadline) => "Phase deadline: ${deadline}";

  static String m10(date) => "Started: ${date}";

  static String m11(err) => "Unable to load URL: ${err}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Adjustment"),
        "anonymous": MessageLookupByLibrary.simpleMessage("Anonymous"),
        "appName": MessageLookupByLibrary.simpleMessage("corpulentpangolin"),
        "army": MessageLookupByLibrary.simpleMessage("Army"),
        "asGameMasterYouCan": MessageLookupByLibrary.simpleMessage(
            "As game master, you can pause/resume games and control who joins (and as what nation). To play yourself, you need to join as a player after creating your game."),
        "changeProfilePicture":
            MessageLookupByLibrary.simpleMessage("Change profile picture"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "createGame": MessageLookupByLibrary.simpleMessage("Create game"),
        "createdBy": MessageLookupByLibrary.simpleMessage("Created by:"),
        "created_Date_": m0,
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "description": MessageLookupByLibrary.simpleMessage("Description:"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "failedCreatingGame_Err_": m1,
        "fall": MessageLookupByLibrary.simpleMessage("Fall"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Finished games"),
        "finished_Date_": m2,
        "fleet": MessageLookupByLibrary.simpleMessage("Fleet"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Game created"),
        "gameMasterOnlyAllowedInPrivateGames":
            MessageLookupByLibrary.simpleMessage(
                "Game master only allowed in private games due to risk of abuse."),
        "gameVariant_Var_": m3,
        "groupChat": MessageLookupByLibrary.simpleMessage("Group chat"),
        "h": MessageLookupByLibrary.simpleMessage("h"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "invite": MessageLookupByLibrary.simpleMessage("Invite"),
        "join": MessageLookupByLibrary.simpleMessage("Join"),
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
        "minimumQuickness_V_": m4,
        "minimumRating_V_": m5,
        "minimumReliability_V_": m6,
        "movement": MessageLookupByLibrary.simpleMessage("Movement"),
        "myGames": MessageLookupByLibrary.simpleMessage("My games"),
        "nationSelection":
            MessageLookupByLibrary.simpleMessage("Nation selection"),
        "nationSelection_Type_": m7,
        "newProfilePictureURL":
            MessageLookupByLibrary.simpleMessage("New profile picture URL"),
        "noGamesFound": MessageLookupByLibrary.simpleMessage("No games found"),
        "nonMovementPhaseDeadline_Date_": m8,
        "onlyPlayersAssignedByGM": MessageLookupByLibrary.simpleMessage(
            "Only players assigned by the game master can join."),
        "openGames": MessageLookupByLibrary.simpleMessage("Open games"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "phaseDeadline_Date_": m9,
        "players": MessageLookupByLibrary.simpleMessage("Players"),
        "preferences": MessageLookupByLibrary.simpleMessage("Preferences"),
        "private": MessageLookupByLibrary.simpleMessage("Private"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Private chat"),
        "profile": MessageLookupByLibrary.simpleMessage("Profile"),
        "profilePictureUpdated":
            MessageLookupByLibrary.simpleMessage("Profile picture updated"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Public chat"),
        "random": MessageLookupByLibrary.simpleMessage("Random"),
        "requireAssignmentToJoin":
            MessageLookupByLibrary.simpleMessage("Require assignment to join"),
        "retreat": MessageLookupByLibrary.simpleMessage("Retreat"),
        "source": MessageLookupByLibrary.simpleMessage("Source"),
        "spring": MessageLookupByLibrary.simpleMessage("Spring"),
        "started_Date_": m10,
        "unableToLoadURL": m11,
        "unnamed": MessageLookupByLibrary.simpleMessage("unnamed"),
        "username": MessageLookupByLibrary.simpleMessage("Username:"),
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "w": MessageLookupByLibrary.simpleMessage("w")
      };
}
