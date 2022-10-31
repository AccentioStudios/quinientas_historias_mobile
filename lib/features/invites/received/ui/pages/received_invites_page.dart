import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/pages/common_page_layout.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../cubit/received_invites_cubit.dart';

class ReceivedInvitesPage extends StatefulWidget with ErrorHandling {
  const ReceivedInvitesPage({Key? key, required this.email, required this.code})
      : super(key: key);

  final String email;
  final String code;

  @override
  State<ReceivedInvitesPage> createState() => _ReceivedInvitesPageState();
}

class _ReceivedInvitesPageState extends State<ReceivedInvitesPage> {
  @override
  void didChangeDependencies() {
    validateCode();
    super.didChangeDependencies();
  }

  void validateCode() {
    context.read<ReceivedInvitesCubit>().validateCode(widget.email, widget.code,
        onSuccess: () {}, onError: (HttpFailure error) {
      widget.handleError(context, error, onTap: () {
        SecureStorageHelper.deleteAll();
        Navigator.of(context, rootNavigator: true).pushNamed(Routes.login);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivedInvitesCubit, ReceivedInvitesState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : state.invite?.accepted == 0
                ? CommonPageLayout(
                    headline: getHeader(state.invite),
                    message: getSubtitle(state.invite),
                    svgImagePath: 'assets/images/trophy-image.svg',
                    btnLabel: 'Aceptar invitación',
                    onBtnTap: () {
                      navigateToRegisterUser(context,
                          invite: state.invite!, code: widget.code);
                    },
                  )
                : CommonPageLayout(
                    headline: 'Esta invitación ya no es válida',
                    message:
                        'Has recibido una invitación para formar parte de 500Historias. Sin embargo, parece que ya no es válida o ya fué usada.',
                    svgImagePath: 'assets/images/broken-invitation-image.svg',
                    btnLabel: 'Entiendo',
                    onBtnTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .popUntil((route) => route.isFirst);
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(Routes.login);
                    },
                  );
      },
    );
  }

  String getHeader(Invite? invite) {
    if (invite?.invitedType == UserType.captain) {
      return '${invite?.inviter?.firstName} te ha invitado a ser capitán';
    }
    if (invite?.invitedType == UserType.reader) {
      return '${invite?.inviter?.firstName} te ha invitado a formar parte del torneo como lector';
    }
    return '${invite?.inviter?.firstName} te ha invitado a formar parte del torneo';
  }

  String getSubtitle(Invite? invite) {
    if (invite?.invitedType == UserType.captain) {
      return 'Has recibido una invitacion para ser capitán y formar tu equipo en la escuela "${invite?.school?.name}"';
    }
    if (invite?.invitedType == UserType.reader) {
      return 'Has recibido una invitacion para formar parte del equipo:\n\n"${invite?.team?.name}" de la escuela "${invite?.school?.name}"';
    }
    return 'Has recibido una invitacion para formar parte de 500 Historias';
  }

  navigateToRegisterUser(BuildContext context,
      {required Invite invite, required String code}) {
    UserManagementProvider()
        .openRegisterReader(context, invite: invite, code: code);
  }
}
