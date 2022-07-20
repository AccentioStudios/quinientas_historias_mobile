import 'package:flutter/material.dart';

import '../ui/widgets/custom_bottom_sheet.dart';
import '../utils/constants.dart';

mixin SheetMessages on Widget {
  Future<T?> showMessage<T>(
    BuildContext context, {
    String? iconSvgPath,
    required String title,
    required String content,
    Function? btnOnTap,
    String? btnLabel,
    Function? secondaryBtnOnTap,
    String? secondaryBtnLabel,
  }) {
    return showModalBottomSheet<T>(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: Constants.borderRadius23,
      ),
      builder: (context) => CustomBottomSheet(
        iconSvgPath: iconSvgPath,
        title: title,
        content: content,
        btnOnTap: btnOnTap,
        btnLabel: btnLabel,
        secondaryBtnOnTap: secondaryBtnOnTap,
        secondaryBtnLabel: secondaryBtnLabel,
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

  Future<T?> showInfoAboutStreakMessage<T>(BuildContext context) {
    return showMessage(context,
        iconSvgPath: 'assets/icons/flame-icon.svg',
        title: 'Muy bien!\nHas tenido una racha de lecturas',
        content: 'Continua leyendo cada día y acumularás\nracha en tu perfil.',
        btnLabel: 'Genial!');
  }
}
