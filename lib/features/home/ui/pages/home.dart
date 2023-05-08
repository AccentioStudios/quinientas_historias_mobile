import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../bloc/cubit/home_cubit.dart';
import 'home_admin/home_admin_page.dart';
import 'home_prof/home_prof_page.dart';
import 'home_reader/home_reader_page.dart';

class HomePage extends StatefulWidget with ErrorHandling {
  const HomePage({super.key});

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
    super.didChangeDependencies();
    getDashboard(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: state.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : RefreshIndicator(
                  onRefresh: () async => getDashboard(context),
                  child: selectHomePageForUserRole(state),
                ),
        );
      },
    );
  }

  selectHomePageForUserRole(HomeState state) {
    switch (state.dashboard?.user.role?.name) {
      case Role.reader:
      case Role.captain:
        return HomeReaderPage(state: state);
      case Role.prof:
        return HomeProfPage(state: state);
      case Role.admin:
        return HomeAdminPage(state: state);
      default:
        return HomeReaderPage(state: state);
    }
  }

  getDashboard(BuildContext context) {
    context
        .read<HomeCubit>()
        .getDashboard()
        .onError<HttpFailure>((error, stackTrace) {
      widget.handleError(context, error);
    });
  }
}
