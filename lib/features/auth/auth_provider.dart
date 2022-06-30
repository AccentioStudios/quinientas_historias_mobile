import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/features/auth/data/repositories/auth_repository.dart';
import 'package:quinientas_historias/features/auth/data/useCases/auth_usecases.dart';

import 'bloc/cubit/auth_cubit.dart';
import 'ui/pages/login/login_page.dart';

class AuthProvider extends StatelessWidget {
  const AuthProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthCubit(authUseCases: AuthUseCases(repository: AuthRepository())),
      child: const LoginPage(),
    );
  }
}
