import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/utils/constants.dart';
import '../../cubit/user_management_cubit.dart';

class RegisterReaderPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const RegisterReaderPage(
      {Key? key, required this.invite, required this.invitationCode})
      : super(key: key);
  final Invite invite;
  final String invitationCode;

  @override
  State<RegisterReaderPage> createState() => _RegisterReaderPageState();
}

class _RegisterReaderPageState extends State<RegisterReaderPage> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController passwordConfirmationController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.invite.invitedEmail);
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context
        .read<UserManagementCubit>()
        .initNewUser(widget.invite.invitedEmail, widget.invitationCode);
  }

  @override
  Widget build(BuildContext context) {
    final onChangeFields =
        context.read<UserManagementCubit>().saveNewUserChanges;

    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<UserManagementCubit, UserManagementState>(
          builder: (context, state) {
            return state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                    children: [
                      const SizedBox(height: 64),
                      PaddingColumn(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space30),
                        children: <Widget>[
                          RegisterUserAvatar(
                            isLoading: state.uploadingAvatar,
                            imagePath: state.registerUser?.avatarUrl,
                            onPressedUpload: () {
                              handleChooseAvatar(
                                  context.read<UserManagementCubit>(), state);
                            },
                          ),
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
                                      color:
                                          Theme.of(context).colorScheme.error),
                                ),
                                const SizedBox(height: Constants.space21),
                              ],
                            ),
                          Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: ThemedTextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: firstNameController,
                                            hintText: 'Nombre',
                                            onChanged: (firstName) =>
                                                onChangeFields(
                                                    firstName: firstName),
                                            validator: fieldValidate,
                                          ),
                                        ),
                                        const SizedBox(
                                            width: Constants.space16),
                                        Expanded(
                                          flex: 1,
                                          child: ThemedTextFormField(
                                            keyboardType: TextInputType.name,
                                            controller: lastNameController,
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
                                  const SizedBox(height: Constants.space16),
                                  ThemedTextFormField(
                                    keyboardType: TextInputType.emailAddress,
                                    prefixIconSvgPath:
                                        'assets/icons/mail-outline-icon.svg',
                                    enabled: false,
                                    hintText: 'Email',
                                    controller: emailController,
                                    validator: fieldValidate,
                                  ),
                                  const SizedBox(height: Constants.space16),
                                  ThemedTextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIconSvgPath:
                                        'assets/icons/lock-outline-icon.svg',
                                    controller: passwordController,
                                    hintText: 'Contraseña',
                                    obscureText: true,
                                    onChanged: (password) =>
                                        onChangeFields(password: password),
                                    validator: fieldValidatePassword,
                                  ),
                                  const SizedBox(height: Constants.space16),
                                  ThemedTextFormField(
                                    keyboardType: TextInputType.visiblePassword,
                                    prefixIconSvgPath:
                                        'assets/icons/lock-outline-icon.svg',
                                    controller: passwordConfirmationController,
                                    hintText: 'Confirmar Constraseña',
                                    obscureText: true,
                                    onChanged: (passwordConfirmation) =>
                                        onChangeFields(
                                            passwordConfirmation:
                                                passwordConfirmation),
                                    validator:
                                        fieldValidatePasswordConfirmation,
                                  ),
                                ],
                              )),
                          const SizedBox(height: Constants.space21),
                          BigButton(
                              text: 'Crear mi cuenta',
                              isLoading: state.isLoading,
                              onPressed: () => submit(context, state)),
                        ],
                      )
                    ],
                  ));
          },
        ),
      ),
    );
  }

  void handleChooseAvatar(
      UserManagementCubit cubit, UserManagementState state) async {
    TaskSnapshot? snapshot = await cubit.uploadPhoto(state);
    if (snapshot != null) {
      final avatarUrl = await snapshot.ref.getDownloadURL();
      cubit.saveNewUserChanges(avatarUrl: avatarUrl);
      return;
    }
    Fluttertoast.showToast(msg: 'Error al subir el avatar. Intenta nuevamente');
  }

  String? fieldValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Requerido.';
    }
    if (value.length < 4) {
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

  void submit(BuildContext context, UserManagementState state) {
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }

    if (state.registerUser?.avatarUrl != null) {
      context.read<UserManagementCubit>().registerNewUser(onSuccess: () {
        const secureStorage = FlutterSecureStorage();
        secureStorage.deleteAll();
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);

        Fluttertoast.showToast(
            msg: 'Bienvenido a 500Historias. Ahora puedes iniciar sesion');
      }, onError: (HttpFailure error) {
        widget.handleError(context, error);
      });
      return;
    }
    widget.showAddUserAvatarMessage(context).then((value) {
      if (value != null) {
        handleChooseAvatar(context.read<UserManagementCubit>(), state);
      }
    });
  }
}

class RegisterUserAvatar extends StatelessWidget {
  const RegisterUserAvatar({
    Key? key,
    this.isLoading = false,
    this.imagePath,
    this.onPressedUpload,
  }) : super(key: key);

  final bool? isLoading;
  final String? imagePath;
  final void Function()? onPressedUpload;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        if (isLoading == true)
          SizedBox(
            height: 138,
            width: 138,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Center(child: CircularProgressIndicator()),
            ),
          ),
        if (isLoading != true)
          SizedBox(
            height: 138,
            width: 138,
            child: imagePath != null
                ? CircleAvatar(
                    backgroundImage:
                        imagePath != null ? NetworkImage(imagePath!) : null,
                  )
                : OverflowBox(
                    maxHeight: 180,
                    maxWidth: 180,
                    child: Transform.translate(
                      offset: const Offset(-15, -12),
                      child: SvgPicture.asset(
                          'assets/images/user-register-avatar-empty-space-image.svg'),
                    ),
                  ),
          ),
        Positioned(
          bottom: -10,
          right: -18,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff385775),
                  borderRadius: Constants.borderRadius50),
              child: SizedBox(
                height: 37,
                child: TextButton.icon(
                  label: Text(
                    'Subir Foto',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  onPressed: onPressedUpload,
                  icon: Center(
                    child: SvgPicture.asset(
                        'assets/icons/camera-outline-icon.svg'),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
