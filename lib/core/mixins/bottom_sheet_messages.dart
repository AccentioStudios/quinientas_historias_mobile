import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../features/challenges/data/dto/register_new_challenge_response.dto.dart';
import '../data/entities/daily_challenge_entity.dart';
import '../data/entities/story_entity.dart';
import '../ui/widgets/custom_bottom_sheet.dart';
import '../ui/widgets/custom_inkwell.dart';
import '../ui/widgets/padding_column.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

mixin SheetMessages on Widget {
  Future<T?> showMessage<T>(
    BuildContext context, {
    CustomBottomSheetController? controller,
    String? iconSvgPath,
    Color? iconColor,
    required String title,
    required String content,
    Widget Function(BuildContext)? contentBuilder,
    Function? btnOnTap,
    String? btnLabel,
    Function? secondaryBtnOnTap,
    String? secondaryBtnLabel,
    double height = 320,
    bool willPop = true,
    bool isDismissible = true,
  }) {
    return showModalBottomSheet<T>(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      context: context,
      useRootNavigator: true,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0)),
      ),
      builder: (context) => WillPopScope(
        onWillPop: () async {
          if (willPop) {
            return true;
          } else {
            return false;
          }
        },
        child: MessagesBottomSheet(
          iconSvgPath: iconSvgPath,
          iconColor: iconColor,
          title: title,
          content: content,
          btnOnTap: btnOnTap,
          btnLabel: btnLabel,
          contentBuilder: contentBuilder,
          secondaryBtnOnTap: secondaryBtnOnTap,
          secondaryBtnLabel: secondaryBtnLabel,
          height: height,
          controller: controller,
        ),
      ),
    );
  }

  Future<T?> showCompactMessage<T>(
    BuildContext context, {
    CustomBottomSheetController? controller,
    String? iconSvgPath,
    Color? iconColor,
    required String title,
    Widget Function(BuildContext)? contentBuilder,
    Function? btnOnTap,
    String? btnLabel,
    Function? secondaryBtnOnTap,
    String? secondaryBtnLabel,
    double height = 320,
    bool willPop = true,
    bool isDismissible = true,
    bool withoutButtons = false,
    bool useRootNavigator = true,
  }) {
    return showModalBottomSheet<T>(
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      context: context,
      useRootNavigator: useRootNavigator,
      isDismissible: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23.0), topRight: Radius.circular(23.0)),
      ),
      builder: (context) => WillPopScope(
        onWillPop: () async {
          if (willPop) {
            return true;
          } else {
            return false;
          }
        },
        child: MessagesBottomSheet.compact(
          iconSvgPath: iconSvgPath,
          title: title,
          btnOnTap: btnOnTap,
          btnLabel: btnLabel,
          contentBuilder: contentBuilder,
          secondaryBtnOnTap: secondaryBtnOnTap,
          secondaryBtnLabel: secondaryBtnLabel,
          height: height,
          controller: controller,
          withoutButtons: withoutButtons,
        ),
      ),
    );
  }

  Future<T?> showAddUserAvatarMessage<T>(BuildContext context) {
    return showMessage(
      context,
      height: 350,
      title: '¡Espera un momento!',
      content:
          'No puedes tener una cuenta sin foto de perfil.\n\nTener una foto de perfil ayuda a tus compañeros a identificar mejor quien eres.',
      btnLabel: 'Subir foto',
    );
  }

  Future<T?> showAddGroupAvatarMessage<T>(BuildContext context) {
    return showMessage(
      context,
      height: 350,
      title: '¡Espera un momento!',
      content:
          'No puede faltar una foto en este perfil.\n\nTener una foto ayuda a tus compañeros a identificar mejor que equipo es.',
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

  Future<T?> showInviteReadersMessage<T>(BuildContext context) {
    return showMessage<T?>(
      context,
      height: 300,
      iconSvgPath: 'assets/images/success-check-image.svg',
      title: '¡Muy bien!',
      content:
          'Has creado tu equipo, ahora invita a tus amigos a formar parte de el.',
      btnLabel: 'Invitar amigos',
      isDismissible: false,
    );
  }

  Future<T?> showInviteCaptainsMessage<T>(BuildContext context) {
    return showMessage<T?>(
      context,
      height: 300,
      iconSvgPath: 'assets/images/success-check-image.svg',
      title: '¡Muy bien!',
      content:
          'Has registrado tu escuela, ahora invita a capitanes para que puedan crear equipos y participar en el torneo',
      btnLabel: 'Invitar Capitanes',
      isDismissible: false,
    );
  }

  Future<T?> showAddQuizItemQuestion<T>(BuildContext context) {
    return showMessage<T?>(
      context,
      height: 300,
      iconSvgPath: 'assets/images/success-check-image.svg',
      title: 'Te gustaría aportar con una\npregunta nueva?',
      content:
          'Puedes crear preguntas nuevas que otros lectores pueden responder al terminar esta lectura.',
      btnLabel: 'Si',
      secondaryBtnLabel: 'No',
      isDismissible: false,
    );
  }

  Future<T?> showExploreStoryOrderBy<T>(BuildContext context,
      {StoryOrderBy? selectedOption}) {
    return showCompactMessage<T?>(context,
        height: 300,
        iconSvgPath: 'assets/icons/order-down-icon.svg',
        title: 'Ordenar por',
        withoutButtons: true,
        contentBuilder: (context) => PaddingColumn(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space21),
              children: [
                const SizedBox(height: Constants.space16),
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Icon(Icons.info_outline,
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                          'El orden viene dictado por las votaciones de los lectores a las historias.',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer)),
                    ),
                  ],
                ),
                const SizedBox(height: Constants.space21),
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: StoryOrderBy.values.length,
                  itemBuilder: (context, index) {
                    final bool selected = index == selectedOption?.index;
                    return CustomInkWell(
                      borderRadius: BorderRadius.circular(8),
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.04),
                      splashColor:
                          Theme.of(context).colorScheme.tertiaryContainer,
                      selected: selected,
                      onTap: () {
                        Navigator.of(context).pop(StoryOrderBy.values[index]);
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: Constants.space21),
                          width: double.infinity,
                          height: 47,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              StoryOrderBy.values[index].name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: selected
                                      ? Theme.of(context)
                                          .colorScheme
                                          .onTertiaryContainer
                                      : Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer),
                            ),
                          )),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(height: Constants.space12);
                  },
                ),
              ],
            ));
  }

  Future<T?> showSecretKeyFromNewChallenge<T>(
      BuildContext context, RegisterNewChallengeResponseDto dto) {
    return showMessage<T?>(
      context,
      iconSvgPath: 'assets/icons/secret-key-outline-xl-icon.svg',
      title: 'Esta es tu ID y tu llave secreta',
      content:
          'Para poder conectar con el API, necesitas tus\ncredenciales. Guardalas bien ya que será\nIMPOSIBLE volver a verlas.',
      contentBuilder: (context) => PaddingColumn(
        padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(children: [
                const TextSpan(
                  text:
                      'Para poder conectar con el API, necesitas tus credenciales. Guardalas bien ya que sera ',
                ),
                TextSpan(
                    text: 'IMPOSIBLE',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:
                            Theme.of(context).colorScheme.error.withBlue(100))),
                const TextSpan(
                  text: ' volver a verlas.',
                ),
              ])),
          const SizedBox(height: Constants.space21),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 19),
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SelectableText.rich(
                    TextSpan(
                      text: '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer,
                            fontWeight: FontWeight.w400,
                          ),
                      children: [
                        TextSpan(
                          text: 'uuid:\n',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextSpan(
                            text: dto.uuid, recognizer: TapGestureRecognizer()),
                        TextSpan(
                          text: '\n\nSecret Key:\n',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        TextSpan(
                            text: dto.secretKey,
                            recognizer: TapGestureRecognizer()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      btnLabel: 'Copiar y aceptar',
      isDismissible: false,
      willPop: false, // evita que se cierre al hacer tap fuera del bottom sheet
    );
  }
}
