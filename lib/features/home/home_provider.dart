import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/home/data/repositories/home_repository.dart';
import 'package:quinientas_historias/features/home/data/useCases/auth_usecases.dart';
import 'package:quinientas_historias/features/home/ui/pages/home.dart';

import 'bloc/cubit/home_cubit.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          HomeCubit(homeUseCases: HomeUseCases(repository: HomeRepository())),
      child: const HomePage(),
    );
  }
}
