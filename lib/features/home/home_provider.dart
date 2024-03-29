import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/home/ui/pages/home.dart';

import 'data/repositories/home_repository.dart';
import 'data/useCases/home_usecases.dart';
import 'ui/bloc/cubit/home_cubit.dart';

@RoutePage()
class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            HomeCubit(homeUseCases: HomeUseCases(repository: HomeRepository())),
        child: const HomePage());
  }
}
