import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'ui/bloc/cubit/school_profile_cubit.dart';
import 'ui/pages/school_profile_page.dart';

class SchoolProfileProvider extends StatelessWidget {
  const SchoolProfileProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as SchoolProfileArguments;
    return BlocProvider(
      create: (context) => SchoolProfileCubit(schoolId: args.id),
      child: const SchoolProfilePage(),
    );
  }
}

class SchoolProfileArguments {
  final int id;
  SchoolProfileArguments(this.id);
}
