import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/data/entities/school_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/themed_text_form_field.dart';
import '../../../../../core/utils/constants.dart';
import '../../../../../core/utils/functions.dart';
import '../../cubit/group_management_cubit.dart';
import '../../widgets/group_management_avatar.dart';

class RegisterSchoolPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const RegisterSchoolPage({super.key, this.join = false});
  final bool? join;
  @override
  State<RegisterSchoolPage> createState() => _RegisterSchoolPageState();
}

class _RegisterSchoolPageState extends State<RegisterSchoolPage> {
  late final TextEditingController schoolName;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    schoolName = TextEditingController(text: '');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<GroupManagementCubit>().initNewSchool();
  }

  @override
  Widget build(BuildContext context) {
    final onChangeFields =
        context.read<GroupManagementCubit>().saveGroupManagementRequestChanges;

    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: BlocBuilder<GroupManagementCubit, GroupManagementState>(
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
                          RegisterGroupAvatar(
                            state: state,
                            type: GroupAvatarType.school,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 18),
                            child: Headline(label: 'Registrar escuela'),
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
                                  ThemedTextFormField(
                                    prefixIconSvgPath:
                                        'assets/icons/group-outline-icon.svg',
                                    keyboardType: TextInputType.name,
                                    controller: schoolName,
                                    hintText: 'Nombre de la escuela',
                                    onChanged: (name) =>
                                        onChangeFields(name: name),
                                    validator: fieldValidate,
                                  ),
                                  const SizedBox(height: Constants.space16),
                                ],
                              )),
                          const SizedBox(height: Constants.space21),
                          BigButton(
                              text: 'Registrar escuela',
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

  void submit(BuildContext context, GroupManagementState state) {
    GroupManagementCubit cubit = context.read<GroupManagementCubit>();
    if (!formKey.currentState!.validate()) {
      Fluttertoast.showToast(msg: 'Verifica los datos e intenta nuevamente.');
      return;
    }
    if ((state.groupManagementRequest?.avatarUrl == null ||
            state.groupManagementRequest?.avatarUrl == '') &&
        state.avatarMemory == null) {
      widget.showAddSchoolAvatarMessage(context).then((value) async {
        if (value != null) {
          cubit.handleSaveAvatarMemory(await pickPhoto(
              webUiSettings: Constants.getWebUiSettings(context)));
        }
      });
      return;
    }
    cubit.registerNewSchool(
        join: widget.join,
        onSuccess: (school) {
          Navigator.of(context, rootNavigator: true).pop<School>(school);
        },
        onError: (HttpFailure error) {
          widget.handleError(context, error);
        });
    return;
  }
}
