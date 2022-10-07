import 'package:flutter/material.dart';

import '../data/entities/daily_challenge_entity.dart';
import '../ui/widgets/custom_bottom_sheet.dart';
import '../utils/colors.dart';

mixin SheetMessages on Widget {
  Future<T?> showMessage<T>(
    BuildContext context, {
    CustomBottomSheetController? controller,
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
      useRootNavigator: true,
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
        controller: controller,
      ),
    );
  }

  Future<T?> showAddUserAvatarMessage<T>(BuildContext context) {
    return showMessage(
      context,
      height: 350,
      title: '¡Espera un momento!',
      content:
          '¿Estas seguro que quieres crear una cuenta sin foto de perfil?\n\nTener una foto de perfil ayuda a tus compañeros a identificar mejor quien eres.',
      btnLabel: 'Subir foto',
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

  Future<T?> showGenerateNewChallengeMessage<T>(BuildContext context,
      DailyChallenge dailyChallenge, Function(bool) callback) {
    CustomBottomSheetController controller = CustomBottomSheetController();

    if (dailyChallenge.diceCount == 0) {
      return showMessage(
        context,
        height: 300,
        iconSvgPath: 'assets/icons/dice-outline-xl-icon.svg',
        title: 'Acabaste todos tus dados',
        content:
            '¡Ya no hay más dados!\nEspera unos dias para que vuelvas a tener más.',
        btnLabel: '¡Ok!',
      );
    }

    if (dailyChallenge.count > dailyChallenge.readed) {
      return showMessage(
        context,
        height: 365,
        controller: controller,
        iconSvgPath: 'assets/icons/dice-outline-xl-icon.svg',
        title: 'Tirar los dados',
        content:
            'Al tirar los dados vas a generar un nuevo reto aleatorio.\n\nEstas seguro que quieres traer nuevas lecturas a tu reto diario? Vas a perder la lista de historias que tienes ahora.',
        btnLabel: 'Tirar los dados',
        btnOnTap: () {
          controller.closeSheet(true);
          return callback(true);
        },
        secondaryBtnLabel: 'No gracias',
        secondaryBtnOnTap: () {
          controller.closeSheet(false);
          return callback(false);
        },
      );
    } else {
      return showMessage(
        context,
        iconSvgPath: 'assets/icons/dice-outline-xl-icon.svg',
        title: 'Tirar los dados',
        content:
            '¡Completaste tu reto de hoy!\nVuelve mañana para que puedas generar un nuevo reto',
        btnLabel: '¡Ok!',
      );
    }
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
