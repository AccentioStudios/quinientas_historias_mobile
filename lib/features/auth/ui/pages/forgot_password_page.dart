import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/auth_cubit.dart';
import 'otpcode_password_page.dart';

class ForgotPasswordPage extends StatelessWidget with ErrorHandling {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SvgPicture.asset('assets/images/forgot-password-image.svg'),
                const _ForgotPasswordForm(),
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                height: 64,
                child: AppBar(
                  elevation: 0,
                  toolbarHeight: 64,
                  backgroundColor: Colors.transparent,
                  centerTitle: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget with ErrorHandling {
  const _ForgotPasswordForm();

  @override
  State<_ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  late TextEditingController emailAddressLoginController;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    emailAddressLoginController = TextEditingController();
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
                padding: EdgeInsets.only(left: 5, bottom: 0),
                child: Headline(label: 'Olvidé mi contraseña'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 5, right: 5),
                child: Text(
                  'No te preocupes, podrás crear una nueva.\nEscribe tu email y recibirás un código de verificación para continuar.',
                  style: TextStyle(height: 1.4),
                ),
              ),
              const SizedBox(height: Constants.space18),
              ThemedTextFormField(
                controller: emailAddressLoginController,
                hintText: 'Email',
                prefixIconSvgPath: 'assets/icons/mail-outline-icon.svg',
                keyboardType: TextInputType.emailAddress,
                enabled: !state.loading,
                errorText: errorMessage,
              ),
              const SizedBox(height: 30),
              BigButton(
                elevation: 5,
                text: 'Restaurar Contraseña',
                isLoading: state.loading,
                onPressed: () {
                  _navigateToNext();
                },
              )
            ],
          );
        },
      ),
    );
  }

  bool validateEmail(String email) {
    return BlocProvider.of<AuthCubit>(context).validateEmail(email);
  }

  void _navigateToNext() {
    setState(() {
      errorMessage = null;
    });

    if (!validateEmail(emailAddressLoginController.text)) {
      setState(() {
        errorMessage = "Escribe un email válido";
      });
      return;
    }

    BlocProvider.of<AuthCubit>(context)
        .setEmail(emailAddressLoginController.text);

    BlocProvider.of<AuthCubit>(context).resetPassword(onSuccess: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<AuthCubit>(context),
            child: const OtpCodePasswordPage(),
          ),
        ),
      );
    }, onError: (HttpFailure error) {
      if (error.statusCode == StatusCodes.iforgotError) {
        setState(() {
          errorMessage = 'error.message';
        });
        return;
      }
      widget.handleError(context, error);
    });
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({super.key});

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
