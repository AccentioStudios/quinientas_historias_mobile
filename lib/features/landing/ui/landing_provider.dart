import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/cubit/landing_cubit.dart';
import 'landing_page.dart';

class LandingProvider extends StatelessWidget {
  const LandingProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingCubit(),
      child: const LandingPage(),
    );
  }
}
