import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import 'data/repositories/auth_repository.dart';
import 'data/useCases/auth_usecases.dart';
import 'ui/bloc/cubit/auth_cubit.dart';
import 'ui/pages/forgot_password_page.dart';
import 'ui/pages/login_page.dart';

@RoutePage<bool?>()
class AuthProvider extends StatelessWidget {
  const AuthProvider({
    Key? key,
    this.autoNavigateToShell,
    this.byPassFirstScreen,
    this.onResult,
  }) : super(key: key);
  final bool? autoNavigateToShell;
  final bool? byPassFirstScreen;
  final Function(dynamic)? onResult;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          AuthCubit(authUseCases: AuthUseCases(repository: AuthRepository())),
      child: LoginPage(
          autoNavigateToShell: autoNavigateToShell ?? true,
          byPassFirstScreen: byPassFirstScreen ?? false),
    );
  }

  Future<bool?> login(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<bool>(
      MaterialPageRoute<bool>(
        builder: (_) => BlocProvider(
          create: (BuildContext context) => AuthCubit(
              authUseCases: AuthUseCases(repository: AuthRepository())),
          child: const LoginPage(
            autoNavigateToShell: false,
            byPassFirstScreen: true,
          ),
        ),
      ),
    );
  }

  static openIForgot(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (BuildContext context) => AuthCubit(
              authUseCases: AuthUseCases(repository: AuthRepository())),
          child: const ForgotPasswordPage(),
        ),
      ),
    );
  }
}
