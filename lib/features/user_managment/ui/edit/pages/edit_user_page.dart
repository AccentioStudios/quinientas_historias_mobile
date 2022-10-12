import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
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
import '../../widgets/user_management_user_avatar.dart';

class EditUserPage extends StatefulWidget with ErrorHandling, SheetMessages {
  const EditUserPage({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  late final TextEditingController emailController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.user.email);
    firstNameController = TextEditingController(text: widget.user.firstName);
    lastNameController = TextEditingController(text: widget.user.lastName);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<UserManagementCubit>().loadUser(widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final onChangeFields =
        context.read<UserManagementCubit>().saveUserManagementRequestChanges;

    return Scaffold(
      appBar: AppBar(elevation: 0),
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
                      const SizedBox(height: 24),
                      PaddingColumn(
                        padding: const EdgeInsets.symmetric(
                            horizontal: Constants.space30),
                        children: <Widget>[
                          RegisterUserAvatar(state: state),
                          const Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: Headline(label: 'Editar datos'),
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
                                ],
                              )),
                          const SizedBox(height: Constants.space21),
                          BigButton(
                              text: 'Guardar cambios',
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

  void submit(BuildContext context, UserManagementState state) async {
    UserManagementCubit cubit = context.read<UserManagementCubit>();

    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }

    if (state.userManagementRequest?.avatarUrl == null &&
        state.avatarMemory == null) {
      widget.showAddUserAvatarMessage(context).then((value) async {
        if (value != null) {
          cubit.handleSaveAvatarMemory(await cubit.pickPhoto());
        }
      });
      return;
    }

    cubit.editUser(onSuccess: () {
      Fluttertoast.showToast(msg: 'Guardados los cambios');
      Navigator.of(context).pop(true);
    }, onError: (HttpFailure error) {
      widget.handleError(context, error);
    });
  }
}
