import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/home/ui/pages/home_captain/home_captain_page.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/ui/widgets/padding_column.dart';
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
                  child: state.error != null
                      ? _ErrorMessage(
                          getDashboardFunction: () => getDashboard(context))
                      : selectHomePageForUserRole(state),
                ),
        );
      },
    );
  }

  selectHomePageForUserRole(HomeState state) {
    switch (state.dashboard?.user.role?.name) {
      case Role.reader:
      case Role.captain:
        return HomeCaptainPage(
            state: state, getDashboardFunction: () => getDashboard(context));
      case Role.prof:
        return HomeProfPage(
            state: state, getDashboardFunction: () => getDashboard(context));
      case Role.admin:
        return HomeAdminPage(
            state: state, getDashboardFunction: () => getDashboard(context));
      default:
        return HomeReaderPage(
            state: state, getDashboardFunction: () => getDashboard(context));
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

class _ErrorMessage extends StatelessWidget {
  const _ErrorMessage({required this.getDashboardFunction});
  final void Function() getDashboardFunction;
  @override
  Widget build(BuildContext context) {
    // error message widget that will be shown when an error happened when loading the dashboard
    return Center(
      child: PaddingColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
        children: [
          Text(
            'Error al intentar cargar el menú principal',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: Constants.space21),
          SizedBox(
            width: 300,
            child: BigButton(
              onPressed: getDashboardFunction,
              text: 'Intentar nuevamente',
            ),
          )
        ],
      ),
    );
  }
}
