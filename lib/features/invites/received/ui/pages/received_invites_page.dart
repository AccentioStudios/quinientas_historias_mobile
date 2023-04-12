import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/ui/widgets/group_avatar.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../core/mixins/bottom_sheet_messages.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/layouts/layout_with_footer.dart';
import '../../../../../core/ui/pages/common_page_layout.dart';
import '../../../../auth/auth_provider.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../../../send/ui/widgets/team_list_item.dart';
import '../cubit/received_invites_cubit.dart';

class ReceivedInvitesPage extends StatefulWidget
    with ErrorHandling, SheetMessages {
  const ReceivedInvitesPage(
      {Key? key, required this.inviteId, required this.code})
      : super(key: key);

  final int inviteId;
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
    context
        .read<ReceivedInvitesCubit>()
        .validateCode(widget.inviteId, widget.code, onSuccess: () {},
            onError: (HttpFailure error) {
      widget.handleError(context, error);
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
            : state.invite?.accepted == false
                ? ReceivedInvitationMessage(
                    headline: getHeader(state.invite),
                    message: getSubtitle(state.invite),
                    team: state.invite?.team,
                    onAccept: () =>
                        navigateToAcceptInvite(context, invite: state.invite!),
                  )
                : CommonInfoPage(
                    headline: 'Esta invitación ya no es válida',
                    message:
                        'Has recibido una invitación para formar parte de 500Historias. Sin embargo, parece que ya no es válida o ya fué usada.',
                    svgImagePath: 'assets/images/broken-invitation-image.svg',
                    btnLabel: 'Entiendo',
                    onBtnTap: () {
                      Navigator.of(context).pop(false);
                    },
                  );
      },
    );
  }

  navigateToAcceptInvite(BuildContext context, {required Invite invite}) async {
    // If user is logged in, navigate to accept invite page
    final session = await SecureStorageHelper.getSessionData();
    if (session != null) {
      if (context.mounted) {
        UserManagementProvider()
            .openAcceptInvite(context, invite: invite, session: session);
        return;
      }
    }
    // If invite has an invited user, try to login and then repeat the process with user logged in
    if (invite.invitedId != null) {
      if (context.mounted) {
        await widget.showMessage<bool>(context,
            content:
                'Debes iniciar sesión, te mandaremos a la pantalla de inicio de sesión para que puedas continuar.',
            title: 'Iniciar sesión');
      }
      final loginSuccess = await loginFirst();
      if (loginSuccess) {
        if (context.mounted) {
          navigateToAcceptInvite(context, invite: invite);
        }
        return;
      }
    }

    // If invite is for a new user, navigate to register page an then repeat the process with user logged in
    if (invite.invited == null) {
      if (context.mounted) {
        await widget.showMessage<bool>(context,
            content:
                'Para continuar debes crear una cuenta.\nTe mandaremos a la pantalla de registro para que puedas continuar.',
            title: 'Bienvenido a 500Historias');
      }
      if (context.mounted) {
        final registerSuccess =
            await registerUserFirst(context, invite: invite);
        if (registerSuccess) {
          if (context.mounted) {
            navigateToAcceptInvite(context, invite: invite);
          }
          return;
        }
      }
    }
  }

  loginFirst() {
    return const AuthProvider().login(context);
  }

  registerUserFirst(BuildContext context, {required Invite invite}) {
    return UserManagementProvider()
        .openRegisterReader(context, invite: invite, autoNavigateToHome: false);
  }

  String getHeader(Invite? invite) {
    if (invite?.invitedRole == Role.captain) {
      return '${invite?.inviter?.firstName} te ha invitado a ser capitán';
    }
    if (invite?.invitedRole == Role.reader) {
      return '${invite?.inviter?.firstName} te ha invitado a formar parte del torneo como lector';
    }
    return '${invite?.inviter?.firstName} te ha invitado a formar parte del torneo';
  }

  String getSubtitle(Invite? invite) {
    if (invite?.invitedRole == Role.captain) {
      return 'Has recibido una invitacion para ser capitán y formar tu equipo en la escuela "${invite?.school?.name}"';
    }
    if (invite?.invitedRole == Role.reader) {
      return 'Has recibido una invitacion para formar parte del equipo:';
    }
    return 'Has recibido una invitacion para formar parte de 500 Historias';
  }
}

class ReceivedInvitationMessage extends StatelessWidget {
  const ReceivedInvitationMessage({
    super.key,
    this.headline = 'Te han invitado a formar parte de 500 Historias',
    this.message =
        'Has recibido una invitacion para formar parte de 500 Historias en el equipo:',
    this.team,
    required this.onAccept,
  });

  final String headline;
  final String message;
  final Team? team;
  final VoidCallback onAccept;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).popUntil((route) {
              return route.isFirst;
            });
          },
        ),
      ),
      body: LayoutWithFooter(
        padding: const EdgeInsets.symmetric(horizontal: Constants.space21),
        paddingFooter: const EdgeInsets.symmetric(
            horizontal: Constants.space21, vertical: Constants.space21),
        footer: BigButton(text: 'Aceptar invitación', onPressed: onAccept),
        children: [
          const SizedBox(height: 20),
          SizedBox(
            width: 130,
            child: SvgPicture.asset('assets/images/trophy-image.svg'),
          ),
          const SizedBox(height: 20),
          Text(
            headline,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          if (team != null)
            TeamListItem(
              avatarWidget: GroupAvatar(
                type: GroupAvatarType.team,
                avatarUrl: team!.avatarUrl,
              ),
              label: Text(team!.name),
            ),
        ],
      ),
    );
  }
}
