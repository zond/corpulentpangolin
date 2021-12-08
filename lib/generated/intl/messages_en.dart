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

  static String m4(deadline) => "Phase deadline: ${deadline}";

  static String m5(date) => "Started: ${date}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Adjustment"),
        "army": MessageLookupByLibrary.simpleMessage("Army"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "createGame": MessageLookupByLibrary.simpleMessage("Create game"),
        "created": m0,
        "d": MessageLookupByLibrary.simpleMessage("d"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "error": MessageLookupByLibrary.simpleMessage("Error"),
        "failedCreatingGameErr": m1,
        "fall": MessageLookupByLibrary.simpleMessage("Fall"),
        "finished": m2,
        "finishedGames": MessageLookupByLibrary.simpleMessage("Finished games"),
        "fleet": MessageLookupByLibrary.simpleMessage("Fleet"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Game created"),
        "gameVariant": m3,
        "groupChat": MessageLookupByLibrary.simpleMessage("Group chat"),
        "h": MessageLookupByLibrary.simpleMessage("h"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "invite": MessageLookupByLibrary.simpleMessage("Invite"),
        "join": MessageLookupByLibrary.simpleMessage("Join"),
        "liveGames": MessageLookupByLibrary.simpleMessage("Live games"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "logInToSeeYourGames":
            MessageLookupByLibrary.simpleMessage("Log in to see your games"),
        "loggedIn": MessageLookupByLibrary.simpleMessage("Logged in"),
        "loggedOut": MessageLookupByLibrary.simpleMessage("Logged out"),
        "login": MessageLookupByLibrary.simpleMessage("Log in"),
        "logout": MessageLookupByLibrary.simpleMessage("Log out"),
        "m": MessageLookupByLibrary.simpleMessage("m"),
        "map": MessageLookupByLibrary.simpleMessage("Map"),
        "movement": MessageLookupByLibrary.simpleMessage("Movement"),
        "myGames": MessageLookupByLibrary.simpleMessage("My games"),
        "noGamesFound": MessageLookupByLibrary.simpleMessage("No games found"),
        "openGames": MessageLookupByLibrary.simpleMessage("Open games"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "phaseDeadline": m4,
        "privateChat": MessageLookupByLibrary.simpleMessage("Private chat"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Public chat"),
        "retreat": MessageLookupByLibrary.simpleMessage("Retreat"),
        "source": MessageLookupByLibrary.simpleMessage("Source"),
        "spring": MessageLookupByLibrary.simpleMessage("Spring"),
        "started": m5,
        "unnamed": MessageLookupByLibrary.simpleMessage("unnamed"),
        "variant": MessageLookupByLibrary.simpleMessage("Variant"),
        "view": MessageLookupByLibrary.simpleMessage("View"),
        "w": MessageLookupByLibrary.simpleMessage("w")
      };
}
