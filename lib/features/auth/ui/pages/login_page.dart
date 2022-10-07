import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/failures/status_codes.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/link_button.dart';
import '../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../core/utils/constants.dart';
import '../../data/models/login_model.dart';
import '../bloc/cubit/auth_cubit.dart';
import 'forgot_password_page.dart';
import 'receive_invite_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.expand,
            children: [
              const Align(
                  alignment: Alignment.topCenter, child: GradientBackground()),
              ListView(
                padding: const EdgeInsets.only(
                    top: 64, left: Constants.space18, right: Constants.space18),
                children: [
                  const SizedBox(height: Constants.space21),
                  SvgPicture.asset('assets/images/login-image.svg'),
                  const SingleChildScrollView(child: _LoginForm()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget with ErrorHandling {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  late TextEditingController emailAddressLoginController;
  late TextEditingController passwordLoginController;

  @override
  void initState() {
    super.initState();
    emailAddressLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    emailAddressLoginController.dispose();
    passwordLoginController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: Constants.space21),
                child: Headline(label: 'Iniciar sesion'),
              ),
              ThemedTextFormField(
                controller: emailAddressLoginController,
                hintText: 'Email',
                prefixIconSvgPath: 'assets/icons/mail-outline-icon.svg',
                keyboardType: TextInputType.emailAddress,
                enabled: !state.loading,
                errorText: state.httpFailure?.error == FailureType.email
                    ? state.httpFailure?.message
                    : null,
              ),
              const SizedBox(height: Constants.space18),
              ThemedTextFormField(
                controller: passwordLoginController,
                hintText: 'Password',
                prefixIconSvgPath: 'assets/icons/lock-outline-icon.svg',
                keyboardType: TextInputType.text,
                obscureText: true,
                enabled: !state.loading,
                errorText: state.httpFailure?.error == FailureType.password
                    ? state.httpFailure?.message
                    : null,
              ),
              const SizedBox(height: Constants.space18),
              Align(
                  alignment: Alignment.topRight,
                  child: LinkButton(
                    text: 'Olvidé la contraseña',
                    onTap: () => state.loading
                        ? null
                        : _navigateToForgotPassword(context),
                  )),
              const SizedBox(height: Constants.space18),
              BigButton(
                elevation: 5,
                text: 'Entrar a 500 Historias',
                isLoading: state.loading,
                onPressed: () {
                  _navigateToHomeNavigator(context);
                },
              ),
              const SizedBox(height: Constants.space41),
              Align(
                  alignment: Alignment.center,
                  child: LinkButton(
                    text: 'Tengo una invitación',
                    onTap: () =>
                        state.loading ? null : _navigateToVerifyInvite(context),
                  )),
            ],
          );
        },
      ),
    );
  }

  void _navigateToVerifyInvite(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<AuthCubit>(context),
          child: const ReceiveInvitePage(),
        ),
      ),
    );
  }

  void _navigateToForgotPassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: BlocProvider.of<AuthCubit>(context),
          child: const ForgotPasswordPage(),
        ),
      ),
    );
  }

  void _navigateToHomeNavigator(BuildContext context) {
    BlocProvider.of<AuthCubit>(context).login(
        LoginModel(
            email: emailAddressLoginController.text,
            password: passwordLoginController.text), onSuccess: () {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(Routes.homeNavigator);
    }, onError: (HttpFailure error) {
      if (error.statusCode == StatusCodes.unauthorized) {
        if (error.error == FailureType.email ||
            error.error == FailureType.password) {
          // Let this UI show the error type
          return;
        }
      }
      widget.handleError(context, error);
    });
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 340),
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            const Color(0xff7bffff).withOpacity(0.08),
            const Color.fromARGB(255, 123, 255, 255).withOpacity(0)
          ],
          stops: const <double>[
            0.0,
            0.8,
          ],
          center: Alignment.center,
          radius: 0.6,
        ),
      ),
    );
  }
}
