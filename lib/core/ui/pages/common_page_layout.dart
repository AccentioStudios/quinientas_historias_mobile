import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive/rive.dart';

import '../../utils/constants.dart';
import '../widgets/big_button.dart';
import '../widgets/link_button.dart';

@RoutePage<bool?>()
class CommonInfoPage extends StatelessWidget {
  const CommonInfoPage({
    super.key,
    this.headline = 'Oops...',
    this.message =
        'Algo sucedió y no sabemos que pasó.\nIntenta nuevamente, quizás ya se solucionó',
    this.svgImagePath = 'assets/images/bug-error-image.svg',
    this.riveAnimationPath,
    this.haveBackButton = false,
    this.btnLabel = 'Volver',
    this.onBtnTap,
    this.linkBtnLabel,
    this.linkBtnOnTap,
    this.withoutBtns = false,
  });

  final String headline;
  final String message;
  final String svgImagePath;
  final String? riveAnimationPath;
  final bool haveBackButton;
  final String? btnLabel;
  final Function()? onBtnTap;

  final String? linkBtnLabel;
  final Function()? linkBtnOnTap;

  final bool withoutBtns;

  @override
  Widget build(BuildContext context) {
    const TextStyle headlineStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    const TextStyle messageStyle = TextStyle(
      fontSize: 16,
    );

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: haveBackButton
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
              )
            : null,
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Column(children: [
              Expanded(
                flex: 1,
                child: Column(children: [
                  Expanded(
                    flex: 2,
                    child: riveAnimationPath != null
                        ? SizedBox(
                            width: 190,
                            height: 190,
                            child: RiveAnimation.asset(riveAnimationPath!))
                        : SvgPicture.asset(svgImagePath),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      Text(headline,
                          style: headlineStyle, textAlign: TextAlign.center),
                      const SizedBox(height: Constants.space21),
                      Text(
                        message,
                        style: messageStyle,
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  )
                ]),
              ),
              if (!withoutBtns)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: Constants.space21),
                  child: Column(
                    children: [
                      BigButton(
                          text: btnLabel ?? 'Volver',
                          onPressed: () {
                            if (onBtnTap != null) {
                              onBtnTap!();
                            } else {
                              _navigatoToBack(context);
                            }
                          }),
                      linkBtnLabel != null && linkBtnOnTap != null
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: LinkButton(
                                text: linkBtnLabel!,
                                onTap: linkBtnOnTap,
                              ))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
            ]),
          ),
        ),
      ),
    );
  }

  void _navigatoToBack(BuildContext context) {
    Navigator.of(context).pop(true);
  }
}
