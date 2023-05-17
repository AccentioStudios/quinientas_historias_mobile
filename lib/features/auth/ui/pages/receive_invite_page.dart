import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/headline.dart';
import '../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../core/utils/constants.dart';
import '../bloc/cubit/auth_cubit.dart';

class ReceiveInvitePage extends StatelessWidget with ErrorHandling {
  const ReceiveInvitePage({super.key});

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
                SvgPicture.asset('assets/images/email-check-image.svg'),
                const _VerifyCodeForm(),
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

class _VerifyCodeForm extends StatefulWidget with ErrorHandling {
  const _VerifyCodeForm();

  @override
  State<_VerifyCodeForm> createState() => _VerifyCodeFormState();
}

class _VerifyCodeFormState extends State<_VerifyCodeForm> {
  late TextEditingController inviteCodeController;
  late TextEditingController emailAddressLoginController;
  String? errorMessage;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    inviteCodeController = TextEditingController();
    emailAddressLoginController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(left: 5, bottom: 0),
                child: Headline(label: 'Verificar invitación'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 5, right: 5),
                child: Text(
                  'Escribe tu email y el código de invitación que recibiste en tu bandeja de email.',
                  style: TextStyle(height: 1.4),
                ),
              ),
              const SizedBox(height: Constants.space18),
              ThemedTextFormField(
                controller: emailAddressLoginController,
                hintText: 'Email',
                keyboardType: TextInputType.emailAddress,
                errorText: errorMessage,
                validator: emailValidator,
              ),
              const SizedBox(height: Constants.space18),
              ThemedTextFormField(
                controller: inviteCodeController,
                hintText: 'Codigo de invitación',
                keyboardType: TextInputType.text,
                errorText: errorMessage,
                validator: codeValidator,
              ),
              const SizedBox(height: 30),
              BigButton(
                elevation: 5,
                text: 'Verificar',
                onPressed: () {
                  _navigateToNext();
                },
              )
            ],
          ),
        ));
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido.';
    }
    if (!validateEmail(value)) {
      return 'Introduce un e-mail válido';
    }
    return null;
  }

  String? codeValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido.';
    }
    return null;
  }

  bool validateEmail(String email) {
    return BlocProvider.of<AuthCubit>(context).validateEmail(email);
  }

  void _navigateToNext() {
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }

    // ReceivedInviteProvider.open(context,
    //     inviteId: 0,
    //     email: emailAddressLoginController.text,
    //     code: inviteCodeController.text);
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
