import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/repositories/home_repository.dart';
import 'data/useCases/home_usecases.dart';
import 'ui/bloc/cubit/home_cubit.dart';
import 'ui/pages/home.dart';

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
