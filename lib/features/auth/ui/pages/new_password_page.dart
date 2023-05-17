import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/failures/status_codes.dart';

import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/auth_cubit.dart';
import 'new_password_success_page.dart';

class NewPasswordPage extends StatelessWidget with ErrorHandling {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double bottom = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.vertical;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: bottom * 0.19 - (300 / 2),
              left: MediaQuery.of(context).size.width / 2 - (300 / 2),
              child: const GradientBackground(),
            ),
            AppBar(
              elevation: 0,
              toolbarHeight: 64,
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            PaddingColumn(
              mainAxisSize: MainAxisSize.min,
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space16),
              children: [
                const SizedBox(height: Constants.space21),
                Flexible(
                  flex: 2,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 250,
                      minHeight: 130,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 250,
                          minHeight: 130,
                        ),
                        child: const _HeroImage(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: Constants.space21),
                const _NewPasswordForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: SizedBox(
            height: 130,
            width: 130,
            child: SvgPicture.asset('assets/images/new-pass-image.svg'),
          ),
        ),
      ],
    );
  }
}

class _NewPasswordForm extends StatefulWidget with ErrorHandling {
  const _NewPasswordForm();

  @override
  State<_NewPasswordForm> createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<_NewPasswordForm> {
  late TextEditingController newPasswordController;
  late TextEditingController passwordConfirmationController;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    passwordConfirmationController.dispose();
    super.dispose();
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
                padding: EdgeInsets.only(left: Constants.space21, bottom: 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Redefinir Contraseña',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Constants.space21),
              ThemedTextFormField(
                controller: newPasswordController,
                hintText: 'Nueva contraseña',
                prefixIconSvgPath: 'assets/icons/lock-outline-icon.svg',
                keyboardType: TextInputType.text,
                obscureText: true,
                enabled: !state.loading,
                errorText: errorMessage,
              ),
              const SizedBox(height: Constants.space18),
              ThemedTextFormField(
                controller: passwordConfirmationController,
                hintText: 'Confirmar contraseña',
                prefixIconSvgPath: 'assets/icons/lock-outline-icon.svg',
                keyboardType: TextInputType.text,
                obscureText: true,
                enabled: !state.loading,
                errorText: errorMessage,
              ),
              const SizedBox(height: Constants.space21),
              BigButton(
                elevation: 5,
                text: 'Continuar',
                isLoading: state.loading,
                onPressed: () {
                  _navigateToNext(newPasswordController.text,
                      passwordConfirmationController.text);
                },
              ),
              const SizedBox(height: Constants.space21),
            ],
          );
        },
      ),
    );
  }

  void _navigateToNext(String newPassword, String passwordConfirmation) {
    setState(() {
      errorMessage = null;
    });

    BlocProvider.of<AuthCubit>(context)
        .createNewPassword(newPassword, passwordConfirmation, onSuccess: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const NewPasswordSuccessPage(),
        ),
      );
    }, onError: (error) {
      if (error.statusCode == StatusCodes.iforgotError) {
        setState(() {
          errorMessage = error.message;
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
    return FittedBox(
      child: Container(
        width: 300,
        height: 300,
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
      ),
    );
  }
}
