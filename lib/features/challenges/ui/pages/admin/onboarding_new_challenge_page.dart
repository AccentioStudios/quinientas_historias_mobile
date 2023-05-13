import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

@RoutePage()
class OnboardingNewChallengePage extends StatefulWidget {
  const OnboardingNewChallengePage({super.key, required this.onResult});

  final void Function() onResult;

  @override
  State<OnboardingNewChallengePage> createState() =>
      _OnboardingNewChallengePageState();
}

class _OnboardingNewChallengePageState
    extends State<OnboardingNewChallengePage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd() {
    widget.onResult();
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset('assets/images/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);

    final pageDecoration = PageDecoration(
      titleTextStyle:
          const TextStyle(fontSize: 21.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Theme.of(context).colorScheme.background,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Theme.of(context).colorScheme.background,
      allowImplicitScrolling: true,
      globalHeader: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            AutoRouter.of(context).pop(false);
          },
        ),
      ),
      pages: [
        PageViewModel(
          title: "Registra tu nuevo reto",
          body:
              "Crea tus propios retos donde los jugadores podrán ganar puntos adicionales en el torneo de lectura.",
          image: _buildImage('challenge-minigame-image.svg', 132),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Conecta con 500Historias",
          body:
              "Integra tus retos registrados en la aplicación a la plataforma de 500Historias y obtener visibilidad al compartirlos con otros miembros de la comunidad de lectura",
          image: _buildImage('connect-500h-image.svg', 251),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Obtén tu identificación",
          body:
              "Después de registar tus retos, para conectar con 500Historias debes usar una llave especial y secreta. Una vez la tengas no la pierdas.",
          image: _buildImage('secret-key-outline-image.svg', 150),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(),
      showSkipButton: false,
      showBackButton: true,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Saltar', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Listo', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      // dotsContainerDecorator: const ShapeDecoration(
      //   color: Colors.black87,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.all(Radius.circular(8.0)),
      //   ),
      // ),
    );
  }
}
