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
    ChallengesRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ChallengesRouteArgs>(
          orElse: () => ChallengesRouteArgs(
                url: queryParams.optString('url'),
                name: queryParams.optString('name'),
                description: queryParams.optString('description'),
                id: queryParams.optString('id'),
              ));
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: ChallengesProvider(
          key: args.key,
          url: args.url,
          name: args.name,
          description: args.description,
          id: args.id,
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
    ReceivedInviteRoute.name: (routeData) {
      final queryParams = routeData.queryParams;
      final args = routeData.argsAs<ReceivedInviteRouteArgs>(
          orElse: () => ReceivedInviteRouteArgs(
                role: queryParams.optString('role'),
                inviteId: queryParams.optInt('inviteId'),
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
        ),
      );
    },
    ShellRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ShellPage(),
      );
    },
    TournamentRoute.name: (routeData) {
      return AutoRoutePage<bool?>(
        routeData: routeData,
        child: const TournamentProvider(),
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
/// [ChallengesProvider]
class ChallengesRoute extends PageRouteInfo<ChallengesRouteArgs> {
  ChallengesRoute({
    Key? key,
    String? url,
    String? name,
    String? description,
    String? id,
    List<PageRouteInfo>? children,
  }) : super(
          ChallengesRoute.name,
          args: ChallengesRouteArgs(
            key: key,
            url: url,
            name: name,
            description: description,
            id: id,
          ),
          rawQueryParams: {
            'url': url,
            'name': name,
            'description': description,
            'id': id,
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
    this.url,
    this.name,
    this.description,
    this.id,
  });

  final Key? key;

  final String? url;

  final String? name;

  final String? description;

  final String? id;

  @override
  String toString() {
    return 'ChallengesRouteArgs{key: $key, url: $url, name: $name, description: $description, id: $id}';
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
/// [ReceivedInviteProvider]
class ReceivedInviteRoute extends PageRouteInfo<ReceivedInviteRouteArgs> {
  ReceivedInviteRoute({
    Key? key,
    String? role,
    int? inviteId,
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
          rawQueryParams: {
            'role': role,
            'inviteId': inviteId,
            'code': code,
          },
          initialChildren: children,
        );

  static const String name = 'ReceivedInviteRoute';

  static const PageInfo<ReceivedInviteRouteArgs> page =
      PageInfo<ReceivedInviteRouteArgs>(name);
}

class ReceivedInviteRouteArgs {
  const ReceivedInviteRouteArgs({
    this.key,
    this.role,
    this.inviteId,
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
    List<PageRouteInfo>? children,
  }) : super(
          SendInviteRoute.name,
          args: SendInviteRouteArgs(
            key: key,
            typeUserToInvite: typeUserToInvite,
            team: team,
            schoolId: schoolId,
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
  });

  final Key? key;

  final Role typeUserToInvite;

  final Team? team;

  final int? schoolId;

  @override
  String toString() {
    return 'SendInviteRouteArgs{key: $key, typeUserToInvite: $typeUserToInvite, team: $team, schoolId: $schoolId}';
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
    List<PageRouteInfo>? children,
  }) : super(
          ReadingStoryRoute.name,
          args: ReadingStoryRouteArgs(
            key: key,
            storyId: storyId,
            homeCubit: homeCubit,
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
  });

  final Key? key;

  final int storyId;

  final HomeCubit? homeCubit;

  @override
  String toString() {
    return 'ReadingStoryRouteArgs{key: $key, storyId: $storyId, homeCubit: $homeCubit}';
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
