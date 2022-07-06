import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/ui/widgets/headline.dart';
import 'package:quinientas_historias/core/ui/widgets/link_button.dart';

import '../../../../core/utils/constants.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            const Align(
                alignment: Alignment.topCenter, child: GradientBackground()),
            AppBar(
              elevation: 0,
              toolbarHeight: 64,
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            ListView(
              padding: const EdgeInsets.only(
                  top: 64, left: Constants.space18, right: Constants.space18),
              children: [
                const SizedBox(height: Constants.space21),
                SvgPicture.asset('assets/images/forgot-password-image.svg'),
                _ForgotPasswordForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ForgotPasswordForm extends StatefulWidget {
  const _ForgotPasswordForm({Key? key}) : super(key: key);

  @override
  State<_ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<_ForgotPasswordForm> {
  late TextEditingController emailAddressLoginController;
  late TextEditingController passwordLoginController;

  @override
  void initState() {
    super.initState();
    emailAddressLoginController = TextEditingController();
    passwordLoginController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(left: Constants.space21),
            child: Headline(label: 'Olvidé la contraseña'),
          ),
          ThemedTextFormField(
            controller: emailAddressLoginController,
            hintText: 'Email',
            prefixIconSvgPath: 'assets/icons/mail-outline-icon.svg',
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: Constants.space18),
          ThemedTextFormField(
            controller: passwordLoginController,
            hintText: 'Password',
            prefixIconSvgPath: 'assets/icons/lock-outline-icon.svg',
            keyboardType: TextInputType.text,
            obscureText: true,
          ),
          const SizedBox(height: Constants.space18),
          const Align(
              alignment: Alignment.topRight,
              child: LinkButton(text: 'Olvidé la contraseña')),
          const SizedBox(height: Constants.space18),
          BigButton(
            elevation: 5,
            text: 'Entrar a 500 Historias',
            isLoading: false,
            onPressed: () {},
          )
        ],
      ),
    );
  }
}

class ThemedTextFormField extends StatelessWidget {
  const ThemedTextFormField({
    Key? key,
    this.hintText,
    this.prefixIconSvgPath,
    this.keyboardType,
    required this.controller,
    this.obscureText = false,
    this.enabled,
    this.autofocus = false,
  }) : super(key: key);

  final String? hintText;
  final String? prefixIconSvgPath;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final bool obscureText;
  final bool? enabled;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      enabled: enabled,
      decoration: InputDecoration(
        prefixIcon: prefixIconSvgPath != null
            ? Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, left: 21, bottom: 0, right: 13),
                child: SvgPicture.asset(
                  prefixIconSvgPath!,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              )
            : null,
        prefixIconColor: Theme.of(context).colorScheme.onSurface,
        contentPadding: EdgeInsets.only(
          left: prefixIconSvgPath == null ? 21 : 0,
          top: 20,
          bottom: 20,
          right: 20,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0x00000000), width: 1),
          borderRadius: Constants.borderRadius50,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color(0xFFFFFFFF).withOpacity(0.3), width: 1),
          borderRadius: Constants.borderRadius50,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: const Color.fromARGB(255, 199, 199, 199).withOpacity(0.12),
              width: 1),
          borderRadius: Constants.borderRadius50,
        ),
        filled: enabled == false ? false : true,
        fillColor: Theme.of(context).colorScheme.primaryContainer,
        hoverColor: Theme.of(context).colorScheme.onPrimaryContainer,
        hintText: hintText,
      ),
    );
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