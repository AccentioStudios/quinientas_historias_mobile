// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'auto_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    CommonInfoRoute.name: (routeData) {
      final args = routeData.argsAs<CommonInfoRouteArgs>(
          orElse: () => const CommonInfoRouteArgs());
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: CommonInfoPage(
          key: args.key,
          headline: args.headline,
          message: args.message,
          svgImagePath: args.svgImagePath,
          riveAnimationPath: args.riveAnimationPath,
          haveBackButton: args.haveBackButton,
          btnLabel: args.btnLabel,
          onBtnTap: args.onBtnTap,
          linkBtnLabel: args.linkBtnLabel,
          linkBtnOnTap: args.linkBtnOnTap,
          withoutBtns: args.withoutBtns,
        ),
      );
    },
    AuthRoute.name: (routeData) {
      final args =
          routeData.argsAs<AuthRouteArgs>(orElse: () => const AuthRouteArgs());
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: AuthProvider(
          key: args.key,
          autoNavigateToShell: args.autoNavigateToShell,
          byPassFirstScreen: args.byPassFirstScreen,
          onResult: args.onResult,
        ),
      );
    },
    ChallengesAdminRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ChallengesAdminRouteArgs>(
          orElse: () => ChallengesAdminRouteArgs(
              testMode: queryParams.optString('testMode')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChallengesAdminProvider(
          key: args.key,
          testMode: args.testMode,
        ),
      );
    },
    ChallengesRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ChallengesRouteArgs>(
          orElse: () => ChallengesRouteArgs(
                id: queryParams.optString('id'),
                url: queryParams.optString('url'),
                storyId: queryParams.optString('storyId'),
                name: queryParams.optString('name'),
                testMode: queryParams.optString('testMode'),
                description: queryParams.optString('description'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChallengesProvider(
          key: args.key,
          id: args.id,
          url: args.url,
          storyId: args.storyId,
          name: args.name,
          testMode: args.testMode,
          description: args.description,
          useHttps: args.useHttps,
        ),
      );
    },
    ChallengesAdminHomeRoute.name: (routeData) {
      final args = routeData.argsAs<ChallengesAdminHomeRouteArgs>(
          orElse: () => const ChallengesAdminHomeRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChallengesAdminHomePage(
          key: args.key,
          testMode: args.testMode,
        ),
      );
    },
    ChallengesAdminRegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChallengesAdminRegisterPage(),
      );
    },
    ChallengesAdminExploreRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ChallengesAdminExplorePage(),
      );
    },
    OnboardingNewChallengeRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingNewChallengeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OnboardingNewChallengePage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    ConfigRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ConfigPage(),
      );
    },
    ExploreStoriesRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ExploreStoriesRouteArgs>(
          orElse: () =>
              ExploreStoriesRouteArgs(search: queryParams.optString('search')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ExploreStoriesProvider(
          key: args.key,
          search: args.search,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeProvider(),
      );
    },
    OnboardingUserRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingUserRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: OnboardingUserPage(
          key: args.key,
          role: args.role,
          onResult: args.onResult,
        ),
      );
    },
    ReceivedInviteRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ReceivedInviteRouteArgs>(
          orElse: () => ReceivedInviteRouteArgs(
                role: pathParams.optString('role'),
                inviteId: pathParams.optInt('inviteId'),
                code: queryParams.optString('code'),
              ));
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: ReceivedInviteProvider(
          key: args.key,
          role: args.role,
          inviteId: args.inviteId,
          code: args.code,
        ),
      );
    },
    SendInviteRoute.name: (routeData) {
      final args = routeData.argsAs<SendInviteRouteArgs>();
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: SendInviteProvider(
          key: args.key,
          typeUserToInvite: args.typeUserToInvite,
          team: args.team,
          schoolId: args.schoolId,
          tournamentId: args.tournamentId,
        ),
      );
    },
    InvitesAdminRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<InvitesAdminRouteArgs>(
          orElse: () =>
              InvitesAdminRouteArgs(role: queryParams.optString('role')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: InvitesAdminPage(
          key: args.key,
          role: args.role,
        ),
      );
    },
    SchoolProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<SchoolProfileRouteArgs>(
          orElse: () =>
              SchoolProfileRouteArgs(schoolId: pathParams.getInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SchoolProfileProvider(
          key: args.key,
          schoolId: args.schoolId,
        ),
      );
    },
    TeamProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<TeamProfileRouteArgs>(
          orElse: () => TeamProfileRouteArgs(teamId: pathParams.optInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TeamProfileProvider(
          key: args.key,
          teamId: args.teamId,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<UserProfileRouteArgs>(
          orElse: () => UserProfileRouteArgs(userId: pathParams.optInt('id')));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: UserProfileProvider(
          key: args.key,
          userId: args.userId,
        ),
      );
    },
    ReadingStoryRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<ReadingStoryRouteArgs>(
          orElse: () =>
              ReadingStoryRouteArgs(storyId: pathParams.getInt('id')));
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: ReadingStoryProvider(
          key: args.key,
          storyId: args.storyId,
          homeCubit: args.homeCubit,
          isQuickView: args.isQuickView,
        ),
      );
    },
    ShellRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShellPage(),
      );
    },
    TournamentAdminRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TournamentAdminProvider(),
      );
    },
    TournamentRoute.name: (routeData) {
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: const TournamentProvider(),
      );
    },
    TournamentAdminEditRoute.name: (routeData) {
      final args = routeData.argsAs<TournamentAdminEditRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TournamentAdminEditPage(
          key: args.key,
          tournament: args.tournament,
        ),
      );
    },
    TournamentAdminHomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TournamentAdminHomePage(),
      );
    },
    TournamentAdminRegisterRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const TournamentAdminRegisterPage(),
      );
    },
    QuizRoute.name: (routeData) {
      final args = routeData.argsAs<QuizRouteArgs>();
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: QuizProvider(
          key: args.key,
          quizItems: args.quizItems,
          onPressedSeeStory: args.onPressedSeeStory,
        ),
      );
    },
    RegisterQuizItemRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterQuizItemRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterQuizItemPage(
          key: args.key,
          story: args.story,
        ),
      );
    },
  };
}

/// generated route for
/// [CommonInfoPage]
class CommonInfoRoute extends PageRouteInfo<CommonInfoRouteArgs> {
  CommonInfoRoute({
    Key? key,
    String headline = 'Oops...',
    String message =
        'Algo sucedió y no sabemos que pasó.\nIntenta nuevamente, quizás ya se solucionó',
    String svgImagePath = 'assets/images/bug-error-image.svg',
    String? riveAnimationPath,
    bool haveBackButton = false,
    String? btnLabel = 'Volver',
    dynamic Function()? onBtnTap,
    String? linkBtnLabel,
    dynamic Function()? linkBtnOnTap,
    bool withoutBtns = false,
    List<PageRouteInfo>? children,
  }) : super(
          CommonInfoRoute.name,
          args: CommonInfoRouteArgs(
            key: key,
            headline: headline,
            message: message,
            svgImagePath: svgImagePath,
            riveAnimationPath: riveAnimationPath,
            haveBackButton: haveBackButton,
            btnLabel: btnLabel,
            onBtnTap: onBtnTap,
            linkBtnLabel: linkBtnLabel,
            linkBtnOnTap: linkBtnOnTap,
            withoutBtns: withoutBtns,
          ),
          initialChildren: children,
        );

  static const String name = 'CommonInfoRoute';

  static const PageInfo<CommonInfoRouteArgs> page =
      PageInfo<CommonInfoRouteArgs>(name);
}

class CommonInfoRouteArgs {
  const CommonInfoRouteArgs({
    this.key,
    this.headline = 'Oops...',
    this.message =
        'Algo sucedió y no sabemos que pasó.\nIntenta nuevamente, quizás ya se solucionó',
    this.svgImagePath = 'assets/images/bug-error-image.svg',
    this.riveAnimationPath,
    this.haveBackButton = false,
    this.btnLabel = 'Volver',
    this.onBtnTap,
    this.linkBtnLabel,
    this.linkBtnOnTap,
    this.withoutBtns = false,
  });

  final Key? key;

  final String headline;

  final String message;

  final String svgImagePath;

  final String? riveAnimationPath;

  final bool haveBackButton;

  final String? btnLabel;

  final dynamic Function()? onBtnTap;

  final String? linkBtnLabel;

  final dynamic Function()? linkBtnOnTap;

  final bool withoutBtns;

  @override
  String toString() {
    return 'CommonInfoRouteArgs{key: $key, headline: $headline, message: $message, svgImagePath: $svgImagePath, riveAnimationPath: $riveAnimationPath, haveBackButton: $haveBackButton, btnLabel: $btnLabel, onBtnTap: $onBtnTap, linkBtnLabel: $linkBtnLabel, linkBtnOnTap: $linkBtnOnTap, withoutBtns: $withoutBtns}';
  }
}

/// generated route for
/// [AuthProvider]
class AuthRoute extends PageRouteInfo<AuthRouteArgs> {
  AuthRoute({
    Key? key,
    bool? autoNavigateToShell,
    bool? byPassFirstScreen,
    dynamic Function(dynamic)? onResult,
    List<PageRouteInfo>? children,
  }) : super(
          AuthRoute.name,
          args: AuthRouteArgs(
            key: key,
            autoNavigateToShell: autoNavigateToShell,
            byPassFirstScreen: byPassFirstScreen,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'AuthRoute';

  static const PageInfo<AuthRouteArgs> page = PageInfo<AuthRouteArgs>(name);
}

class AuthRouteArgs {
  const AuthRouteArgs({
    this.key,
    this.autoNavigateToShell,
    this.byPassFirstScreen,
    this.onResult,
  });

  final Key? key;

  final bool? autoNavigateToShell;

  final bool? byPassFirstScreen;

  final dynamic Function(dynamic)? onResult;

  @override
  String toString() {
    return 'AuthRouteArgs{key: $key, autoNavigateToShell: $autoNavigateToShell, byPassFirstScreen: $byPassFirstScreen, onResult: $onResult}';
  }
}

/// generated route for
/// [ChallengesAdminProvider]
class ChallengesAdminRoute extends PageRouteInfo<ChallengesAdminRouteArgs> {
  ChallengesAdminRoute({
    Key? key,
    String? testMode,
    List<PageRouteInfo>? children,
  }) : super(
          ChallengesAdminRoute.name,
          args: ChallengesAdminRouteArgs(
            key: key,
            testMode: testMode,
          ),
          rawQueryParams: {'testMode': testMode},
          initialChildren: children,
        );

  static const String name = 'ChallengesAdminRoute';

  static const PageInfo<ChallengesAdminRouteArgs> page =
      PageInfo<ChallengesAdminRouteArgs>(name);
}

class ChallengesAdminRouteArgs {
  const ChallengesAdminRouteArgs({
    this.key,
    this.testMode,
  });

  final Key? key;

  final String? testMode;

  @override
  String toString() {
    return 'ChallengesAdminRouteArgs{key: $key, testMode: $testMode}';
  }
}

/// generated route for
/// [ChallengesProvider]
class ChallengesRoute extends PageRouteInfo<ChallengesRouteArgs> {
  ChallengesRoute({
    Key? key,
    String? id,
    String? url,
    String? storyId,
    String? name,
    String? testMode,
    String? description,
    bool? useHttps,
    List<PageRouteInfo>? children,
  }) : super(
          ChallengesRoute.name,
          args: ChallengesRouteArgs(
            key: key,
            id: id,
            url: url,
            storyId: storyId,
            name: name,
            testMode: testMode,
            description: description,
            useHttps: useHttps,
          ),
          rawQueryParams: {
            'id': id,
            'url': url,
            'storyId': storyId,
            'name': name,
            'testMode': testMode,
            'description': description,
          },
          initialChildren: children,
        );

  static const String name = 'ChallengesRoute';

  static const PageInfo<ChallengesRouteArgs> page =
      PageInfo<ChallengesRouteArgs>(name);
}

class ChallengesRouteArgs {
  const ChallengesRouteArgs({
    this.key,
    this.id,
    this.url,
    this.storyId,
    this.name,
    this.testMode,
    this.description,
    this.useHttps,
  });

  final Key? key;

  final String? id;

  final String? url;

  final String? storyId;

  final String? name;

  final String? testMode;

  final String? description;

  final bool? useHttps;

  @override
  String toString() {
    return 'ChallengesRouteArgs{key: $key, id: $id, url: $url, storyId: $storyId, name: $name, testMode: $testMode, description: $description, useHttps: $useHttps}';
  }
}

/// generated route for
/// [ChallengesAdminHomePage]
class ChallengesAdminHomeRoute
    extends PageRouteInfo<ChallengesAdminHomeRouteArgs> {
  ChallengesAdminHomeRoute({
    Key? key,
    String? testMode,
    List<PageRouteInfo>? children,
  }) : super(
          ChallengesAdminHomeRoute.name,
          args: ChallengesAdminHomeRouteArgs(
            key: key,
            testMode: testMode,
          ),
          initialChildren: children,
        );

  static const String name = 'ChallengesAdminHomeRoute';

  static const PageInfo<ChallengesAdminHomeRouteArgs> page =
      PageInfo<ChallengesAdminHomeRouteArgs>(name);
}

class ChallengesAdminHomeRouteArgs {
  const ChallengesAdminHomeRouteArgs({
    this.key,
    this.testMode,
  });

  final Key? key;

  final String? testMode;

  @override
  String toString() {
    return 'ChallengesAdminHomeRouteArgs{key: $key, testMode: $testMode}';
  }
}

/// generated route for
/// [ChallengesAdminRegisterPage]
class ChallengesAdminRegisterRoute extends PageRouteInfo<void> {
  const ChallengesAdminRegisterRoute({List<PageRouteInfo>? children})
      : super(
          ChallengesAdminRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChallengesAdminRegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ChallengesAdminExplorePage]
class ChallengesAdminExploreRoute extends PageRouteInfo<void> {
  const ChallengesAdminExploreRoute({List<PageRouteInfo>? children})
      : super(
          ChallengesAdminExploreRoute.name,
          initialChildren: children,
        );

  static const String name = 'ChallengesAdminExploreRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingNewChallengePage]
class OnboardingNewChallengeRoute
    extends PageRouteInfo<OnboardingNewChallengeRouteArgs> {
  OnboardingNewChallengeRoute({
    Key? key,
    required void Function() onResult,
    List<PageRouteInfo>? children,
  }) : super(
          OnboardingNewChallengeRoute.name,
          args: OnboardingNewChallengeRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingNewChallengeRoute';

  static const PageInfo<OnboardingNewChallengeRouteArgs> page =
      PageInfo<OnboardingNewChallengeRouteArgs>(name);
}

class OnboardingNewChallengeRouteArgs {
  const OnboardingNewChallengeRouteArgs({
    this.key,
    required this.onResult,
  });

  final Key? key;

  final void Function() onResult;

  @override
  String toString() {
    return 'OnboardingNewChallengeRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [ConfigPage]
class ConfigRoute extends PageRouteInfo<void> {
  const ConfigRoute({List<PageRouteInfo>? children})
      : super(
          ConfigRoute.name,
          initialChildren: children,
        );

  static const String name = 'ConfigRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [ExploreStoriesProvider]
class ExploreStoriesRoute extends PageRouteInfo<ExploreStoriesRouteArgs> {
  ExploreStoriesRoute({
    Key? key,
    String? search,
    List<PageRouteInfo>? children,
  }) : super(
          ExploreStoriesRoute.name,
          args: ExploreStoriesRouteArgs(
            key: key,
            search: search,
          ),
          rawQueryParams: {'search': search},
          initialChildren: children,
        );

  static const String name = 'ExploreStoriesRoute';

  static const PageInfo<ExploreStoriesRouteArgs> page =
      PageInfo<ExploreStoriesRouteArgs>(name);
}

class ExploreStoriesRouteArgs {
  const ExploreStoriesRouteArgs({
    this.key,
    this.search,
  });

  final Key? key;

  final String? search;

  @override
  String toString() {
    return 'ExploreStoriesRouteArgs{key: $key, search: $search}';
  }
}

/// generated route for
/// [HomeProvider]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OnboardingUserPage]
class OnboardingUserRoute extends PageRouteInfo<OnboardingUserRouteArgs> {
  OnboardingUserRoute({
    Key? key,
    required Role role,
    required void Function() onResult,
    List<PageRouteInfo>? children,
  }) : super(
          OnboardingUserRoute.name,
          args: OnboardingUserRouteArgs(
            key: key,
            role: role,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingUserRoute';

  static const PageInfo<OnboardingUserRouteArgs> page =
      PageInfo<OnboardingUserRouteArgs>(name);
}

class OnboardingUserRouteArgs {
  const OnboardingUserRouteArgs({
    this.key,
    required this.role,
    required this.onResult,
  });

  final Key? key;

  final Role role;

  final void Function() onResult;

  @override
  String toString() {
    return 'OnboardingUserRouteArgs{key: $key, role: $role, onResult: $onResult}';
  }
}

/// generated route for
/// [ReceivedInviteProvider]
class ReceivedInviteRoute extends PageRouteInfo<ReceivedInviteRouteArgs> {
  ReceivedInviteRoute({
    Key? key,
    required String? role,
    required int? inviteId,
    String? code,
    List<PageRouteInfo>? children,
  }) : super(
          ReceivedInviteRoute.name,
          args: ReceivedInviteRouteArgs(
            key: key,
            role: role,
            inviteId: inviteId,
            code: code,
          ),
          rawPathParams: {
            'role': role,
            'inviteId': inviteId,
          },
          rawQueryParams: {'code': code},
          initialChildren: children,
        );

  static const String name = 'ReceivedInviteRoute';

  static const PageInfo<ReceivedInviteRouteArgs> page =
      PageInfo<ReceivedInviteRouteArgs>(name);
}

class ReceivedInviteRouteArgs {
  const ReceivedInviteRouteArgs({
    this.key,
    required this.role,
    required this.inviteId,
    this.code,
  });

  final Key? key;

  final String? role;

  final int? inviteId;

  final String? code;

  @override
  String toString() {
    return 'ReceivedInviteRouteArgs{key: $key, role: $role, inviteId: $inviteId, code: $code}';
  }
}

/// generated route for
/// [SendInviteProvider]
class SendInviteRoute extends PageRouteInfo<SendInviteRouteArgs> {
  SendInviteRoute({
    Key? key,
    Role typeUserToInvite = Role.reader,
    required Team? team,
    required int? schoolId,
    int? tournamentId,
    List<PageRouteInfo>? children,
  }) : super(
          SendInviteRoute.name,
          args: SendInviteRouteArgs(
            key: key,
            typeUserToInvite: typeUserToInvite,
            team: team,
            schoolId: schoolId,
            tournamentId: tournamentId,
          ),
          initialChildren: children,
        );

  static const String name = 'SendInviteRoute';

  static const PageInfo<SendInviteRouteArgs> page =
      PageInfo<SendInviteRouteArgs>(name);
}

class SendInviteRouteArgs {
  const SendInviteRouteArgs({
    this.key,
    this.typeUserToInvite = Role.reader,
    required this.team,
    required this.schoolId,
    this.tournamentId,
  });

  final Key? key;

  final Role typeUserToInvite;

  final Team? team;

  final int? schoolId;

  final int? tournamentId;

  @override
  String toString() {
    return 'SendInviteRouteArgs{key: $key, typeUserToInvite: $typeUserToInvite, team: $team, schoolId: $schoolId, tournamentId: $tournamentId}';
  }
}

/// generated route for
/// [InvitesAdminPage]
class InvitesAdminRoute extends PageRouteInfo<InvitesAdminRouteArgs> {
  InvitesAdminRoute({
    Key? key,
    String? role,
    List<PageRouteInfo>? children,
  }) : super(
          InvitesAdminRoute.name,
          args: InvitesAdminRouteArgs(
            key: key,
            role: role,
          ),
          rawQueryParams: {'role': role},
          initialChildren: children,
        );

  static const String name = 'InvitesAdminRoute';

  static const PageInfo<InvitesAdminRouteArgs> page =
      PageInfo<InvitesAdminRouteArgs>(name);
}

class InvitesAdminRouteArgs {
  const InvitesAdminRouteArgs({
    this.key,
    this.role,
  });

  final Key? key;

  final String? role;

  @override
  String toString() {
    return 'InvitesAdminRouteArgs{key: $key, role: $role}';
  }
}

/// generated route for
/// [SchoolProfileProvider]
class SchoolProfileRoute extends PageRouteInfo<SchoolProfileRouteArgs> {
  SchoolProfileRoute({
    Key? key,
    required int schoolId,
    List<PageRouteInfo>? children,
  }) : super(
          SchoolProfileRoute.name,
          args: SchoolProfileRouteArgs(
            key: key,
            schoolId: schoolId,
          ),
          rawPathParams: {'id': schoolId},
          initialChildren: children,
        );

  static const String name = 'SchoolProfileRoute';

  static const PageInfo<SchoolProfileRouteArgs> page =
      PageInfo<SchoolProfileRouteArgs>(name);
}

class SchoolProfileRouteArgs {
  const SchoolProfileRouteArgs({
    this.key,
    required this.schoolId,
  });

  final Key? key;

  final int schoolId;

  @override
  String toString() {
    return 'SchoolProfileRouteArgs{key: $key, schoolId: $schoolId}';
  }
}

/// generated route for
/// [TeamProfileProvider]
class TeamProfileRoute extends PageRouteInfo<TeamProfileRouteArgs> {
  TeamProfileRoute({
    Key? key,
    int? teamId,
    List<PageRouteInfo>? children,
  }) : super(
          TeamProfileRoute.name,
          args: TeamProfileRouteArgs(
            key: key,
            teamId: teamId,
          ),
          rawPathParams: {'id': teamId},
          initialChildren: children,
        );

  static const String name = 'TeamProfileRoute';

  static const PageInfo<TeamProfileRouteArgs> page =
      PageInfo<TeamProfileRouteArgs>(name);
}

class TeamProfileRouteArgs {
  const TeamProfileRouteArgs({
    this.key,
    this.teamId,
  });

  final Key? key;

  final int? teamId;

  @override
  String toString() {
    return 'TeamProfileRouteArgs{key: $key, teamId: $teamId}';
  }
}

/// generated route for
/// [UserProfileProvider]
class UserProfileRoute extends PageRouteInfo<UserProfileRouteArgs> {
  UserProfileRoute({
    Key? key,
    int? userId,
    List<PageRouteInfo>? children,
  }) : super(
          UserProfileRoute.name,
          args: UserProfileRouteArgs(
            key: key,
            userId: userId,
          ),
          rawPathParams: {'id': userId},
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<UserProfileRouteArgs> page =
      PageInfo<UserProfileRouteArgs>(name);
}

class UserProfileRouteArgs {
  const UserProfileRouteArgs({
    this.key,
    this.userId,
  });

  final Key? key;

  final int? userId;

  @override
  String toString() {
    return 'UserProfileRouteArgs{key: $key, userId: $userId}';
  }
}

/// generated route for
/// [ReadingStoryProvider]
class ReadingStoryRoute extends PageRouteInfo<ReadingStoryRouteArgs> {
  ReadingStoryRoute({
    Key? key,
    required int storyId,
    HomeCubit? homeCubit,
    bool isQuickView = false,
    List<PageRouteInfo>? children,
  }) : super(
          ReadingStoryRoute.name,
          args: ReadingStoryRouteArgs(
            key: key,
            storyId: storyId,
            homeCubit: homeCubit,
            isQuickView: isQuickView,
          ),
          rawPathParams: {'id': storyId},
          initialChildren: children,
        );

  static const String name = 'ReadingStoryRoute';

  static const PageInfo<ReadingStoryRouteArgs> page =
      PageInfo<ReadingStoryRouteArgs>(name);
}

class ReadingStoryRouteArgs {
  const ReadingStoryRouteArgs({
    this.key,
    required this.storyId,
    this.homeCubit,
    this.isQuickView = false,
  });

  final Key? key;

  final int storyId;

  final HomeCubit? homeCubit;

  final bool isQuickView;

  @override
  String toString() {
    return 'ReadingStoryRouteArgs{key: $key, storyId: $storyId, homeCubit: $homeCubit, isQuickView: $isQuickView}';
  }
}

/// generated route for
/// [ShellPage]
class ShellRoute extends PageRouteInfo<void> {
  const ShellRoute({List<PageRouteInfo>? children})
      : super(
          ShellRoute.name,
          initialChildren: children,
        );

  static const String name = 'ShellRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TournamentAdminProvider]
class TournamentAdminRoute extends PageRouteInfo<void> {
  const TournamentAdminRoute({List<PageRouteInfo>? children})
      : super(
          TournamentAdminRoute.name,
          initialChildren: children,
        );

  static const String name = 'TournamentAdminRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TournamentProvider]
class TournamentRoute extends PageRouteInfo<void> {
  const TournamentRoute({List<PageRouteInfo>? children})
      : super(
          TournamentRoute.name,
          initialChildren: children,
        );

  static const String name = 'TournamentRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TournamentAdminEditPage]
class TournamentAdminEditRoute
    extends PageRouteInfo<TournamentAdminEditRouteArgs> {
  TournamentAdminEditRoute({
    Key? key,
    required Tournament tournament,
    List<PageRouteInfo>? children,
  }) : super(
          TournamentAdminEditRoute.name,
          args: TournamentAdminEditRouteArgs(
            key: key,
            tournament: tournament,
          ),
          initialChildren: children,
        );

  static const String name = 'TournamentAdminEditRoute';

  static const PageInfo<TournamentAdminEditRouteArgs> page =
      PageInfo<TournamentAdminEditRouteArgs>(name);
}

class TournamentAdminEditRouteArgs {
  const TournamentAdminEditRouteArgs({
    this.key,
    required this.tournament,
  });

  final Key? key;

  final Tournament tournament;

  @override
  String toString() {
    return 'TournamentAdminEditRouteArgs{key: $key, tournament: $tournament}';
  }
}

/// generated route for
/// [TournamentAdminHomePage]
class TournamentAdminHomeRoute extends PageRouteInfo<void> {
  const TournamentAdminHomeRoute({List<PageRouteInfo>? children})
      : super(
          TournamentAdminHomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'TournamentAdminHomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TournamentAdminRegisterPage]
class TournamentAdminRegisterRoute extends PageRouteInfo<void> {
  const TournamentAdminRegisterRoute({List<PageRouteInfo>? children})
      : super(
          TournamentAdminRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'TournamentAdminRegisterRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [QuizProvider]
class QuizRoute extends PageRouteInfo<QuizRouteArgs> {
  QuizRoute({
    Key? key,
    required List<QuizItem> quizItems,
    required dynamic Function()? onPressedSeeStory,
    List<PageRouteInfo>? children,
  }) : super(
          QuizRoute.name,
          args: QuizRouteArgs(
            key: key,
            quizItems: quizItems,
            onPressedSeeStory: onPressedSeeStory,
          ),
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static const PageInfo<QuizRouteArgs> page = PageInfo<QuizRouteArgs>(name);
}

class QuizRouteArgs {
  const QuizRouteArgs({
    this.key,
    required this.quizItems,
    required this.onPressedSeeStory,
  });

  final Key? key;

  final List<QuizItem> quizItems;

  final dynamic Function()? onPressedSeeStory;

  @override
  String toString() {
    return 'QuizRouteArgs{key: $key, quizItems: $quizItems, onPressedSeeStory: $onPressedSeeStory}';
  }
}

/// generated route for
/// [RegisterQuizItemPage]
class RegisterQuizItemRoute extends PageRouteInfo<RegisterQuizItemRouteArgs> {
  RegisterQuizItemRoute({
    Key? key,
    required Story story,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterQuizItemRoute.name,
          args: RegisterQuizItemRouteArgs(
            key: key,
            story: story,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterQuizItemRoute';

  static const PageInfo<RegisterQuizItemRouteArgs> page =
      PageInfo<RegisterQuizItemRouteArgs>(name);
}

class RegisterQuizItemRouteArgs {
  const RegisterQuizItemRouteArgs({
    this.key,
    required this.story,
  });

  final Key? key;

  final Story story;

  @override
  String toString() {
    return 'RegisterQuizItemRouteArgs{key: $key, story: $story}';
  }
}
