import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/failures/status_codes.dart';
import '../../../../../core/libs/extended_tab_view.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/auto_router.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../bloc/cubit/user_profile_cubit.dart';
import '../widgets/user_profile_header.dart';
import 'user_achievements_tab_view.dart';
import 'user_favorites_tab_view.dart';
import 'user_teams_tab_view.dart';

class UserProfilePage extends StatefulWidget with ErrorHandling {
  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
    getUserData();
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
              if (state.isMyProfile)
                TextButton.icon(
                  onPressed: () {
                    openEditUser(context, state);
                  },
                  icon: SvgPicture.asset('assets/icons/edit-icon.svg'),
                  label: Text(
                    'Editar Perfil',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                ),
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
                                controller: _tabController,
                                unselectedLabelColor:
                                    Theme.of(context).colorScheme.primary,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                tabs: const <Widget>[
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Favoritos",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Equipos",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Tab(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Logros",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
        .openEditUser(context, user: state.user!.toEntity())
        .then((refresh) {
      if (refresh == true) {
        getUserData();
      }
    });
  }

  Future<dynamic> getUserData() {
    var completer = Completer();
    context.read<UserProfileCubit>().getUserData(
      onSuccess: () {
        completer.complete();
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
