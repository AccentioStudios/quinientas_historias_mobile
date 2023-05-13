import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/creating_loading_screen.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/themed_dropdown.dart';
import '../../../../../core/ui/widgets/themed_multi_dropdown.dart';
import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/utils/constants.dart';
import '../../cubit/challenges_admin_cubit.dart';

@RoutePage()
class ChallengesAdminRegisterPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const ChallengesAdminRegisterPage({Key? key}) : super(key: key);

  // final ChallengesAdminCubit cubit;

  @override
  State<ChallengesAdminRegisterPage> createState() =>
      _ChallengesAdminRegisterPageState();

  // @override
  // Widget wrappedRoute(BuildContext context) {
  //   return BlocProvider<ChallengesAdminCubit>.value(value: cubit, child: this);
  // }
}

class _ChallengesAdminRegisterPageState
    extends State<ChallengesAdminRegisterPage> {
  late final TextEditingController nameController;
  late final TextEditingController urlController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    urlController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<ChallengesAdminCubit>().initNewChallenge();
  }

  @override
  Widget build(BuildContext context) {
    final onChangeFields = context.read<ChallengesAdminCubit>().saveChanges;

    return BlocBuilder<ChallengesAdminCubit, ChallengesAdminState>(
      builder: (context, state) {
        return Scaffold(
            appBar: state.loading
                ? null
                : AppBar(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    actions: [
                      // help button
                      IconButton(
                        icon: const Icon(Icons.help_outline),
                        onPressed: () => navigateToOnBoarding(context),
                      ),
                    ],
                  ),
            body: SafeArea(
              child: state.loading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.registeringChallenge
                      ? const CreatingLoadingScreen(
                          message: 'Creando nuevo reto...',
                        )
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
                                    padding: EdgeInsets.only(left: 18),
                                    child:
                                        Headline(label: 'Registrar nuevo reto'),
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
                                        const SizedBox(
                                            height: Constants.space21),
                                      ],
                                    ),
                                  Form(
                                      key: formKey,
                                      child: Column(
                                        children: [
                                          ThemedTextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: nameController,
                                            hintText: 'Nombre del reto',
                                            onChanged: (firstName) =>
                                                onChangeFields(name: firstName),
                                            validator: fieldValidate,
                                          ),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType: TextInputType.url,
                                            controller: urlController,
                                            hintText: 'Dirección URL del reto',
                                            onChanged: (url) =>
                                                onChangeFields(url: url),
                                            validator: fieldUrlValidate,
                                          ),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedMultiDropdown<String>(
                                              values: state.challenge?.triggers,
                                              items: const [
                                                MultDropdownMenuItem(
                                                  value: 'story-ended',
                                                  label: 'Lectura terminada',
                                                ),
                                                MultDropdownMenuItem(
                                                  value: 'story-init',
                                                  label: 'Lectura Iniciada',
                                                ),
                                                MultDropdownMenuItem(
                                                  value: 'first-session-of-day',
                                                  label:
                                                      'Primera sesión del día',
                                                ),
                                              ],
                                              hint: const Text(
                                                  "Triggers del reto"),
                                              onChanged: (value) {
                                                onChangeFields(triggers: value);
                                              },
                                              validator: multiSelectValidate),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedMultiDropdown<String>(
                                              values: state.challenge?.params,
                                              items: const [
                                                MultDropdownMenuItem(
                                                  value: 'story_id',
                                                  label: 'StoryId',
                                                ),
                                                MultDropdownMenuItem(
                                                  value: 'read_ended',
                                                  label: 'Lectura finalizada',
                                                ),
                                                MultDropdownMenuItem(
                                                  value: 'read_init',
                                                  label: 'Lectura iniciada',
                                                ),
                                              ],
                                              hint: const Text(
                                                  "Parametros del reto"),
                                              onChanged: (value) {
                                                onChangeFields(triggers: value);
                                              },
                                              validator: multiSelectValidate),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedDropdown<int>(
                                            hint:
                                                const Text('Puntaje del reto'),
                                            onChanged: (points) =>
                                                onChangeFields(points: points),
                                            validator: fieldPointsValidate,
                                            items: const [
                                              DropdownMenuItem(
                                                value: 15,
                                                child: Text('15'),
                                              ),
                                              DropdownMenuItem(
                                                value: 20,
                                                child: Text('20'),
                                              ),
                                              DropdownMenuItem(
                                                value: 25,
                                                child: Text('25'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [],
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: Constants.space21),
                                  BigButton(
                                      text: 'Registrar nuevo reto',
                                      isLoading: state.loading,
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

  void submit(BuildContext context, ChallengesAdminState state) {
    ChallengesAdminCubit cubit = context.read<ChallengesAdminCubit>();
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }
    cubit.registerNewChallenge().then((value) async {
      Fluttertoast.showToast(msg: 'Reto registrado correctamente.');
      await widget.showSecretKeyFromNewChallenge(context, value);
      if (context.mounted) {
        await Clipboard.setData(ClipboardData(
            text: 'uuid: ${value.uuid}\n\nsecretKey: ${value.secretKey}'));
      }
      if (context.mounted) {
        AutoRouter.of(context).pop(value);
      }
    }, onError: (error) {
      Fluttertoast.showToast(msg: 'Error al registrar el reto.');
    });
    return;
  }
}
