import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/mixins/error_handling.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/constants.dart';

class NewPasswordSuccessPage extends StatelessWidget with ErrorHandling {
  const NewPasswordSuccessPage({Key? key}) : super(key: key);

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
              child: const _GradientBackground(),
            ),
            AppBar(
              elevation: 0,
              toolbarHeight: 64,
              backgroundColor: Colors.transparent,
              centerTitle: true,
            ),
            PaddingColumn(
              mainAxisSize: MainAxisSize.min,
              padding: const EdgeInsets.symmetric(horizontal: 30),
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
                          maxHeight: 130,
                          minHeight: 130,
                        ),
                        child: const _HeroImage(),
                      ),
                    ),
                  ),
                ),
                const Text(
                  'Contraseña recuperada',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: Constants.space16),
                const Text(
                  'Tu contraseña ha sido cambiada\ncorrectamente. Por favor inicia sesión.',
                  style: TextStyle(height: 1.4, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                BigButton(
                  elevation: 5,
                  text: 'Iniciar sesión',
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    Navigator.of(context).pushReplacementNamed(Routes.login);
                  },
                ),
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
            height: 120,
            width: 120,
            child: SvgPicture.asset('assets/images/new-pass-success-image.svg'),
          ),
        ),
      ],
    );
  }
}

class _GradientBackground extends StatelessWidget {
  const _GradientBackground({Key? key}) : super(key: key);

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
