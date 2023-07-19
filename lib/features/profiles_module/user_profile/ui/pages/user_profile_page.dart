import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/pages/pending_quiz_items_to_approve_tab_view.dart';

import '../../../../../core/data/dto/auth_dto.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/status_codes.dart';
import '../../../../../core/integrations/secure_storage_service.dart';
import '../../../../../core/libs/extended_tab_view.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../quiz/domain/entities/quiz_items.entity.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../bloc/cubit/user_profile_cubit.dart';
import '../widgets/user_profile_header.dart';
import 'user_achievements_tab_view.dart';
import 'user_favorites_tab_view.dart';
import 'user_teams_tab_view.dart';

class UserProfilePage extends StatefulWidget with ErrorHandling {
  const UserProfilePage({
    super.key,
  });

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int tabNumber = 3;

  @override
  void initState() {
    getUserData();
    _tabController = TabController(length: tabNumber, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileCubit, UserProfileState>(
      builder: (context, state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              FutureBuilder<JwtPayload?>(
                  future: SecureStorageService().getSessionData(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox.shrink();
                    }
                    final role = snapshot.data!.role;
                    if (role != Role.admin && !state.isMyProfile) {
                      return const SizedBox.shrink();
                    }
                    return TextButton.icon(
                      onPressed: () {
                        openEditUser(context, state);
                      },
                      icon: SvgPicture.asset('assets/icons/edit-icon.svg'),
                      label: Text(
                        'Editar Perfil',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                    );
                  }),
              const SizedBox(width: 8),
            ],
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              getUserData();
            },
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.httpFailure?.statusCode == StatusCodes.notFound ||
                        state.user == null
                    ? const Center(
                        child: Text(
                          'El usuario no existe\n:\'c',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : CustomNestedScrollView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        headerSliverBuilder: (context, innerBoxIsScrolled) => [
                          CustomSliverOverlapAbsorber(
                            handle: CustomNestedScrollView
                                .sliverOverlapAbsorberHandleFor(context),
                            sliver: UserProfileHeader(state: state),
                          ),
                          const SliverToBoxAdapter(
                              child: SizedBox(height: Constants.space21)),
                          SliverToBoxAdapter(
                            child: SizedBox(
                              height: 34,
                              child: TabBar(
                                isScrollable: true,
                                controller: _tabController,
                                unselectedLabelColor:
                                    Theme.of(context).colorScheme.primary,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                tabs: <Widget>[
                                  const Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Constants.space16),
                                        child: Text(
                                          "Favoritos",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Constants.space16),
                                        child: Text(
                                          "Equipos",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  if (state.user!.pendingQuizItemsToReview
                                      .isNotEmpty)
                                    const Tab(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Constants.space16),
                                          child: Text(
                                            "Por aprobar",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  const Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: Constants.space16),
                                        child: Text(
                                          "Logros",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SliverToBoxAdapter(
                            child: SizedBox(height: Constants.space21),
                          )
                        ],
                        body: Builder(
                          builder: (context) => ExtendedTabBarView(
                            controller: _tabController,
                            physics: const BouncingScrollPhysics(),
                            children: [
                              UserFavoritesTabView(
                                user: state.user!,
                              ),
                              UserTeamsTabView(
                                user: state.user!,
                              ),
                              if (state
                                  .user!.pendingQuizItemsToReview.isNotEmpty)
                                PendingQuizItemsToApproveTabView(
                                  user: state.user!,
                                  quizItems:
                                      state.user!.pendingQuizItemsToReview,
                                  updateQuizAnswers: (List<QuizItem> update) {
                                    context
                                        .read<UserProfileCubit>()
                                        .updatePendingQuizItemsToReview(update);
                                    if (update.isEmpty) {
                                      setState(() {
                                        tabNumber = 3;
                                        _tabController = TabController(
                                            length: tabNumber, vsync: this);
                                      });
                                    }
                                  },
                                ),
                              UserAchievementsTabView(
                                user: state.user!,
                              ),
                            ],
                          ),
                        ),
                      ),
          ),
        );
      },
    );
  }

  void openEditUser(BuildContext context, UserProfileState state) {
    UserManagementProvider()
        .openEditUser(context, user: state.user!)
        .then((refresh) {
      if (refresh == true) {
        getUserData();
      }
    });
  }

  Future<dynamic> getUserData() {
    var completer = Completer();
    context.read<UserProfileCubit>().getUserData(
      onSuccess: (user) {
        completer.complete();
        if (user.pendingQuizItemsToReview.isNotEmpty) {
          setState(() {
            tabNumber = 4;
            _tabController = TabController(length: tabNumber, vsync: this);
          });
        } else {
          setState(() {
            tabNumber = 3;
            _tabController = TabController(length: tabNumber, vsync: this);
          });
        }
      },
      onError: (error) {
        if (error.statusCode == StatusCodes.notFound) {
          return completer.completeError(error);
        }
        widget.handleError<bool>(context, error,
            btnLabel: 'Intentar nuevamente',
            linkBtnLabel: 'Volver al home', linkBtnOnTap: () {
          AutoRouter.of(context).popUntil((route) => route.isFirst);
          AutoRouter.of(context).push(const HomeRoute());
        }).then((isRefresh) {
          if (isRefresh != null) {
            if (isRefresh) {
              getUserData();
            }
          }
        });
        completer.completeError(error);
      },
    );
    return completer.future;
  }
}
