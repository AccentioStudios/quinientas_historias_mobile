import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/data/entities/school_entity.dart';

import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/send_invites_cubit.dart';
import '../widgets/team_list_item.dart';

class ChooseSchoolForInvitePage extends StatefulWidget with ErrorHandling {
  const ChooseSchoolForInvitePage({super.key, this.role = Role.reader});
  final Role role;
  @override
  State<ChooseSchoolForInvitePage> createState() =>
      _ChooseSchoolForInvitePageState();
}

class _ChooseSchoolForInvitePageState extends State<ChooseSchoolForInvitePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getSchools();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => getSchools(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Elige la escuela',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SafeArea(child: SingleChildScrollView(
          child: BlocBuilder<SendInvitesCubit, SendInvitesState>(
            builder: (context, state) {
              return state.isLoading
                  ? SizedBox(
                      height: MediaQuery.sizeOf(context).height -
                          MediaQuery.of(context).viewInsets.top -
                          80,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : PaddingColumn(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space16,
                          vertical: Constants.space16),
                      children: [
                          Text(
                            'Selecciona la escuela al que quieres invitar nuevos ${formatRole(widget.role)}.',
                            style: const TextStyle(fontSize: 16),
                          ),
                          const Headline(label: 'Escuelas'),
                          ...state.adminSchools.map(
                            (school) => Padding(
                              padding: const EdgeInsets.only(
                                  bottom: Constants.space16),
                              child: GroupListItem(
                                  avatarWidget: GroupAvatar(
                                    avatarUrl: school.avatarUrl,
                                    type: GroupAvatarType.school,
                                  ),
                                  label: AutoSizeText(
                                    school.name,
                                    textAlign: TextAlign.left,
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(fontSize: 15),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  onTap: () {
                                    chooseSchool(context, school);
                                  }),
                            ),
                          ),
                        ]);
            },
          ),
        )),
      ),
    );
  }

  String formatRole(Role role) {
    switch (role) {
      case Role.reader:
        return 'lectores';
      case Role.prof:
        return 'profesores';
      case Role.captain:
        return 'capitanes';
      case Role.editor:
        return 'editores';
      case Role.jury:
        return 'jurados';
      default:
        return 'usuarios';
    }
  }

  void chooseSchool(BuildContext context, School school) {
    Navigator.of(context).pop(school);
  }

  getSchools() {
    context
        .read<SendInvitesCubit>()
        .getSchoolsForAdmin()
        .onError<HttpFailure>((error, stackTrace) {
      widget.handleError(context, error);
    });
  }
}
