import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/mixins/bottom_sheet_messages.dart';

@RoutePage()
class OnboardingUserPage extends StatefulWidget with SheetMessages {
  const OnboardingUserPage(
      {super.key, required this.role, required this.onResult});

  final void Function() onResult;
  final Role role;

  @override
  State<OnboardingUserPage> createState() => _OnboardingUserPageState();
}

class _OnboardingUserPageState extends State<OnboardingUserPage> {
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
          title: "Bienvenido a 500 Historias",
          body:
              "500Historias es una invitación a unirnos para cambiar la historia que viene.\n\n¡Sé parte de la transformación!",
          image: Image.asset('assets/images/logo.png', width: 137),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Crea tu equipo",
          body:
              "Dentro del torneo se compite por equipos, como capitán de equipo debes crear tu equipo primero antes de iniciar.",
          image: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
                'assets/images/avatar-team-placeholder-image.jpg',
                width: 137),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Invita a tus compañeros",
          body:
              "Una vez tengas tu equipo, debes invitar a otros lectores y así ganar juntos el torneo.",
          image: _buildImage('book-trophy-image.svg', 150),
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
