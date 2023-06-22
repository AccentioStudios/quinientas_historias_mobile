import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/integrations/firebase_messaging_service.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/functions.dart';
import '../../cubit/user_management_cubit.dart';
import '../../widgets/user_management_user_avatar.dart';

class RegisterReaderPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const RegisterReaderPage(
      {super.key, required this.invite, this.autoNavigateToHome = true});
  final Invite invite;
  final bool? autoNavigateToHome;
  @override
  State<RegisterReaderPage> createState() => _RegisterReaderPageState();
}

class _RegisterReaderPageState extends State<RegisterReaderPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmationController;
  late final TextEditingController firstNameController;
  late final TextEditingController usernameController;
  late final TextEditingController lastNameController;
  late final FirebaseMessagingService firebaseMessagingService;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.invite.invitedEmail);
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    usernameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    firebaseMessagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<UserManagementCubit>()
        .initNewUser(widget.invite.invitedEmail, widget.invite);
  }

  @override
  Widget build(BuildContext context) {
    final onChangeFields = context.read<UserManagementCubit>().saveChanges;

    return BlocBuilder<UserManagementCubit, UserManagementState>(
      builder: (context, state) {
        return Scaffold(
            appBar: (state.isLoading || state.registeringUser)
                ? null
                : AppBar(elevation: 0, backgroundColor: Colors.transparent),
            body: SafeArea(
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : state.registeringUser
                      ? const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 300,
                                height: 300,
                                child: RiveAnimation.asset(
                                  'assets/images/circular-satelital-loading-animation.riv',
                                  alignment: Alignment.center,
                                ),
                              ),
                              SizedBox(height: Constants.space21),
                              Text(
                                'Creando cuenta...',
                                style: TextStyle(fontSize: 20),
                              ),
                              SizedBox(height: Constants.space21),
                            ],
                          ),
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
                                  RegisterUserAvatar(state: state),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 18),
                                    child: Headline(label: 'Crear Cuenta'),
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
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: ThemedTextFormField(
                                                    keyboardType:
                                                        TextInputType.name,
                                                    controller:
                                                        firstNameController,
                                                    hintText: 'Nombre',
                                                    onChanged: (firstName) =>
                                                        onChangeFields(
                                                            firstName:
                                                                firstName),
                                                    validator: fieldValidate,
                                                  ),
                                                ),
                                                const SizedBox(
                                                    width: Constants.space16),
                                                Expanded(
                                                  flex: 1,
                                                  child: ThemedTextFormField(
                                                    keyboardType:
                                                        TextInputType.name,
                                                    controller:
                                                        lastNameController,
                                                    hintText: 'Apellido',
                                                    onChanged: (lastName) =>
                                                        onChangeFields(
                                                            lastName: lastName),
                                                    validator: fieldValidate,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            prefixIconSvgPath:
                                                'assets/icons/mail-outline-icon.svg',
                                            enabled: false,
                                            hintText: 'Email',
                                            controller: emailController,
                                            validator: fieldValidate,
                                          ),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            prefixIconSvgPath:
                                                'assets/icons/user-outline-icon.svg',
                                            enabled: true,
                                            hintText: 'Nombre de usuario',
                                            controller: usernameController,
                                            onChanged: (username) =>
                                                onChangeFields(
                                                    username: username),
                                            validator: fieldValidate,
                                          ),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            prefixIconSvgPath:
                                                'assets/icons/lock-outline-icon.svg',
                                            controller: passwordController,
                                            hintText: 'Contraseña',
                                            obscureText: true,
                                            onChanged: (password) =>
                                                onChangeFields(
                                                    password: password),
                                            validator: fieldValidatePassword,
                                          ),
                                          const SizedBox(
                                              height: Constants.space16),
                                          ThemedTextFormField(
                                            keyboardType:
                                                TextInputType.visiblePassword,
                                            prefixIconSvgPath:
                                                'assets/icons/lock-outline-icon.svg',
                                            controller:
                                                passwordConfirmationController,
                                            hintText: 'Confirmar Constraseña',
                                            obscureText: true,
                                            onChanged: (passwordConfirmation) =>
                                                onChangeFields(
                                                    passwordConfirmation:
                                                        passwordConfirmation),
                                            validator:
                                                fieldValidatePasswordConfirmation,
                                            onFieldSubmitted: (_) => submit(
                                                context,
                                                state,
                                                firebaseMessagingService),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(height: Constants.space21),
                                  BigButton(
                                      text: 'Crear mi cuenta',
                                      isLoading: state.isLoading,
                                      onPressed: () => submit(context, state,
                                          firebaseMessagingService)),
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

  String? fieldValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido.';
    }
    if (value.length < 3) {
      return 'Necesitas introducir un texto mayor';
    }
    return null;
  }

  String? fieldValidatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 4) {
      return 'Debe ser mayor o igual a 4 caracteres.';
    }
    return null;
  }

  String? fieldValidatePasswordConfirmation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido.';
    }
    if (value != passwordController.text) {
      return 'La confirmacion de contraseña no coincide.';
    }
    return null;
  }

  void submit(BuildContext context, UserManagementState state,
      FirebaseMessagingService firebaseMessagingService) {
    // Get Firebase Token
    String? firebaseToken;
    if (!kIsWeb) {
      firebaseMessagingService
          .getDeviceFirebaseToken()
          .then((value) => {firebaseToken = value});
    }
    UserManagementCubit cubit = context.read<UserManagementCubit>();
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }

    if ((state.user?.avatarUrl == null || state.user?.avatarUrl == '') &&
        state.avatarMemory == null) {
      widget.showAddUserAvatarMessage(context).then((value) async {
        if (value != null) {
          cubit.handleSaveAvatarMemory(await pickPhoto(
              webUiSettings: Constants.getWebUiSettings(context)));
        }
      });
      return;
    }
    cubit.registerNewUser(firebaseToken, onSuccess: () {
      if (widget.autoNavigateToHome == true) {
        Navigator.of(context, rootNavigator: true)
            .pushNamed(Routes.homeNavigator);
        Fluttertoast.showToast(msg: 'Bienvenido a 500Historias');
      } else {
        Navigator.of(context).pop(true);
        Fluttertoast.showToast(msg: 'Bienvenido a 500Historias');
      }
    }, onError: (HttpFailure error) {
      widget.handleError(context, error, onTap: () {
        Navigator.of(context).pop(false);
      });
    });
    return;
  }
}
