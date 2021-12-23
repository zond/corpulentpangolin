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

  /// `Edit game`
  String get editGame {
    return Intl.message(
      'Edit game',
      name: 'editGame',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
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

  /// `Private chat disabled`
  String get privateChatDisabled {
    return Intl.message(
      'Private chat disabled',
      name: 'privateChatDisabled',
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

  /// `Group chat disabled`
  String get groupChatDisabled {
    return Intl.message(
      'Group chat disabled',
      name: 'groupChatDisabled',
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

  /// `Public chat disabled`
  String get publicChatDisabled {
    return Intl.message(
      'Public chat disabled',
      name: 'publicChatDisabled',
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

  /// `Current phase`
  String get currentPhase {
    return Intl.message(
      'Current phase',
      name: 'currentPhase',
      desc: '',
      args: [],
    );
  }

  /// `Phase length`
  String get phaseLength {
    return Intl.message(
      'Phase length',
      name: 'phaseLength',
      desc: '',
      args: [],
    );
  }

  /// `Different length for non movement phases`
  String get differentPhaseForNonMovement {
    return Intl.message(
      'Different length for non movement phases',
      name: 'differentPhaseForNonMovement',
      desc: '',
      args: [],
    );
  }

  /// `Non movement phase length`
  String get nonMovementPhaseLength {
    return Intl.message(
      'Non movement phase length',
      name: 'nonMovementPhaseLength',
      desc: '',
      args: [],
    );
  }

  /// `Days`
  String get days {
    return Intl.message(
      'Days',
      name: 'days',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Minutes`
  String get minutes {
    return Intl.message(
      'Minutes',
      name: 'minutes',
      desc: '',
      args: [],
    );
  }

  /// `Has game master`
  String get hasGameMaster {
    return Intl.message(
      'Has game master',
      name: 'hasGameMaster',
      desc: '',
      args: [],
    );
  }

  /// `Game updated`
  String get gameUpdated {
    return Intl.message(
      'Game updated',
      name: 'gameUpdated',
      desc: '',
      args: [],
    );
  }

  /// `You can't edit games you aren't game master for`
  String get youCantEditGamesYouDontOwn {
    return Intl.message(
      'You can\'t edit games you aren\'t game master for',
      name: 'youCantEditGamesYouDontOwn',
      desc: '',
      args: [],
    );
  }

  /// `You can't change variant of an existing game`
  String get cantChangeVariant {
    return Intl.message(
      'You can\'t change variant of an existing game',
      name: 'cantChangeVariant',
      desc: '',
      args: [],
    );
  }

  /// `Failed saving game: {err}`
  String failedSavingGame_Err_(Object err) {
    return Intl.message(
      'Failed saving game: $err',
      name: 'failedSavingGame_Err_',
      desc: '',
      args: [err],
    );
  }

  /// `Failed saving profile: {err}`
  String failedSavingProfile_Err_(Object err) {
    return Intl.message(
      'Failed saving profile: $err',
      name: 'failedSavingProfile_Err_',
      desc: '',
      args: [err],
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

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
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

  /// `Nation selection`
  String get nationSelection {
    return Intl.message(
      'Nation selection',
      name: 'nationSelection',
      desc: '',
      args: [],
    );
  }

  /// `Private`
  String get private {
    return Intl.message(
      'Private',
      name: 'private',
      desc: '',
      args: [],
    );
  }

  /// `Manage as game master`
  String get manageAsGameMaster {
    return Intl.message(
      'Manage as game master',
      name: 'manageAsGameMaster',
      desc: '',
      args: [],
    );
  }

  /// `Game master only allowed in private games due to risk of abuse.`
  String get gameMasterOnlyAllowedInPrivateGames {
    return Intl.message(
      'Game master only allowed in private games due to risk of abuse.',
      name: 'gameMasterOnlyAllowedInPrivateGames',
      desc: '',
      args: [],
    );
  }

  /// `As game master, you can pause/resume games and control who joins (and as what nation). To play yourself, you need to join as a player after creating your game.`
  String get asGameMasterYouCan {
    return Intl.message(
      'As game master, you can pause/resume games and control who joins (and as what nation). To play yourself, you need to join as a player after creating your game.',
      name: 'asGameMasterYouCan',
      desc: '',
      args: [],
    );
  }

  /// `Created by: {v}`
  String createdBy_V_(Object v) {
    return Intl.message(
      'Created by: $v',
      name: 'createdBy_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Description: {v}`
  String description_V_(Object v) {
    return Intl.message(
      'Description: $v',
      name: 'description_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Rules: {v}`
  String rules_V_(Object v) {
    return Intl.message(
      'Rules: $v',
      name: 'rules_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Require assignment to join`
  String get requireAssignmentToJoin {
    return Intl.message(
      'Require assignment to join',
      name: 'requireAssignmentToJoin',
      desc: '',
      args: [],
    );
  }

  /// `Only players assigned by the game master can join.`
  String get onlyPlayersAssignedByGM {
    return Intl.message(
      'Only players assigned by the game master can join.',
      name: 'onlyPlayersAssignedByGM',
      desc: '',
      args: [],
    );
  }

  /// `Players`
  String get players {
    return Intl.message(
      'Players',
      name: 'players',
      desc: '',
      args: [],
    );
  }

  /// `Anonymous`
  String get anonymous {
    return Intl.message(
      'Anonymous',
      name: 'anonymous',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get username {
    return Intl.message(
      'Username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `Username: {v}`
  String username_V_(Object v) {
    return Intl.message(
      'Username: $v',
      name: 'username_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Profile`
  String get profile {
    return Intl.message(
      'Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `corpulentpangolin`
  String get appName {
    return Intl.message(
      'corpulentpangolin',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Change profile picture`
  String get changeProfilePicture {
    return Intl.message(
      'Change profile picture',
      name: 'changeProfilePicture',
      desc: '',
      args: [],
    );
  }

  /// `New profile picture URL`
  String get newProfilePictureURL {
    return Intl.message(
      'New profile picture URL',
      name: 'newProfilePictureURL',
      desc: '',
      args: [],
    );
  }

  /// `Log in to see your profile.`
  String get logInToSeeYourProfile {
    return Intl.message(
      'Log in to see your profile.',
      name: 'logInToSeeYourProfile',
      desc: '',
      args: [],
    );
  }

  /// `Unable to load URL: {err}`
  String unableToLoadURL(Object err) {
    return Intl.message(
      'Unable to load URL: $err',
      name: 'unableToLoadURL',
      desc: '',
      args: [err],
    );
  }

  /// `Profile updated`
  String get profileUpdated {
    return Intl.message(
      'Profile updated',
      name: 'profileUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Reliability:`
  String get reliability_ {
    return Intl.message(
      'Reliability:',
      name: 'reliability_',
      desc: '',
      args: [],
    );
  }

  /// `NMR phases:`
  String get nmrPhases_ {
    return Intl.message(
      'NMR phases:',
      name: 'nmrPhases_',
      desc: '',
      args: [],
    );
  }

  /// `Non NMR phases:`
  String get nonNMRPhases_ {
    return Intl.message(
      'Non NMR phases:',
      name: 'nonNMRPhases_',
      desc: '',
      args: [],
    );
  }

  /// `Quickness:`
  String get quickness_ {
    return Intl.message(
      'Quickness:',
      name: 'quickness_',
      desc: '',
      args: [],
    );
  }

  /// `Committed phases:`
  String get committedPhases_ {
    return Intl.message(
      'Committed phases:',
      name: 'committedPhases_',
      desc: '',
      args: [],
    );
  }

  /// `Non committed phases:`
  String get nonCommittedPhases_ {
    return Intl.message(
      'Non committed phases:',
      name: 'nonCommittedPhases_',
      desc: '',
      args: [],
    );
  }

  /// `Rating:`
  String get rating_ {
    return Intl.message(
      'Rating:',
      name: 'rating_',
      desc: '',
      args: [],
    );
  }

  /// `{c} of {p} players joined`
  String c_of_p_playersJoined(Object c, Object p) {
    return Intl.message(
      '$c of $p players joined',
      name: 'c_of_p_playersJoined',
      desc: '',
      args: [c, p],
    );
  }

  /// `Has either minimum reliability or minimum quickness`
  String get hasEitherMinRelOrMinQuick {
    return Intl.message(
      'Has either minimum reliability or minimum quickness',
      name: 'hasEitherMinRelOrMinQuick',
      desc: '',
      args: [],
    );
  }

  /// `Has minimum rating`
  String get hasMinimumRating {
    return Intl.message(
      'Has minimum rating',
      name: 'hasMinimumRating',
      desc: '',
      args: [],
    );
  }

  /// `Start with roll call`
  String get hasMustering {
    return Intl.message(
      'Start with roll call',
      name: 'hasMustering',
      desc: '',
      args: [],
    );
  }

  /// `NMR players can be replaced`
  String get hasAutoReplacements {
    return Intl.message(
      'NMR players can be replaced',
      name: 'hasAutoReplacements',
      desc: '',
      args: [],
    );
  }

  /// `Has grace periods`
  String get hasGracePeriods {
    return Intl.message(
      'Has grace periods',
      name: 'hasGracePeriods',
      desc: '',
      args: [],
    );
  }

  /// `Has extensions`
  String get hasExtensions {
    return Intl.message(
      'Has extensions',
      name: 'hasExtensions',
      desc: '',
      args: [],
    );
  }

  /// `Has grace periods or extensions`
  String get hasGraceOrExt {
    return Intl.message(
      'Has grace periods or extensions',
      name: 'hasGraceOrExt',
      desc: '',
      args: [],
    );
  }

  /// `Votes required for extension: {v}`
  String votesRequiredForExtension_V_(Object v) {
    return Intl.message(
      'Votes required for extension: $v',
      name: 'votesRequiredForExtension_V_',
      desc: '',
      args: [v],
    );
  }

  /// `Some chats disabled`
  String get someChatsDisabled {
    return Intl.message(
      'Some chats disabled',
      name: 'someChatsDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Someone you banned, or someone banned by you, is already in the game`
  String get someoneYouBanned {
    return Intl.message(
      'Someone you banned, or someone banned by you, is already in the game',
      name: 'someoneYouBanned',
      desc: '',
      args: [],
    );
  }

  /// `Your reliability, quickness, or rating doesn't match the requirements for the game`
  String get youDonMatchRequirements {
    return Intl.message(
      'Your reliability, quickness, or rating doesn\'t match the requirements for the game',
      name: 'youDonMatchRequirements',
      desc: '',
      args: [],
    );
  }

  /// `You have already joined this game`
  String get youAreAlreadyInGame {
    return Intl.message(
      'You have already joined this game',
      name: 'youAreAlreadyInGame',
      desc: '',
      args: [],
    );
  }

  /// `Game is already full and has no replaceable players`
  String get gameFullNoReplacements {
    return Intl.message(
      'Game is already full and has no replaceable players',
      name: 'gameFullNoReplacements',
      desc: '',
      args: [],
    );
  }

  /// `You aren't logged in`
  String get youAreNotLoggedIn {
    return Intl.message(
      'You aren\'t logged in',
      name: 'youAreNotLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Game joined`
  String get gameJoined {
    return Intl.message(
      'Game joined',
      name: 'gameJoined',
      desc: '',
      args: [],
    );
  }

  /// `Leave`
  String get leave {
    return Intl.message(
      'Leave',
      name: 'leave',
      desc: '',
      args: [],
    );
  }

  /// `You can't leave started games`
  String get youCantLeaveStartedGames {
    return Intl.message(
      'You can\'t leave started games',
      name: 'youCantLeaveStartedGames',
      desc: '',
      args: [],
    );
  }

  /// `Left game`
  String get leftGame {
    return Intl.message(
      'Left game',
      name: 'leftGame',
      desc: '',
      args: [],
    );
  }

  /// `Limit the time of day when the game can start`
  String get limitWhenGameStarts {
    return Intl.message(
      'Limit the time of day when the game can start',
      name: 'limitWhenGameStarts',
      desc: '',
      args: [],
    );
  }

  /// `Only start the game between {F} and {T}`
  String onlyStartTheGameBetween_F_and_T(Object F, Object T) {
    return Intl.message(
      'Only start the game between $F and $T',
      name: 'onlyStartTheGameBetween_F_and_T',
      desc: '',
      args: [F, T],
    );
  }

  /// `Don't start the game before`
  String get dontStartGameBefore {
    return Intl.message(
      'Don\'t start the game before',
      name: 'dontStartGameBefore',
      desc: '',
      args: [],
    );
  }

  /// `Don't start the game after`
  String get dontStartGameAfter {
    return Intl.message(
      'Don\'t start the game after',
      name: 'dontStartGameAfter',
      desc: '',
      args: [],
    );
  }

  /// `Allow grace periods`
  String get allowGracePeriods {
    return Intl.message(
      'Allow grace periods',
      name: 'allowGracePeriods',
      desc: '',
      args: [],
    );
  }

  /// `Automatic phase extension when player is inactive`
  String get gracePeriodLength {
    return Intl.message(
      'Automatic phase extension when player is inactive',
      name: 'gracePeriodLength',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of automatic phase extensions per player per game`
  String get gracesPerPlayer {
    return Intl.message(
      'Maximum number of automatic phase extensions per player per game',
      name: 'gracesPerPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of automatic phase extensions per phase`
  String get gracesPerPhase {
    return Intl.message(
      'Maximum number of automatic phase extensions per phase',
      name: 'gracesPerPhase',
      desc: '',
      args: [],
    );
  }

  /// `Allow phase extensions`
  String get allowExtensions {
    return Intl.message(
      'Allow phase extensions',
      name: 'allowExtensions',
      desc: '',
      args: [],
    );
  }

  /// `Maximum length of player initiated phase extension`
  String get maxExtensionLength {
    return Intl.message(
      'Maximum length of player initiated phase extension',
      name: 'maxExtensionLength',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of player initiated phase extensions per player per game`
  String get extensionsPerPlayer {
    return Intl.message(
      'Maximum number of player initiated phase extensions per player per game',
      name: 'extensionsPerPlayer',
      desc: '',
      args: [],
    );
  }

  /// `Maximum number of player initiated phase extensions per phase`
  String get extensionsPerPhase {
    return Intl.message(
      'Maximum number of player initiated phase extensions per phase',
      name: 'extensionsPerPhase',
      desc: '',
      args: [],
    );
  }

  /// `Player votes required for extra player initiated phase extension`
  String get votesRequiredForExtraExtension {
    return Intl.message(
      'Player votes required for extra player initiated phase extension',
      name: 'votesRequiredForExtraExtension',
      desc: '',
      args: [],
    );
  }

  /// `Minimum reliability to join`
  String get minimumReliabilityToJoin {
    return Intl.message(
      'Minimum reliability to join',
      name: 'minimumReliabilityToJoin',
      desc: '',
      args: [],
    );
  }

  /// `Minimum quickness to join`
  String get minimumQuicknessToJoin {
    return Intl.message(
      'Minimum quickness to join',
      name: 'minimumQuicknessToJoin',
      desc: '',
      args: [],
    );
  }

  /// `Minimum rating to join`
  String get minimumRatingToJoin {
    return Intl.message(
      'Minimum rating to join',
      name: 'minimumRatingToJoin',
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
