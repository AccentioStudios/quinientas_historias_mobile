// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../../core/data/entities/user_entity.dart';
// import '../../../../../core/data/models/leaderboard_model.dart';
// import '../../../../../core/routes/routes.dart';
// import '../../../../../core/ui/widgets/headline.dart';
// import '../../../../../core/ui/widgets/leaderboard_list_item_widget.dart';
// import '../../../../../core/ui/widgets/padding_column.dart';
// import '../../../../../core/ui/widgets/user_avatar.dart';
// import '../../../../../core/utils/constants.dart';
// import '../../../user_profile/user_profile_provider.dart';
// import '../bloc/cubit/team_profile_cubit.dart';

// class UserProfileLeaderboardTeamList extends StatelessWidget {
//   const UserProfileLeaderboardTeamList({Key? key, required this.state})
//       : super(key: key);

//   final TeamProfileState state;

//   @override
//   Widget build(BuildContext context) {
//     final List<LeaderboardModel>? list = state.team?.leaderboard!;
//     return PaddingColumn(
//       padding: const EdgeInsets.only(
//           left: Constants.space16,
//           right: Constants.space16,
//           bottom: Constants.space41),
//       children: [
//         const Headline(
//           marginTop: Constants.space41,
//           label: 'Tablero de posiciones del equipo',
//         ),
//         ListView.separated(
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           physics: const ScrollPhysics(),
//           separatorBuilder: (BuildContext context, int index) =>
//               const SizedBox(height: Constants.space12),
//           itemCount: list!.length,
//           itemBuilder: (BuildContext context, int index) {
//             return LeaderboardListItem(
//               onTap: () => navigateToUserProfile(context, list[index].user),
//               avatarWidget: UserAvatar(
//                 user: list[index].user!,
//               ),
//               label: Flex(
//                 direction: Axis.horizontal,
//                 children: [
//                   AutoSizeText.rich(
//                     TextSpan(
//                       style: DefaultTextStyle.of(context)
//                           .style
//                           .copyWith(fontSize: 15),
//                       children: <TextSpan>[
//                         TextSpan(
//                           text: '#${list[index].position} ',
//                           style: const TextStyle(fontWeight: FontWeight.bold),
//                         ),
//                         TextSpan(
//                             text:
//                                 '${list[index].user?.firstName} ${list[index].user?.lastName}'),
//                       ],
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   list[index].user?.role == Role.captain
//                       ? Padding(
//                           padding:
//                               const EdgeInsets.only(left: Constants.space4),
//                           child: SizedBox(
//                             width: 12,
//                             height: 12,
//                             child:
//                                 SvgPicture.asset('assets/icons/star-icon.svg'),
//                           ),
//                         )
//                       : const SizedBox.shrink()
//                 ],
//               ),
//               secondaryLabel: RichText(
//                 text: TextSpan(
//                   style:
//                       DefaultTextStyle.of(context).style.copyWith(fontSize: 15),
//                   children: <TextSpan>[
//                     TextSpan(
//                       text: '${list[index].user?.score} ',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).colorScheme.primary),
//                     ),
//                     const TextSpan(text: 'puntos - '),
//                     TextSpan(
//                       text: '${list[index].user?.readed}',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Theme.of(context).colorScheme.primary),
//                     ),
//                     const TextSpan(
//                       text: ' leídos',
//                     ),
//                   ],
//                 ),
//               ),
//               // trailingWidget: TournamentPositionArrow(
//               //   number: list[index].changePosition.number,
//               //   arrowPositionDirection: list[index].changePosition.type,
//               // ),
//             );
//           },
//         ),
//       ],
//     );
//   }

//   navigateToUserProfile(BuildContext context, User? user) {
//     if (user != null) {
//       Navigator.pushNamed(
//         context,
//         Routes.userProfile,
//         arguments: UserProfileArguments(
//           user.id,
//         ),
//       );
//     }
//   }
// }
