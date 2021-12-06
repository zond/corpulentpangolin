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

  static String m0(err) => "Failed creating game: ${err}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "adjustment": MessageLookupByLibrary.simpleMessage("Adjustment"),
        "army": MessageLookupByLibrary.simpleMessage("Army"),
        "chat": MessageLookupByLibrary.simpleMessage("Chat"),
        "createGame": MessageLookupByLibrary.simpleMessage("Create game"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "failedCreatingGameErr": m0,
        "fall": MessageLookupByLibrary.simpleMessage("Fall"),
        "finishedGames": MessageLookupByLibrary.simpleMessage("Finished games"),
        "fleet": MessageLookupByLibrary.simpleMessage("Fleet"),
        "forum": MessageLookupByLibrary.simpleMessage("Forum"),
        "gameCreated": MessageLookupByLibrary.simpleMessage("Game created"),
        "groupChat": MessageLookupByLibrary.simpleMessage("Group chat"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "liveGames": MessageLookupByLibrary.simpleMessage("Live games"),
        "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
        "logInToSeeYourGames":
            MessageLookupByLibrary.simpleMessage("Log in to see your games"),
        "loggedIn": MessageLookupByLibrary.simpleMessage("Logged in"),
        "loggedOut": MessageLookupByLibrary.simpleMessage("Logged out"),
        "login": MessageLookupByLibrary.simpleMessage("Log in"),
        "logout": MessageLookupByLibrary.simpleMessage("Log out"),
        "map": MessageLookupByLibrary.simpleMessage("Map"),
        "movement": MessageLookupByLibrary.simpleMessage("Movement"),
        "myGames": MessageLookupByLibrary.simpleMessage("My games"),
        "noGamesFound": MessageLookupByLibrary.simpleMessage("No games found"),
        "openGames": MessageLookupByLibrary.simpleMessage("Open games"),
        "orders": MessageLookupByLibrary.simpleMessage("Orders"),
        "privateChat": MessageLookupByLibrary.simpleMessage("Private chat"),
        "publicChat": MessageLookupByLibrary.simpleMessage("Public chat"),
        "retreat": MessageLookupByLibrary.simpleMessage("Retreat"),
        "source": MessageLookupByLibrary.simpleMessage("Source"),
        "spring": MessageLookupByLibrary.simpleMessage("Spring"),
        "unnamed": MessageLookupByLibrary.simpleMessage("unnamed"),
        "variant": MessageLookupByLibrary.simpleMessage("Variant")
      };
}
