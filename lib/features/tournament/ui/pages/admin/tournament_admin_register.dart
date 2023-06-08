import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import '../../../../../core/data/entities/tag_entity.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/creating_loading_screen.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';

import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/utils/constants.dart';
import '../../bloc/cubit/tournament_admin_cubit.dart';

@RoutePage()
class TournamentAdminRegisterPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const TournamentAdminRegisterPage({super.key});

  @override
  State<TournamentAdminRegisterPage> createState() =>
      _TournamentAdminRegisterPageState();
}

class _TournamentAdminRegisterPageState
    extends State<TournamentAdminRegisterPage> {
  final formKey = GlobalKey<FormState>();
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController urlController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    urlController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<TournamentAdminCubit>().initNewTournament();
  }

  @override
  Widget build(BuildContext context) {
    final onChangeFields = context.read<TournamentAdminCubit>().saveChanges;

    return BlocBuilder<TournamentAdminCubit, TournamentAdminState>(
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
          child: state.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : state.creatingTournamentLoading
                  ? const CreatingLoadingScreen(
                      message: 'Creando nuevo torneo...',
                    )
                  // : Theme(
                  //     data: Theme.of(context).copyWith(
                  //       colorScheme: Theme.of(context)
                  //           .colorScheme
                  //           .copyWith(primary: primaryContainerDarkColor),
                  //     ),
                  //     child: FormConversation(
                  //         controller: controller,
                  //         formStyle: FormStyle(
                  //           appBar: state.isLoading
                  //               ? null
                  //               : AppBar(
                  //                   elevation: 0,
                  //                   backgroundColor: Colors.transparent,
                  //                   actions: [
                  //                     // IconButton(
                  //                     //   icon: const Icon(Icons.help_outline),
                  //                     //   onPressed: () =>
                  //                     //       navigateToOnBoarding(context),
                  //                     // ),
                  //                   ],
                  //                 ),
                  //         ),
                  //         formTextFieldStyle: FormTextFieldStyle(
                  //           cursorColor: Theme.of(context)
                  //               .colorScheme
                  //               .primaryContainer,
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //           ),
                  //           decoration: InputDecoration(
                  //             filled: true,
                  //             fillColor: Theme.of(context)
                  //                 .colorScheme
                  //                 .primaryContainer,
                  //             border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(32),
                  //               borderSide: const BorderSide(
                  //                 color: Colors.grey,
                  //                 width: 1,
                  //               ),
                  //             ),
                  //             prefix: const SizedBox(width: 16),
                  //             hintStyle: Theme.of(context)
                  //                 .textTheme
                  //                 .bodyMedium
                  //                 ?.copyWith(
                  //                   color: primaryDarkColor,
                  //                 ),
                  //             errorStyle: const TextStyle(
                  //                 height: 0,
                  //                 wordSpacing: 1,
                  //                 fontSize: 10),
                  //           ),
                  //         ),
                  //         formItems: [
                  //           FormMessage(
                  //             text: 'Hola! 😃',
                  //             delay: 1000,
                  //           ),
                  //           FormMessage(
                  //             text: 'Vamos a crear un nuevo torneo!',
                  //             delay: 1000,
                  //           ),
                  //           FormAction(
                  //             tag: 'name',
                  //             name: 'Nombre del torneo',
                  //             text: 'Escribe el nombre del nuevo torneo',
                  //             edit: true,
                  //             builder: (context, tag, edit) {
                  //               return FormTextFieldAndButton(
                  //                 tag: tag,
                  //                 edit: edit,
                  //                 hintText: 'Nombre del torneo',
                  //                 autovalidateMode:
                  //                     AutovalidateMode.onUserInteraction,
                  //                 validator: (value) {
                  //                   if (value != null &&
                  //                       value.length <= 3) {
                  //                     return '';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 formController: controller,
                  //               );
                  //             },
                  //           ),
                  //           FormAction(
                  //             tag: 'description',
                  //             name: 'Descripcion del torneo',
                  //             text:
                  //                 'Escribe una breve descripcion del torneo',
                  //             edit: true,
                  //             builder: (context, tag, edit) {
                  //               return FormTextFieldAndButton(
                  //                 tag: tag,
                  //                 edit: edit,
                  //                 hintText: 'Descripcion del torneo',
                  //                 autovalidateMode:
                  //                     AutovalidateMode.onUserInteraction,
                  //                 validator: (value) {
                  //                   if (value != null &&
                  //                       value.length <= 3) {
                  //                     return '';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 formController: controller,
                  //               );
                  //             },
                  //           ),
                  //           FormMessage(
                  //             text:
                  //                 'Perfecto! 😃 Ahora faltaria saber cuando comienza el torneo',
                  //             delay: 1000,
                  //           ),
                  //           FormAction(
                  //             tag: 'startAt',
                  //             name: 'Fecha de inicio del torneo',
                  //             text:
                  //                 'Escriba una fecha de inicio del torneo',
                  //             edit: true,
                  //             builder: (context, tag, edit) {
                  //               return FormTextFieldAndButton(
                  //                 tag: tag,
                  //                 edit: edit,
                  //                 hintText:
                  //                     '24/${DateTime.now().month + 1}/${DateTime.now().year}',
                  //                 autovalidateMode:
                  //                     AutovalidateMode.onUserInteraction,
                  //                 validator: (value) {
                  //                   if (value != null &&
                  //                       value.length <= 3) {
                  //                     return '';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 formController: controller,
                  //               );
                  //             },
                  //           ),
                  //           FormMessage(
                  //             text:
                  //                 'Ahora necesitariamos la fecha de finalizacion del torneo',
                  //             delay: 1000,
                  //           ),
                  //           FormAction(
                  //             tag: 'endAt',
                  //             name: 'Fecha de final del torneo',
                  //             text:
                  //                 'Escriba una fecha de finalización del torneo',
                  //             edit: true,
                  //             builder: (context, tag, edit) {
                  //               return FormTextFieldAndButton(
                  //                 tag: tag,
                  //                 edit: edit,
                  //                 hintText:
                  //                     '24/${DateTime.now().month + 1}/${DateTime.now().year}',
                  //                 autovalidateMode:
                  //                     AutovalidateMode.onUserInteraction,
                  //                 validator: (value) {
                  //                   if (value != null &&
                  //                       value.length <= 3) {
                  //                     return '';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 formController: controller,
                  //               );
                  //             },
                  //           ),
                  //           FormMessage(
                  //             text:
                  //                 'Correcto. Ahora para poder asociar las historias a este torneo particular necesitamos el tagId que viene de Wordpress.',
                  //             delay: 3000,
                  //           ),
                  //           FormMessage(
                  //             text:
                  //                 'Para obtenerlo, ingrese a la pagina de wordpress, busque una de las historias que por ejemplo quiere asociar y copie el tagId. Una vez que tenga el tagId, escribalo en el campo de abajo.',
                  //             delay: 5000,
                  //           ),
                  //           FormAction(
                  //             delay: 7000,
                  //             tag: 'tagId',
                  //             name: 'tagId del torneo',
                  //             text:
                  //                 'Escriba el tagId de las historias que quieres asociar al torneo.',
                  //             edit: true,
                  //             builder: (context, tag, edit) {
                  //               return FormTextFieldAndButton(
                  //                 tag: tag,
                  //                 edit: edit,
                  //                 hintText: 'tagId',
                  //                 autovalidateMode:
                  //                     AutovalidateMode.onUserInteraction,
                  //                 validator: (value) {
                  //                   if (value != null &&
                  //                       value.length <= 3) {
                  //                     return '';
                  //                   }
                  //                   return null;
                  //                 },
                  //                 formController: controller,
                  //               );
                  //             },
                  //           ),
                  //         ]),
                  //   )
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics()
                          .applyTo(const BouncingScrollPhysics()),
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          PaddingColumn(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Constants.space30),
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(
                                    left: 18, bottom: Constants.space30),
                                child:
                                    Headline(label: 'Registrar nuevo torneo'),
                              ),
                              if (state.error != null)
                                Column(
                                  children: [
                                    Text(
                                      'Hay algun problema con tus datos, revise cada uno e intenta nuevmaente',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .error),
                                    ),
                                    const SizedBox(height: Constants.space21),
                                  ],
                                ),
                              Form(
                                  key: formKey,
                                  child: Column(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Nombre del torneo'),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: nameController,
                                            hintText: 'Nombre del torneo',
                                            onChanged: (name) =>
                                                onChangeFields(name: name),
                                            validator: fieldValidate,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Constants.space16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text('Descripción del torneo'),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: descriptionController,
                                            hintText: 'Descripción del torneo',
                                            onChanged: (description) =>
                                                onChangeFields(
                                                    description: description),
                                            validator: fieldValidate,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Constants.space16),
                                      // Cupertino Button with date picker
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              'Fecha de Inicio del Torneo'),
                                          const SizedBox(
                                              height: Constants.space16),
                                          Container(
                                            height: 60,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Constants.space16),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: CupertinoButton(
                                              alignment: Alignment.centerLeft,
                                              onPressed: () {
                                                _showDialog(_DatePicker(
                                                  onDateTimeChanged:
                                                      (DateTime startAt) {
                                                    onChangeFields(
                                                        startAt: startAt);
                                                  },
                                                ));
                                              },
                                              child: SizedBox(
                                                height: 40,
                                                child: Text(
                                                  // Print the date in a pretty format. 12 hour time, with AM/PM prepended.
                                                  '${DateFormat('dd/MM/yyyy hh:mm a').format(state.tournament?.startAt ?? DateTime.now())}.',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Constants.space16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              'Fecha de final del Torneo'),
                                          const SizedBox(
                                              height: Constants.space16),
                                          Container(
                                            height: 60,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Constants.space16),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: CupertinoButton(
                                              alignment: Alignment.centerLeft,
                                              onPressed: () {
                                                _showDialog(_DatePicker(
                                                  onDateTimeChanged:
                                                      (DateTime endsAt) {
                                                    onChangeFields(
                                                        endsAt: endsAt);
                                                  },
                                                ));
                                              },
                                              child: SizedBox(
                                                height: 40,
                                                child: Text(
                                                  '${DateFormat('dd/MM/yyyy hh:mm a').format(state.tournament?.endsAt ?? DateTime.now())}.',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Constants.space16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                              'Tag ID de las historias a asociar'),
                                          const SizedBox(
                                              height: Constants.space16),
                                          Container(
                                            height: 60,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: Constants.space16),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(32),
                                            ),
                                            child: CupertinoButton(
                                              alignment: Alignment.centerLeft,
                                              onPressed: () {
                                                _showDialog(FutureBuilder(
                                                  future: context
                                                      .read<
                                                          TournamentAdminCubit>()
                                                      .getTagsFromWordpress(),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<dynamic>
                                                              snapshot) {
                                                    // show loading while snapshot is not getting data
                                                    if (!snapshot.hasData) {
                                                      return const Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    }
                                                    // show error if snapshot has error
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          '${snapshot.error}');
                                                    }
                                                    // get data from snapshot and pass it to list view builder
                                                    return _TagPicker(
                                                      initialItem: state
                                                              .tournament
                                                              ?.tagId ??
                                                          0,
                                                      tags: snapshot.data,
                                                      onSelectedItemChanged:
                                                          (Tag tag) {
                                                        onChangeFields(
                                                            tagId: tag.id);
                                                      },
                                                    );
                                                  },
                                                ));
                                              },
                                              child: SizedBox(
                                                height: 40,
                                                child: Text(
                                                  '${state.tournament?.tagId != 0 ? state.tournament?.tagId : "Escoje un tag"}',
                                                  textAlign: TextAlign.left,
                                                  style: const TextStyle(
                                                    fontSize: 22.0,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: Constants.space16),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: const Row(
                                          children: [],
                                        ),
                                      ),
                                    ],
                                  )),
                              const SizedBox(height: Constants.space21),
                              BigButton(
                                  text: 'Registrar nuevo torneo',
                                  isLoading: state.isLoading,
                                  onPressed: () => submit(context, state)),
                              const SizedBox(height: Constants.space41),
                            ],
                          )
                        ],
                      ),
                    ),
        ));
      },
    );
  }

  // This function displays a CupertinoModalPopup with a reasonable fixed height
  // which hosts CupertinoDatePicker.
  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 300,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: Theme.of(context).colorScheme.background,
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  void navigateToOnBoarding(BuildContext context) {
    context.router.push(OnboardingNewChallengeRoute(onResult: () {
      AutoRouter.of(context).pop();
    }));
  }

  String? fieldValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido.';
    }
    if (value.length < 3) {
      return 'Necesitas introducir un texto mayor';
    }
    return null;
  }

  String? fieldPointsValidate(int? value) {
    if (value == null) {
      return 'Requerido.';
    }

    return null;
  }

  String? multiSelectValidate(String? value) {
    return value != null && value.isNotEmpty
        ? null
        : 'Debes seleccionar al menos una opción.';
  }

  String? fieldUrlValidate(String? value) {
    if (value == null || value.isEmpty || value.length < 4) {
      return 'Debe ser mayor o igual a 4 caracteres.';
    }
    var urlPattern = r"^(?:(ftp|http|https):\/\/)?(?:[\w-]+\.)+[a-z]{2,24}$";
    var match = RegExp(urlPattern, caseSensitive: false).firstMatch(value);
    if (match == null) {
      return 'Debe ser una URL válida.';
    }
    return null;
  }

  void submit(BuildContext context, TournamentAdminState state) {
    TournamentAdminCubit cubit = context.read<TournamentAdminCubit>();
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }
    cubit.registerNewTournament().then((value) async {
      Fluttertoast.showToast(msg: 'Torneo registrado correctamente.');
      if (context.mounted) {
        AutoRouter.of(context).pop(value);
      }
    }, onError: (error) {
      Fluttertoast.showToast(msg: 'Error al registrar el Torneo.');
    });
    return;
  }
}

class _DatePicker extends StatelessWidget {
  const _DatePicker({
    required this.onDateTimeChanged,
  });

  final void Function(DateTime) onDateTimeChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: PaddingColumn(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space16, vertical: Constants.space16),
          children: [
            Expanded(
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: onDateTimeChanged,
              ),
            ),
            const SizedBox(height: Constants.space16),
            BigButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Seleccionar'),
          ],
        ));
  }
}

class _TagPicker extends StatelessWidget {
  const _TagPicker({
    required this.initialItem,
    required this.tags,
    required this.onSelectedItemChanged,
  });

  final int initialItem;
  final List<Tag> tags;
  final void Function(Tag) onSelectedItemChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 200,
        child: PaddingColumn(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space16, vertical: Constants.space16),
          children: [
            Expanded(
              child: CupertinoPicker(
                magnification: 1.22,
                squeeze: 1.2,
                itemExtent: 32.0,
                scrollController: FixedExtentScrollController(
                  initialItem:
                      tags.indexWhere((element) => element.id == initialItem),
                ),
                onSelectedItemChanged: (index) =>
                    onSelectedItemChanged(tags[index]),
                children: List<Widget>.generate(tags.length, (int index) {
                  return Center(
                      child: Text('${tags[index].id}. ${tags[index].name}'));
                }),
              ),
            ),
            const SizedBox(height: Constants.space16),
            BigButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: 'Seleccionar'),
          ],
        ));
  }
}
