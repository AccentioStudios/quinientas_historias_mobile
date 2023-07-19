import 'package:auto_route/annotations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/ui/widgets/custom_inkwell.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/quiz/domain/bloc/cubit/quiz_cubit.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/ui/widgets/creating_loading_screen.dart';
import '../../../../core/ui/widgets/outlined_card.dart';
import '../../../../core/utils/colors.dart';
import 'package:form_conversation/form_conversation.dart';

@RoutePage()
class RegisterQuizItemPage extends StatefulWidget with ErrorHandling {
  const RegisterQuizItemPage({
    super.key,
    required this.story,
  });

  final Story story;

  @override
  State<RegisterQuizItemPage> createState() => _RegisterQuizItemPageState();
}

class _RegisterQuizItemPageState extends State<RegisterQuizItemPage> {
  late FormController controller;

  String question = '';
  String correctAnswer = '';
  String explanation = '';
  String incorrectAnswer1 = '';
  String incorrectAnswer2 = '';
  String incorrectAnswer3 = '';
  String points = '';

  @override
  void initState() {
    controller = FormController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        var formActionPoints = FormAction(
          delay: 300,
          tag: 'points',
          name: 'Puntaje',
          text: 'Cuantos puntos va a dar por esta pregunta?',
          edit: false,
          builder: (context, tag, edit) {
            return FormButton(
              backgroundColor: primaryDarkColor,
              label: 'Seleccionar',
              onPressed: () {
                FormModal.showModal(
                  context: context,
                  title: 'Selecciona un puntaje',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ValueListenableBuilder<String>(
                      valueListenable: controller.getValue(tag),
                      builder: (_, value, child) {
                        return Column(
                          children: [
                            RadioListTile(
                              activeColor: primaryDarkColor,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(
                                "15",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .shade50,
                                    ),
                              ),
                              value: "15",
                              groupValue: value,
                              onChanged: (value) {
                                controller.setValue(tag, value);
                              },
                            ),
                            RadioListTile(
                              activeColor: primaryDarkColor,
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(
                                "10",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary
                                          .shade50,
                                    ),
                              ),
                              value: "10",
                              groupValue: value,
                              onChanged: (value) {
                                controller.setValue(tag, value);
                                setState(() {
                                  points = value.toString();
                                });
                              },
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FormButton(
                                backgroundColor: primaryDarkColor,
                                label: 'Confirmar',
                                onPressed: () {
                                  Navigator.pop(context);
                                  controller.addToScreenAnswer(
                                    tag: tag,
                                    edit: edit,
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        );
        return Scaffold(
          body: Stack(
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: Theme.of(context)
                      .colorScheme
                      .copyWith(primary: primaryContainerDarkColor),
                ),
                child: FormConversation(
                  controller: controller,
                  formStyle: FormStyle(
                    appBar: state.registeringQuizItem
                        ? null
                        : AppBar(
                            title: const Text('Crear nueva pregunta'),
                            elevation: 0,
                            backgroundColor: Colors.transparent,
                            // actions: [
                            //   // IconButton(
                            //   //   icon: const Icon(Icons.help_outline),
                            //   //   onPressed: () =>
                            //   //       navigateToOnBoarding(context),
                            //   // ),
                            // ],
                          ),
                  ),
                  formIconButtonStyle: FormIconButtonStyle(
                    iconColor: Theme.of(context).colorScheme.primary,
                    backgroundColor: Colors.transparent,
                    backgroundColorDisabled: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withOpacity(0.5),
                    iconColorDisabled: Theme.of(context)
                        .colorScheme
                        .onPrimaryContainer
                        .withOpacity(0.4),
                    elevation: 0,
                  ),
                  formTextFieldStyle: FormTextFieldStyle(
                    cursorColor: Theme.of(context).colorScheme.primaryContainer,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.primaryContainer,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32),
                        borderSide: const BorderSide(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      prefix: const SizedBox(width: 16),
                      hintStyle:
                          Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: primaryDarkColor,
                              ),
                      errorStyle: const TextStyle(
                          height: 0, wordSpacing: 1, fontSize: 10),
                    ),
                  ),
                  formItems: [
                    FormMessage(
                      text:
                          'Hola! 😃 Vamos a crear tu pregunta nueva para la lectura “${widget.story.title}”',
                      delay: 300,
                    ),
                    FormMessage(
                      text:
                          'Los requisitos para que tu pregunta sea aprobada por el lector son:\n\n   ●  Tiene que estar relacionada a la lectura \n  ●  Tiene que tener buena ortografía\n  ●  Tiene que ser de comprensión lectora.\n\nEl autor de la historia deberá aprobar tu pregunta para poder aparecer pública.',
                      delay: 1000,
                    ),
                    FormAction(
                      delay: 300,
                      tag: 'question',
                      name: 'Pregunta',
                      text: '¿Cuál es tu pregunta?',
                      edit: true,
                      builder: (context, tag, edit) {
                        return FormTextFieldAndButton(
                          tag: tag,
                          edit: edit,
                          hintText: 'Escribe la pregunta',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length <= 3) {
                              return '';
                            }
                            return null;
                          },
                          formController: controller,
                          onChanged: (value) {
                            controller.setValue(tag, value);
                            setState(() {
                              question = value.toString();
                            });
                          },
                        );
                      },
                    ),
                    FormAction(
                      delay: 300,
                      tag: 'correctAnswer',
                      name: 'Opción correcta',
                      text:
                          'Perfecto. Ahora escribe la opción correcta a esa pregunta.',
                      edit: true,
                      builder: (context, tag, edit) {
                        return FormTextFieldAndButton(
                          tag: tag,
                          edit: edit,
                          hintText: 'Escribe la opción correcta',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length <= 3) {
                              return '';
                            }
                            return null;
                          },
                          formController: controller,
                          onChanged: (value) {
                            controller.setValue(tag, value);

                            setState(() {
                              correctAnswer = value.toString();
                            });
                          },
                        );
                      },
                    ),
                    FormAction(
                      delay: 300,
                      tag: 'explanation',
                      name: 'explicacion',
                      text: 'Ahora debes explicar porque es la correcta.',
                      edit: true,
                      builder: (context, tag, edit) {
                        return FormTextFieldAndButton(
                          tag: tag,
                          edit: edit,
                          hintText: 'Escribe la explicación',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null &&
                                value.length <= 3 &&
                                value.length >= 100) {
                              return '';
                            }
                            return null;
                          },
                          formController: controller,
                          onChanged: (value) {
                            controller.setValue(tag, value);
                          },
                        );
                      },
                    ),
                    FormMessage(
                      text:
                          '¡Genial! 😃 Ahora debes escribir minimo otras 3 opciones equivocadas. Intenta que no sean muy obvias. Debe ser un reto para el lector.',
                      delay: 300,
                    ),
                    FormAction(
                      delay: 300,
                      tag: 'option-2',
                      name: 'Opción 2',
                      text: 'Escribe tu opción 2.',
                      edit: true,
                      builder: (context, tag, edit) {
                        return FormTextFieldAndButton(
                          tag: tag,
                          edit: edit,
                          hintText: 'Escribe tu opción 2',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length <= 3) {
                              return '';
                            }
                            return null;
                          },
                          formController: controller,
                          onChanged: (value) {
                            controller.setValue(tag, value);
                          },
                        );
                      },
                    ),
                    FormAction(
                      delay: 300,
                      tag: 'option-3',
                      name: 'Opción 3',
                      text: 'Escribe tu opción 3.',
                      edit: true,
                      builder: (context, tag, edit) {
                        return FormTextFieldAndButton(
                          tag: tag,
                          edit: edit,
                          hintText: 'Escribe tu opción 3',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length <= 3) {
                              return '';
                            }
                            return null;
                          },
                          formController: controller,
                          onChanged: (value) {
                            controller.setValue(tag, value);
                          },
                        );
                      },
                    ),
                    FormAction(
                      delay: 300,
                      tag: 'option-4',
                      name: 'Opción 4',
                      text: 'Escribe tu opción 4.',
                      edit: true,
                      builder: (context, tag, edit) {
                        return FormTextFieldAndButton(
                          tag: tag,
                          edit: edit,
                          hintText: 'Escribe tu opción 4',
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value != null && value.length <= 3) {
                              return '';
                            }
                            return null;
                          },
                          formController: controller,
                          onChanged: (value) {
                            controller.setValue(tag, value);
                          },
                        );
                      },
                    ),
                    formActionPoints,
                    FormAction(
                        delay: 500,
                        tag: 'preview',
                        name: 'preview',
                        text: 'Listo. Hemos terminado.',
                        edit: false,
                        builder: (context, tag, edit) {
                          Future.delayed(const Duration(milliseconds: 10))
                              .then((value) {
                            controller
                                .addToScreen(generatePreviewWidget(context));
                            controller.buildNextItem();
                          });
                          return const SizedBox.shrink();
                        }),
                    FormAction(
                        delay: 500,
                        tag: 'confirmation+${DateTime.now().toString()}',
                        name: 'Confirmación',
                        text:
                            'Confirma. Si hay algun tipo de error, vuelve y toca el botón "Alterar" en la opción correspondiente arriba en el chat.',
                        edit: false,
                        builder: (context, tag, edit) {
                          return Theme(
                            data: ThemeData.dark().copyWith(
                              colorScheme: ThemeData.dark()
                                  .colorScheme
                                  .copyWith(primary: primaryDarkColor),
                            ),
                            child: Flex(
                              direction: Axis.horizontal,
                              children: [
                                Flexible(
                                  child: BigButton(
                                    onPressed: () {
                                      submitQuizItem(context, state);
                                    },
                                    text: 'Terminar',
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: BigButton(
                                    filled: false,
                                    onPressed: () {
                                      generateLastMessage(context, state);
                                    },
                                    text: 'Vista previa',
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: state.registeringQuizItem
                    ? Container(
                        color: Theme.of(context)
                            .colorScheme
                            .background
                            .withOpacity(0.8),
                        child: const CreatingLoadingScreen(
                          message: 'Enviando nueva pregunta...',
                        ),
                      )
                    : const SizedBox.shrink(),
              )
            ],
          ),
        );
      },
    );
  }

  generateLastMessage(BuildContext context, QuizState state) {
    controller.addToScreen(FormAction(
        delay: 500,
        tag: 'preview+${DateTime.now().toString()}',
        name: 'Preview ${DateTime.now().toString()}',
        text: 'Vista previa',
        edit: false,
        builder: (context, tag, edit) {
          Future.delayed(const Duration(milliseconds: 10)).then((value) {
            controller.addToScreen(generatePreviewWidget(context));
            controller.addToScreen(FormAction(
                delay: 500,
                tag: 'confirmation+${DateTime.now().toString()}',
                name: 'Confirmación',
                text:
                    'Confirma nuevamente. Si hay algun tipo de error, vuelve y toca el botón "Alterar" en la opción correspondiente arriba en el chat.',
                edit: false,
                builder: (context, tag, edit) {
                  return Theme(
                    data: ThemeData.dark().copyWith(
                      colorScheme: ThemeData.dark()
                          .colorScheme
                          .copyWith(primary: primaryDarkColor),
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Flexible(
                          child: BigButton(
                            onPressed: () {
                              submitQuizItem(context, state);
                            },
                            text: 'Terminar',
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: BigButton(
                            filled: false,
                            onPressed: () {
                              generateLastMessage(context, state);
                            },
                            text: 'Vista previa',
                          ),
                        ),
                      ],
                    ),
                  );
                }));
          });
          return const SizedBox.shrink();
        }));
  }

  FormWidget generatePreviewWidget(BuildContext context) {
    // list of all options
    List<String> options = [
      controller.getValue('correctAnswer').value,
      controller.getValue('option-2').value,
      controller.getValue('option-3').value,
      controller.getValue('option-4').value,
    ];

    return FormWidget(
      delay: 400,
      child: PreviewQuizWidget(
        points: points,
        question: question,
        options: options,
        controller: controller,
      ),
    );
  }

  submitQuizItem(
    BuildContext context,
    QuizState state,
  ) {
    context
        .read<QuizCubit>()
        .registerQuizItem(
          question: controller.getValue('question').value,
          correctAnswer: controller.getValue('correctAnswer').value,
          explanation: controller.getValue('explanation').value,
          incorrectAnswer1: controller.getValue('option-2').value,
          incorrectAnswer2: controller.getValue('option-3').value,
          incorrectAnswer3: controller.getValue('option-4').value,
          storyId: widget.story.id,
        )
        .then((value) {
      if (value == true) {
        Navigator.of(context).pop(true);
      }
    }, onError: (error) {
      widget.handleError(context, error, onTap: () {
        Navigator.of(context).pop(false);
        Navigator.of(context).pop(false);
      });
    });
  }
}

class PreviewQuizWidget extends StatelessWidget {
  const PreviewQuizWidget({
    super.key,
    required this.points,
    required this.question,
    required this.options,
    required this.controller,
  });

  final String points;
  final String question;
  final List<String> options;
  final FormController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3, top: 3),
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space21, vertical: Constants.space21),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: Constants.borderRadius18),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Vista Previa"),
              FittedBox(
                child: OutlinedCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Constants.space18,
                    vertical: Constants.space8,
                  ),
                  borderRadius: Constants.borderRadius23,
                  backgroundColor:
                      Theme.of(context).colorScheme.tertiaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(' + $points ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer)),
                      Text(
                        'Bonus',
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          AutoSizeText.rich(
            TextSpan(
              text: question,
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimaryContainer),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 30,
          ),
          ListView.separated(
              itemCount: 4,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(
                  height: Constants.space21,
                );
              },
              itemBuilder: (context, questionIndex) {
                return CustomInkWell(
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space21),
                      decoration: BoxDecoration(
                        color: questionIndex == 0
                            ? Theme.of(context).colorScheme.tertiaryContainer
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimaryContainer),
                      ),
                      height: 50,
                      child: Center(
                          child: AutoSizeText(
                        options[questionIndex],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ))),
                );
              }),
          const SizedBox(
            height: 5,
          ),
        ]),
      ),
    );
  }
}
