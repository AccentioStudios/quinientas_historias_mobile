import 'package:flutter/material.dart';

import '../ui/widgets/custom_bottom_sheet.dart';
import '../utils/colors.dart';

mixin SheetMessages on Widget {
  Future<T?> showMessage<T>(
    BuildContext context, {
    String? iconSvgPath,
    Color? iconColor,
    required String title,
    required String content,
    Function? btnOnTap,
    String? btnLabel,
    Function? secondaryBtnOnTap,
    String? secondaryBtnLabel,
    double height = 320,
  }) {
    return showModalBottomSheet<T>(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0)),
      ),
      builder: (context) => MessagesBottomSheet(
        iconSvgPath: iconSvgPath,
        iconColor: iconColor,
        title: title,
        content: content,
        btnOnTap: btnOnTap,
        btnLabel: btnLabel,
        secondaryBtnOnTap: secondaryBtnOnTap,
        secondaryBtnLabel: secondaryBtnLabel,
        height: height,
      ),
    );
  }

  Future<T?> showChallengeNotCompletedMessage<T>(BuildContext context) {
    return showMessage(
      context,
      iconSvgPath: 'assets/icons/challenge-not-completed-small-icon.svg',
      title: 'Tienes lecturas sin terminar',
      content:
          'Existen algunas lecturas de anteriores dias que no terminaste. Quieres intentar otra vez o quieres un nuevo reto?',
      btnLabel: 'Intentar otra vez',
      secondaryBtnLabel: 'Quiero algo nuevo',
    );
  }

  Future<T?> showGenerateNewChallengeMessage<T>(
      BuildContext context, Function(bool) callback) {
    return showMessage(
      context,
      iconSvgPath: 'assets/icons/refresh-challenge-xl-icon.svg',
      title: 'Generar nuevo reto diario',
      content:
          'Estas seguro que quieres traer nuevas lecturas a tu reto diario? Vas a perder el avance que ya tenías hasta ahora.',
      btnLabel: 'Generar',
      btnOnTap: () {
        Navigator.of(context).pop(true);
        return callback(true);
      },
      secondaryBtnLabel: 'No gracias',
      secondaryBtnOnTap: () {
        Navigator.of(context).pop(false);
        return callback(false);
      },
    );
  }

  Future<T?> showInfoAboutStreakMessage<T>(
      BuildContext context, int streakNumber) {
    String titleStreak = 'Muy bien!\nHas tenido una racha de lecturas';
    String titleNoStreak = 'Racha de lecturas';

    String contentStreak =
        'Continua leyendo cada día y acumularás\nracha en tu perfil.';
    String contentNoStreak =
        'Continua leyendo cada día y acumularás\nracha en tu perfil.';

    String btnLabelStreak = 'Genial!';
    String btnLabelNoStreak = 'Ok';

    return showMessage(context,
        iconColor: streakNumber > 0
            ? Theme.of(context).brightness == Brightness.light
                ? streakFireRedColor
                : streakFireRedDarkColor
            : Theme.of(context).colorScheme.onPrimaryContainer,
        height: streakNumber > 0 ? 320 : 295,
        iconSvgPath: 'assets/icons/flame-icon.svg',
        title: streakNumber > 0 ? titleStreak : titleNoStreak,
        content: streakNumber > 0 ? contentStreak : contentNoStreak,
        btnLabel: streakNumber > 0 ? btnLabelStreak : btnLabelNoStreak);
  }
}
