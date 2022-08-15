import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/school_profile_provider.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/ui/pages/school_profile_page.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/team_profile_provider.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/user_profile_provider.dart';

import '../../../../core/data/entities/school_entity.dart';
import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/data/entities/team_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/failures/auth_failure.dart';
import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/arrow_leaderboard.dart';
import '../../../../core/ui/widgets/big_chip.dart';
import '../../../../core/ui/widgets/buttom_bar.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../reading_module/daily_challenge/daily_challange_provider.dart';
import '../../../reading_module/reading_story/reading_story_provider.dart';
import '../bloc/cubit/home_cubit.dart';
import '../components/header_card_component.dart';

class HomePage extends StatefulWidget with ErrorHandling, SheetMessages {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    getDashboard(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final HomeCubit cubit = BlocProvider.of<HomeCubit>(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          // extendBody: true,
          floatingActionButton: FloatingActionBtnDocked(
            onPressed: () {
              _navigateToDailyChallengePage(context, state, cubit);
            },
          ),
          bottomNavigationBar: const AppButtonBar(
            activeOption: ActiveOptionAppButtonBar.home,
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: state.loading && state.user == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await getDashboard(context);
                  },
                  child: ListView(
                    padding: const EdgeInsets.only(top: 0),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      HeaderCard(
                        state: state,
                        userProfileOnTap: () {
                          _navigateToMyProfilePage(state.user);
                        },
                        dailyChallengeOnTap: () {
                          _navigateToDailyChallengePage(context, state, cubit);
                        },
                      ),
                      const SizedBox(height: Constants.space21),
                      PaddingColumn(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space18),
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              HomePositionsChip(
                                onTap: () {
                                  _navigateToMyTeamPage(state.user?.team);
                                },
                                label: 'Mi equipo',
                                position: '8',
                                content: state.user?.team?.name ?? '',
                                arrowLeaderBoard: const ArrowLeaderBoard(
                                  number: 2,
                                ),
                              ),
                              const SizedBox(width: Constants.space18),
                              HomePositionsChip(
                                onTap: () {
                                  _navigateToMySchoolPage(state.user?.school);
                                },
                                label: 'Mi escuela',
                                position: '4',
                                content: state.user?.school?.name ?? '',
                                arrowLeaderBoard:
                                    const ArrowLeaderBoard(number: 1),
                              ),
                            ],
                          ),
                          Headline(
                            label: 'Explorar Lecturas',
                            linkText: 'Ver más',
                            onTap: () {},
                          ),
                          GridView.count(
                            padding: EdgeInsets.zero,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisSpacing: Constants.space12,
                            mainAxisSpacing: Constants.space12,
                            childAspectRatio: 109 / 147,
                            crossAxisCount: 3,
                            children: [
                              ...state.exploreStories.map((story) => StoryCover(
                                    story: story,
                                    onTap: () {
                                      _navigateToStoryPage(context, story);
                                    },
                                  )),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: Constants.space41 + 70)
                    ],
                  ),
                ),
        );
      },
    );
  }

  void _navigateToMySchoolPage(School? mySchool) {
    if (mySchool != null) {
      Navigator.pushNamed(
        context,
        Routes.schoolProfile,
        arguments: SchoolProfileArguments(
          mySchool.id,
        ),
      );
    }
  }

  void _navigateToMyTeamPage(Team? myTeam) {
    if (myTeam != null) {
      Navigator.pushNamed(
        context,
        Routes.teamProfile,
        arguments: TeamProfileArguments(
          myTeam.id,
        ),
      );
    }
  }

  void _navigateToMyProfilePage(User? myUser) {
    if (myUser != null) {
      Navigator.pushNamed(
        context,
        Routes.userProfile,
        arguments: UserProfileArguments(
          myUser.id,
        ),
      );
    }
  }

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => ReadingStoryProvider(
              homeCubit: BlocProvider.of<HomeCubit>(context),
              storyId: story.id,
            )));
  }

  void _navigateToDailyChallengePage(
    BuildContext context,
    HomeState state,
    HomeCubit cubit, {
    bool softGenerateNewChallenge = false,
    bool forceGenerateNewChallenge = false,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => DailyChallangeProvider(
              homeCubit: cubit,
              dailyChallenge: state.dailyChallenge,
              softGenerateNewChallenge: softGenerateNewChallenge,
              forceGenerateNewChallenge: forceGenerateNewChallenge,
            )));
  }

  void logout() {
    const secureStorage = FlutterSecureStorage();
    secureStorage.deleteAll();
  }

  Future<dynamic> getDashboard(BuildContext context, {HomeState? state}) {
    var completer = Completer();
    BlocProvider.of<HomeCubit>(context).getDashboard(
        onSuccess: (dashboard) async {
      if (dashboard.dailyChallenge != null) {
        if (dashboard.dailyChallenge!.hasOldChallengeIncomplete) {
          bool? userWantsTryAgain =
              await widget.showChallengeNotCompletedMessage<bool>(context);
          if (!mounted) return;
          if (userWantsTryAgain == true) {
            _navigateToDailyChallengePage(
              context,
              BlocProvider.of<HomeCubit>(context).state,
              BlocProvider.of<HomeCubit>(context),
              softGenerateNewChallenge: true,
            );
            completer.complete();
          } else if (userWantsTryAgain == false) {
            _navigateToDailyChallengePage(
              context,
              BlocProvider.of<HomeCubit>(context).state,
              BlocProvider.of<HomeCubit>(context),
              forceGenerateNewChallenge: true,
            );
            completer.complete();
          }
          completer.complete();
        }
      }
      completer.complete();
    }, onError: (error) async {
      if (error is AuthFailure) {
        logout();
      }
      widget.handleError<bool>(context, error,
          btnLabel: 'Intentar nuevamente',
          linkBtnLabel: 'Cerrar Sesión', linkBtnOnTap: () {
        logout();
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.of(context).pushNamed(Routes.login);
      }).then((isRefresh) {
        if (isRefresh != null) {
          if (isRefresh) {
            getDashboard(context);
          }
        }
      });
      completer.completeError(error);
    });
    return completer.future;
  }
}

class HomePositionsChip extends StatelessWidget {
  const HomePositionsChip(
      {Key? key,
      required this.label,
      required this.content,
      required this.position,
      required this.arrowLeaderBoard,
      this.onTap})
      : super(key: key);

  final String label;
  final String content;
  final String position;
  final ArrowLeaderBoard arrowLeaderBoard;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BigChip(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space16, vertical: Constants.space16),
        primary: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            arrowLeaderBoard
          ],
        ),
        secondary: Padding(
          padding: const EdgeInsets.only(top: Constants.space8),
          child: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  minFontSize: 14,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(
                  '#$position',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
