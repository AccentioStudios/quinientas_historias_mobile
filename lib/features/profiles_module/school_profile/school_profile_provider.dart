import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/data/repositories/school_profile_repository.dart';
import 'package:quinientas_historias/features/profiles_module/school_profile/data/useCases/school_profile_usecases.dart';

import 'ui/bloc/cubit/school_profile_cubit.dart';
import 'ui/pages/school_profile_page.dart';

class SchoolProfileProvider extends StatelessWidget {
  const SchoolProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SchoolProfileArguments;
    return BlocProvider(
      create: (context) => SchoolProfileCubit(
          schoolId: args.id,
          schoolProfileUseCases:
              SchoolProfileUseCases(repository: SchoolProfileRepository())),
      child: const SchoolProfilePage(),
    );
  }
}

class SchoolProfileArguments {
  final int id;
  SchoolProfileArguments(this.id);
}
