import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    headline:
                        '${state.invite?.inviter?.firstName} te ha invitado a formar parte del torneo',
                    message:
                        'Has recibido una invitacion para formar parte del equipo:\n\n${state.invite?.team?.name} de la escuela ${state.invite?.school?.name}',
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
                        'Has recibido una invitación para formar parte de un equipo. Sin embargo, parece que ya no es válida o ya fué usada.',
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

  navigateToRegisterUser(BuildContext context,
      {required Invite invite, required String code}) {
    UserManagementProvider()
        .openRegisterReader(context, invite: invite, code: code);
  }
}
