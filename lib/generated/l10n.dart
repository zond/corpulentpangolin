// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Chat`
  String get chat {
    return Intl.message(
      'Chat',
      name: 'chat',
      desc: '',
      args: [],
    );
  }

  /// `Create game`
  String get createGame {
    return Intl.message(
      'Create game',
      name: 'createGame',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Variant`
  String get variant {
    return Intl.message(
      'Variant',
      name: 'variant',
      desc: '',
      args: [],
    );
  }

  /// `Private chat`
  String get privateChat {
    return Intl.message(
      'Private chat',
      name: 'privateChat',
      desc: '',
      args: [],
    );
  }

  /// `Group chat`
  String get groupChat {
    return Intl.message(
      'Group chat',
      name: 'groupChat',
      desc: '',
      args: [],
    );
  }

  /// `Public chat`
  String get publicChat {
    return Intl.message(
      'Public chat',
      name: 'publicChat',
      desc: '',
      args: [],
    );
  }

  /// `Game created`
  String get gameCreated {
    return Intl.message(
      'Game created',
      name: 'gameCreated',
      desc: '',
      args: [],
    );
  }

  /// `Failed creating game: {err}`
  String failedCreatingGame_Err_(Object err) {
    return Intl.message(
      'Failed creating game: $err',
      name: 'failedCreatingGame_Err_',
      desc: '',
      args: [err],
    );
  }

  /// `Game variant: {variant}`
  String gameVariant_Var_(Object variant) {
    return Intl.message(
      'Game variant: $variant',
      name: 'gameVariant_Var_',
      desc: '',
      args: [variant],
    );
  }

  /// `Created: {date}`
  String created_Date_(DateTime date) {
    final DateFormat dateDateFormat = DateFormat.yMd(Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      'Created: $dateString',
      name: 'created_Date_',
      desc: '',
      args: [dateString],
    );
  }

  /// `Started: {date}`
  String started_Date_(DateTime date) {
    final DateFormat dateDateFormat = DateFormat.yMd(Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      'Started: $dateString',
      name: 'started_Date_',
      desc: '',
      args: [dateString],
    );
  }

  /// `Finished: {date}`
  String finished_Date_(DateTime date) {
    final DateFormat dateDateFormat = DateFormat.yMd(Intl.getCurrentLocale());
    final String dateString = dateDateFormat.format(date);

    return Intl.message(
      'Finished: $dateString',
      name: 'finished_Date_',
      desc: '',
      args: [dateString],
    );
  }

  /// `Phase deadline: {deadline}`
  String phaseDeadline_Date_(Object deadline) {
    return Intl.message(
      'Phase deadline: $deadline',
      name: 'phaseDeadline_Date_',
      desc: '',
      args: [deadline],
    );
  }

  /// `Non movement phase deadline: {deadline}`
  String nonMovementPhaseDeadline_Date_(Object deadline) {
    return Intl.message(
      'Non movement phase deadline: $deadline',
      name: 'nonMovementPhaseDeadline_Date_',
      desc: '',
      args: [deadline],
    );
  }

  /// `Nation selection: {type}`
  String nationSelection_Type_(Object type) {
    return Intl.message(
      'Nation selection: $type',
      name: 'nationSelection_Type_',
      desc: '',
      args: [type],
    );
  }

  /// `Minimum reliability: {v}`
  String minimumReliability_V_(Object v) {
    return Intl.message(
      'Minimum reliability: $v',
      name: 'minimumReliability_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Minimum quickness: {v}`
  String minimumQuickness_V_(Object v) {
    return Intl.message(
      'Minimum quickness: $v',
      name: 'minimumQuickness_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Minimum rating: {v}`
  String minimumRating_V_(Object v) {
    return Intl.message(
      'Minimum rating: $v',
      name: 'minimumRating_V_',
      desc: '',
      args: [v],
    );
  }

  /// `unnamed`
  String get unnamed {
    return Intl.message(
      'unnamed',
      name: 'unnamed',
      desc: '',
      args: [],
    );
  }

  /// `Spring`
  String get spring {
    return Intl.message(
      'Spring',
      name: 'spring',
      desc: '',
      args: [],
    );
  }

  /// `Fall`
  String get fall {
    return Intl.message(
      'Fall',
      name: 'fall',
      desc: '',
      args: [],
    );
  }

  /// `Adjustment`
  String get adjustment {
    return Intl.message(
      'Adjustment',
      name: 'adjustment',
      desc: '',
      args: [],
    );
  }

  /// `Movement`
  String get movement {
    return Intl.message(
      'Movement',
      name: 'movement',
      desc: '',
      args: [],
    );
  }

  /// `Retreat`
  String get retreat {
    return Intl.message(
      'Retreat',
      name: 'retreat',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `No games found`
  String get noGamesFound {
    return Intl.message(
      'No games found',
      name: 'noGamesFound',
      desc: '',
      args: [],
    );
  }

  /// `Orders`
  String get orders {
    return Intl.message(
      'Orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `Map`
  String get map {
    return Intl.message(
      'Map',
      name: 'map',
      desc: '',
      args: [],
    );
  }

  /// `Log in to see your games`
  String get logInToSeeYourGames {
    return Intl.message(
      'Log in to see your games',
      name: 'logInToSeeYourGames',
      desc: '',
      args: [],
    );
  }

  /// `Open games`
  String get openGames {
    return Intl.message(
      'Open games',
      name: 'openGames',
      desc: '',
      args: [],
    );
  }

  /// `Live games`
  String get liveGames {
    return Intl.message(
      'Live games',
      name: 'liveGames',
      desc: '',
      args: [],
    );
  }

  /// `Finished games`
  String get finishedGames {
    return Intl.message(
      'Finished games',
      name: 'finishedGames',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get login {
    return Intl.message(
      'Log in',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logout {
    return Intl.message(
      'Log out',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Logged out`
  String get loggedOut {
    return Intl.message(
      'Logged out',
      name: 'loggedOut',
      desc: '',
      args: [],
    );
  }

  /// `Logged in`
  String get loggedIn {
    return Intl.message(
      'Logged in',
      name: 'loggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Forum`
  String get forum {
    return Intl.message(
      'Forum',
      name: 'forum',
      desc: '',
      args: [],
    );
  }

  /// `Source`
  String get source {
    return Intl.message(
      'Source',
      name: 'source',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Army`
  String get army {
    return Intl.message(
      'Army',
      name: 'army',
      desc: '',
      args: [],
    );
  }

  /// `Fleet`
  String get fleet {
    return Intl.message(
      'Fleet',
      name: 'fleet',
      desc: '',
      args: [],
    );
  }

  /// `My games`
  String get myGames {
    return Intl.message(
      'My games',
      name: 'myGames',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Join`
  String get join {
    return Intl.message(
      'Join',
      name: 'join',
      desc: '',
      args: [],
    );
  }

  /// `Invite`
  String get invite {
    return Intl.message(
      'Invite',
      name: 'invite',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `w`
  String get w {
    return Intl.message(
      'w',
      name: 'w',
      desc: '',
      args: [],
    );
  }

  /// `d`
  String get d {
    return Intl.message(
      'd',
      name: 'd',
      desc: '',
      args: [],
    );
  }

  /// `h`
  String get h {
    return Intl.message(
      'h',
      name: 'h',
      desc: '',
      args: [],
    );
  }

  /// `m`
  String get m {
    return Intl.message(
      'm',
      name: 'm',
      desc: '',
      args: [],
    );
  }

  /// `Random`
  String get random {
    return Intl.message(
      'Random',
      name: 'random',
      desc: '',
      args: [],
    );
  }

  /// `Preferences`
  String get preferences {
    return Intl.message(
      'Preferences',
      name: 'preferences',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sv'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
