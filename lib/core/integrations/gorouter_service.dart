// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../../features/auth/auth_provider.dart';
// import '../../features/config/ui/pages/config_page.dart';
// import '../../features/home/home_provider.dart';
// import '../../features/home/ui/bloc/cubit/home_cubit.dart';
// import '../../features/home/ui/pages/shell_navigator.dart';
// import '../../features/landing/ui/landing_provider.dart';
// import '../../features/profiles_module/school_profile/school_profile_provider.dart';
// import '../../features/profiles_module/team_profile/team_profile_provider.dart';
// import '../../features/profiles_module/user_profile/user_profile_provider.dart';
// import '../../features/reading_module/daily_challenge/daily_challange_provider.dart';
// import '../../features/reading_module/reading_story/reading_story_provider.dart';
// import '../../features/tournament/tournament_provider.dart';
// import '../routes/routes.dart';

// class GoRouterService {
//   static final GlobalKey<NavigatorState> _rootGlobalKey =
//       GlobalKey<NavigatorState>(debugLabel: 'root');
//   static final GlobalKey<NavigatorState> _shellGlobalKey =
//       GlobalKey<NavigatorState>(debugLabel: 'shell');

//   final GoRouter instance;

//   GoRouterService() : instance = _instance;

//   static GoRouter get _instance => GoRouter(
//         navigatorKey: _rootGlobalKey,
//         initialLocation: Routes.home,
//         routes: [
//           GoRoute(
//             path: Routes.root,
//             builder: (context, state) => const LandingProvider(),
//           ),
//           GoRoute(
//             path: Routes.landing,
//             builder: (context, state) => const LandingProvider(),
//           ),
//           GoRoute(
//             path: Routes.login,
//             pageBuilder: (context, state) => const MaterialPage(
//               child: AuthProvider(),
//               fullscreenDialog: true,
//             ),
//           ),
//           ShellRoute(
//               navigatorKey: _shellGlobalKey,
//               builder: (context, state, child) =>
//                   ShellNavigator(key: state.pageKey, child: child),
//               routes: [
//                 GoRoute(
//                   name: 'home',
//                   path: Routes.home,
//                   pageBuilder: (context, state) => const NoTransitionPage(
//                     child: HomeProvider(),
//                   ),
//                 ),
//                 GoRoute(
//                   name: 'userProfile',
//                   path: Routes.userProfile,
//                   pageBuilder: (context, state) => const NoTransitionPage(
//                     child: UserProfileProvider(userId: null),
//                   ),
//                 ),
//                 GoRoute(
//                   name: 'teamProfile',
//                   path: Routes.teamProfile,
//                   pageBuilder: (context, state) => NoTransitionPage(
//                     child: TeamProfileProvider(
//                       teamId: state.params['teamId'] ?? '0',
//                     ),
//                   ),
//                 ),
//                 GoRoute(
//                   name: 'tournament',
//                   path: Routes.tournament,
//                   pageBuilder: (context, state) => const NoTransitionPage(
//                     child: TournamentProvider(),
//                   ),
//                 ),
//                 GoRoute(
//                   name: 'configPage',
//                   path: Routes.config,
//                   pageBuilder: (context, state) => const NoTransitionPage(
//                     child: ConfigPage(),
//                   ),
//                 ),
//               ]),
//           GoRoute(
//             path: Routes.userProfile,
//             builder: (context, state) => UserProfileProvider(
//               userId: state.params['userId'],
//             ),
//           ),
//           GoRoute(
//             name: 'schoolProfile',
//             path: Routes.schoolProfile,
//             builder: (context, state) => SchoolProfileProvider(
//               schoolId: state.params['schoolId'] ?? '0',
//             ),
//           ),
//           GoRoute(
//             name: 'dailyChallenge',
//             path: Routes.dailyChallenge,
//             builder: (context, state) => const DailyChallangeProvider(),
//           ),
//           GoRoute(
//             name: 'story',
//             path: Routes.story,
//             builder: (context, state) => ReadingStoryProvider(
//               storyId: int.tryParse(state.params['storyId'] ?? '0') ?? 0,
//               homeCubit: state.extra != null && state.extra is HomeCubit
//                   ? state.extra as HomeCubit
//                   : null,
//             ),
//           ),
//         ],
//       );
// }
