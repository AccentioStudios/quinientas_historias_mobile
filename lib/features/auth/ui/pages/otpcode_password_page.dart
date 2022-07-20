import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/failures/iforgot_failure.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/link_button.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';
import '../../bloc/cubit/auth_cubit.dart';
import 'new_password_page.dart';

class OtpCodePasswordPage extends StatelessWidget with ErrorHandling {
  const OtpCodePasswordPage({Key? key}) : super(key: key);

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
                const _OtpCodeForm(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Center(
          child: SizedBox(
            height: 130,
            width: 130,
            child: SvgPicture.asset('assets/images/email-check-image.svg'),
          ),
        ),
      ],
    );
  }
}

class _OtpCodeForm extends StatefulWidget with ErrorHandling {
  const _OtpCodeForm({Key? key}) : super(key: key);

  @override
  State<_OtpCodeForm> createState() => _OtpCodeFormState();
}

class _OtpCodeFormState extends State<_OtpCodeForm> {
  late TextEditingController otpCodeController;
  late StreamController<ErrorAnimationType> errorController;

  String? errorMessage;

  late Timer _timer;
  final int _maxAttempts = 3;
  final int _countDownStart = 30;
  int _countDownMultiplier = 1;
  int _countDownTimer = 30;
  int lengthOfCode = 4;

  @override
  void initState() {
    super.initState();
    otpCodeController = TextEditingController();
    errorController = StreamController<ErrorAnimationType>();
  }

  @override
  void dispose() {
    _timer.cancel();
    otpCodeController.dispose();
    errorController.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    startTimer();
    super.didChangeDependencies();
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
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Verificar código',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Constants.space18),
              const Padding(
                padding: EdgeInsets.only(top: 0, left: 5, right: 5),
                child: Text(
                  'Escribe el código de verificación que mandamos a tu bandeja de email.',
                  style: TextStyle(height: 1.4),
                ),
              ),
              const SizedBox(height: Constants.space21),
              OtpCodeInput(
                length: lengthOfCode,
                enabled: !state.loading,
                controller: otpCodeController,
                errorController: errorController,
                onCompleted: (_) {
                  _navigateToNext(otpCodeController.text, state.token);
                },
              ),
              errorMessage != null
                  ? Text(
                      errorMessage!,
                      style:
                          TextStyle(color: Theme.of(context).colorScheme.error),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: Constants.space21),
              BigButton(
                elevation: 5,
                text: 'Verificar',
                isLoading: state.loading,
                onPressed: () {
                  _navigateToNext(otpCodeController.text, state.token);
                },
              ),
              const SizedBox(height: Constants.space16),
              LinkButton(
                  onTap: () {
                    if (_countDownTimer == 0 &&
                        _countDownMultiplier <= _maxAttempts) {
                      resendCode();
                    }
                  },
                  text: _countDownMultiplier < 4
                      ? _countDownTimer > 0
                          ? 'Reenviar Código en $_countDownTimer'
                          : 'Reenviar Código'
                      : 'Intente de nuevo más tarde'),
              const SizedBox(height: Constants.space21),
            ],
          );
        },
      ),
    );
  }

  void resendCode() {
    _timer.cancel();
    setState(() {
      errorMessage = null;
    });

    BlocProvider.of<AuthCubit>(context).resetPassword(onSuccess: () {
      setState(() {
        _countDownMultiplier++;
        _countDownTimer = _countDownStart * _countDownMultiplier;
        startTimer();
      });
    }, onError: (error) {
      if (error is IForgotFailure) {
        setState(() {
          errorMessage = error.message;
        });
        return;
      }
      widget.handleError(context, error);
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countDownTimer == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _countDownTimer--;
          });
        }
      },
    );
  }

  void _navigateToNext(String code, String token) {
    setState(() {
      errorMessage = null;
    });

    BlocProvider.of<AuthCubit>(context).setCodeAndToken(code, token);

    BlocProvider.of<AuthCubit>(context).verifyOtp(onSuccess: () {
      print('success');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: BlocProvider.of<AuthCubit>(context),
            child: const NewPasswordPage(),
          ),
        ),
      );
    }, onError: (error) {
      if (error is IForgotFailure) {
        setState(() {
          errorMessage = error.message;
        });
        errorController.add(ErrorAnimationType.shake);
        return;
      }
      widget.handleError(context, error);
    });
  }
}

class OtpCodeInput extends StatefulWidget {
  const OtpCodeInput({
    Key? key,
    required this.controller,
    this.errorController,
    this.onCompleted,
    this.enabled = true,
    this.length = 4,
  }) : super(key: key);
  final bool enabled;
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  final StreamController<ErrorAnimationType>? errorController;
  final int length;
  @override
  State<OtpCodeInput> createState() => _OtpCodeInputState();
}

class _OtpCodeInputState extends State<OtpCodeInput> {
  @override
  Widget build(BuildContext context) {
    var activeFillColor = Theme.of(context).colorScheme.primaryContainer;
    var successCodeColor = Theme.of(context).brightness == Brightness.light
        ? successColor
        : successDarkColor;

    var errorCodeColor = Theme.of(context).brightness == Brightness.light
        ? errorColor
        : errorDarkColor;

    return PinCodeTextField(
      length: widget.length,
      autoFocus: true,
      obscureText: false,
      animationType: AnimationType.none,
      enabled: widget.enabled,
      controller: widget.controller,
      errorAnimationController: widget.errorController,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(12),
        fieldHeight: 68,
        fieldWidth: 64,
        activeColor: successCodeColor.withOpacity(0.80),
        activeFillColor: activeFillColor,
        selectedColor: Colors.white.withOpacity(0.80),
        selectedFillColor: activeFillColor,
        inactiveColor: Colors.transparent,
        inactiveFillColor: activeFillColor,
        errorBorderColor: errorCodeColor,
        disabledColor: activeFillColor.withOpacity(0.30),
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: widget.onCompleted,
      // beforeTextPaste: (text) {
      //   //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
      //   //but you can show anything you want here, like your pop up saying wrong paste format or etc
      //   return true;
      // },
      appContext: context,
      onChanged: (String value) {},
    );
  }
}

class GradientBackground extends StatelessWidget {
  const GradientBackground({Key? key}) : super(key: key);

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
