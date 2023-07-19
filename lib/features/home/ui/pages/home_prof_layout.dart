// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// import '../../../../core/data/entities/school_entity.dart';
// import '../../../../core/data/entities/story_entity.dart';
// import '../../../../core/data/entities/tournament_entity.dart';
// import '../../../../core/data/entities/user_entity.dart';
// import '../../../../core/routes/routes.dart';
// import '../../../../core/ui/widgets/chip.dart';
// import '../../../../core/ui/widgets/headline.dart';
// import '../../../../core/ui/widgets/outlined_card.dart';
// import '../../../../core/ui/widgets/padding_column.dart';
// import '../../../../core/ui/widgets/percentage_progress_bar.dart';
// import '../../../../core/ui/widgets/story_cover.dart';
// import '../../../../core/utils/calculate_things.dart';
// import '../../../../core/utils/constants.dart';
// import '../../../invites/send/send_invite_provider.dart';
// import '../../../profiles_module/school_profile/school_profile_provider.dart';
// import '../../../profiles_module/user_profile/user_profile_provider.dart';
// import '../../../reading_module/reading_story/reading_story_provider.dart';
// import '../bloc/cubit/home_cubit.dart';
// import '../widgets/home_app_bar.dart';

// class HomeProfLayout extends StatelessWidget {
//   const HomeProfLayout(
//       {Key? key, required this.state, required this.getDashboardFunction})
//       : super(key: key);
//   final HomeState state;
//   final Function getDashboardFunction;
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       padding: const EdgeInsets.only(top: 0),
//       physics: const BouncingScrollPhysics(),
//       children: [
//         ProfHeader(
//           state: state,
//           userProfileOnTap: () {
//             _navigateToMyProfilePage(context, state.dashboard?.user);
//           },
//         ),
//         PaddingColumn(
//           padding: const EdgeInsets.symmetric(horizontal: Constants.space16),
//           children: [
//             const SizedBox(height: Constants.space21),
//             OutlinedCard(
//               onTap: () {
//                 _navigateToTournament(context);
//               },
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Text(state.dashboard!.tournament!.title ??
//                         'Torneo de lectura'),
//                   ),
//                   const SizedBox(height: Constants.space12),
//                   PercentageProgressBar(
//                     completedPercentage: CalculateThings.percentage(
//                         100,
//                         calculatePercentageTournament(
//                             state.dashboard!.tournament!)),
//                     backgroundColor: Theme.of(context).colorScheme.background,
//                   ),
//                   const SizedBox(height: Constants.space12),
//                   Text(
//                     'Quedan ${getTournamentDayLeft(state.dashboard!.tournament!)} dias',
//                     style: const TextStyle(fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: Constants.space21),
//             if (state.dashboard?.user.school?.name != null)
//               CustomChip(
//                 svgIconPath: 'assets/icons/school-outline-icon.svg',
//                 title: 'Mi escuela',
//                 body: state.dashboard!.user.school!.name,
//                 onTap: () {
//                   _navigateToMySchoolPage(
//                       context, state.dashboard?.user.school);
//                 },
//               ),
//             Column(
//               children: [
//                 const SizedBox(height: Constants.space16),
//                 CustomChip(
//                   svgIconPath: 'assets/icons/user-plus-outline-icon.svg',
//                   title: 'Invitar Capitanes',
//                   body:
//                       'Invita a capitanes para que formen equipos en la escuela',
//                   onTap: () {
//                     navigateToInviteCaptains(context,
//                         schoolId: state.dashboard?.user.school?.id);
//                   },
//                 ),
//                 const SizedBox(height: Constants.space16),
//                 CustomChip(
//                   svgIconPath: 'assets/icons/user-plus-outline-icon.svg',
//                   title: 'Invitar Lectores',
//                   body:
//                       'Invita a lectores a formar parte de un equipo particular',
//                   onTap: () {
//                     navigateToInviteReaders(context,
//                         schoolId: state.dashboard?.user.school?.id);
//                   },
//                 ),
//               ],
//             ),
//             const Headline(
//               label: 'Explorar Lecturas',
//               // linkText: 'Ver más',
//               // onTap: () {},
//             ),
//             if (state.dashboard != null)
//               if (state.dashboard?.exploreStories != null)
//                 GridView.count(
//                   padding: EdgeInsets.zero,
//                   physics: const NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   crossAxisSpacing: Constants.space12,
//                   mainAxisSpacing: Constants.space12,
//                   childAspectRatio: 109 / 147,
//                   crossAxisCount: 3,
//                   children: [
//                     ...state.dashboard!.exploreStories
//                         .map((story) => StoryCover(
//                               story: story,
//                               onTap: () {
//                                 _navigateToStoryPage(context, story);
//                               },
//                             )),
//                   ],
//                 ),
//             const SizedBox(height: Constants.space16),
//           ],
//         ),
//       ],
//     );
//   }

//   void navigateToInviteCaptains(BuildContext context,
//       {required int? schoolId}) {
//     if (schoolId != null) {
//       SendInviteProvider.open(context,
//               schoolId: schoolId, typeUserToInvite: UserType.captain)
//           .then((refresh) {
//         if (refresh == true) {
//           getDashboardFunction();
//         }
//       });
//     } else {
//       Fluttertoast.cancel();
//       Fluttertoast.showToast(
//           msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
//     }
//   }

//   void navigateToInviteReaders(BuildContext context, {required int? schoolId}) {
//     if (schoolId != null) {
//       SendInviteProvider.inviteReadersProf(context, schoolId: schoolId)
//           .then((refresh) {
//         if (refresh == true) {
//           getDashboardFunction();
//         }
//       });
//     } else {
//       Fluttertoast.cancel();
//       Fluttertoast.showToast(
//           msg: 'Error: No tienes escuela, entra en contacto con nosotros.');
//     }
//   }

//   void _navigateToStoryPage(
//     BuildContext context,
//     Story story,
//   ) {
//     Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
//         builder: (_) => ReadingStoryProvider(
//               homeCubit: BlocProvider.of<HomeCubit>(context),
//               storyId: story.id,
//             )));
//   }

//   int calculatePercentageTournament(Tournament tournament) {
//     var initDate = tournament.createdAt;
//     var endDate = tournament.endsAt;
//     var today = DateTime.now();

//     var from = DateTime(initDate.year, initDate.month, initDate.day);
//     var to = DateTime(endDate.year, endDate.month, endDate.day);

//     var daysDifferenceFromTodayDate =
//         (to.difference(today).inHours / 24).round();

//     var daysDifferenceFromInitDate = (to.difference(from).inHours / 24).round();

//     return (daysDifferenceFromTodayDate * 100 / daysDifferenceFromInitDate)
//         .round();
//   }

//   int getTournamentDayLeft(Tournament tournament) {
//     var endDate = tournament.endsAt;
//     var today = DateTime.now();
//     var to = DateTime(endDate.year, endDate.month, endDate.day);

//     var daysDifferenceFromTodayDate =
//         (to.difference(today).inHours / 24).round();

//     return daysDifferenceFromTodayDate;
//   }

//   void _navigateToMySchoolPage(BuildContext context, School? mySchool) {
//     if (mySchool != null) {
//       Navigator.pushNamed<void>(
//         context,
//         Routes.schoolProfile,
//         arguments: SchoolProfileArguments(
//           mySchool.id,
//         ),
//       ).then((value) => getDashboardFunction());
//     }
//   }

//   void _navigateToMyProfilePage(BuildContext context, User? myUser) {
//     if (myUser != null) {
//       Navigator.pushNamed(
//         context,
//         Routes.userProfile,
//         arguments: UserProfileArguments(
//           myUser.id,
//         ),
//       );
//     }
//   }

//   void _navigateToTournament(BuildContext context) {
//     Navigator.pushNamed(
//       context,
//       Routes.tournament,
//     );
//   }
// }

// class ProfHeader extends StatelessWidget {
//   const ProfHeader(
//       {Key? key, required this.state, required this.userProfileOnTap})
//       : super(key: key);
//   final HomeState state;
//   final GestureTapCallback? userProfileOnTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.sizeOf(context).width,
//       height: 84 + MediaQuery.paddingOf(context).top,
//       padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
//       decoration: BoxDecoration(
//         borderRadius: const BorderRadius.only(
//             bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
//         color: Theme.of(context).colorScheme.primaryContainer,
//       ),
//       child: Column(children: [
//         HomeAppBar(
//           user: state.dashboard?.user,
//           onTap: userProfileOnTap,
//           hideStreak: true,
//         ),
//       ]),
//     );
//   }
// }
