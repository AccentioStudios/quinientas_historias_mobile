import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/failures/status_codes.dart';
import '../../../../core/integrations/remote_config_service.dart';
import '../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/arrow_leaderboard.dart';
import '../../../../core/ui/widgets/big_chip.dart';
import '../../../../core/ui/widgets/buttom_bar.dart';
import '../../../../core/utils/constants.dart';
import '../../../reading_module/daily_challenge/daily_challange_provider.dart';
import '../bloc/cubit/home_cubit.dart';
import 'home_captain_tier_0_layout.dart';
import 'home_layout.dart';
import 'home_prof_layout.dart';

class HomePage extends StatefulWidget with ErrorHandling, SheetMessages {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ActiveOptionAppButtonBar activeOption = ActiveOptionAppButtonBar.home;

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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: state.loading && state.dashboard?.user == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await getDashboard(context);
                  },
                  child: state.dashboard!.user.type == UserType.prof
                      ? HomeProfLayout(state: state)
                      : state.dashboard!.user.type == UserType.captain &&
                              state.dashboard!.user.team == null
                          ? HomeCaptainTier0Layout(
                              state: state,
                              getDashboardFunction: () =>
                                  getDashboard(context, state: state),
                            )
                          : HomeLayout(
                              state: state,
                              getDashboardFunction: () =>
                                  getDashboard(context, state: state),
                            )),
        );
      },
    );
  }

  void _navigateToDailyChallengePage(
    BuildContext context,
    HomeState state,
    HomeCubit cubit, {
    bool softGenerateNewChallenge = false,
    bool forceGenerateNewChallenge = false,
  }) {
    Navigator.of(context).push(MaterialPageRoute(
        settings: const RouteSettings(name: Routes.dailyChallenge),
        builder: (context) => DailyChallangeProvider(
              homeCubit: cubit,
              dailyChallenge: state.dashboard?.dailyChallenge,
              softGenerateNewChallenge: softGenerateNewChallenge,
              forceGenerateNewChallenge: forceGenerateNewChallenge,
            )));
  }

  void logout() {
    const secureStorage = FlutterSecureStorage();
    secureStorage.deleteAll();
  }

  bool _checkDailyChallengeEnabled() {
    final remoteConfig = RemoteConfigService.instance;
    final bool response = remoteConfig.getBool('daily_challenge_enabled');
    return response;
  }

  Future<dynamic> getDashboard(BuildContext context, {HomeState? state}) {
    var completer = Completer();
    BlocProvider.of<HomeCubit>(context).getDashboard(
        onSuccess: (dashboard) async {
      if (dashboard.dailyChallenge != null && _checkDailyChallengeEnabled()) {
        if (dashboard.dailyChallenge!.hasOldChallengeIncomplete) {
          bool? userWantsTryAgain =
              await widget.showChallengeNotCompletedMessage<bool>(context);
          if (!mounted) return;
          if (userWantsTryAgain == true) {
            _navigateToDailyChallengePage(
              context,
              BlocProvider.of<HomeCubit>(
                context,
              ).state,
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
      if (error.statusCode == StatusCodes.unauthorized) {
        logout();
      }
      widget.handleError<bool>(context, error,
          btnLabel: 'Intentar nuevamente',
          linkBtnLabel: 'Cerrar Sesión', linkBtnOnTap: () {
        logout();
        Navigator.of(context, rootNavigator: true)
            .popUntil((route) => route.isFirst);
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
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
      this.arrowLeaderBoard,
      this.onTap})
      : super(key: key);

  final String label;
  final String content;
  final String position;
  final ArrowLeaderBoard? arrowLeaderBoard;
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
            if (arrowLeaderBoard != null) arrowLeaderBoard!
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
