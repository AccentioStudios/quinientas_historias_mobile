import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:quinientas_historias/core/data/entities/user_entity.dart';
import 'package:quinientas_historias/core/ui/widgets/big_button.dart';
import 'package:quinientas_historias/core/ui/widgets/group_avatar.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../../core/data/dto/auth_dto.dart';
import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/failures/failures.dart';
import '../../../../../core/integrations/secure_storage_service.dart';
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
      {super.key, required this.inviteId, required this.code});

  final int inviteId;
  final String code;

  @override
  State<ReceivedInvitesPage> createState() => _ReceivedInvitesPageState();
}

class _ReceivedInvitesPageState extends State<ReceivedInvitesPage> {
  bool acceptingIsLoading = false;
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
                    isLoading: acceptingIsLoading,
                    headline: getHeader(state.invite),
                    message: getSubtitle(state.invite),
                    team: state.invite?.team,
                    onAccept: () => verifyRequirementsToAcceptInvite(context,
                        invite: state.invite!),
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

  Future<JwtPayload?> checkSession() {
    return GetIt.I<SecureStorageService>().getSessionData();
  }

  Future<bool> checkIfUserNeedsToRegister({required Invite invite}) async {
    if (invite.invitedId == null) {
      return true;
    } else {
      return false;
    }
  }

  navigateToAcceptInvite(BuildContext context, {required Invite invite}) async {
    // If user is logged in, navigate to accept invite page
    if (context.mounted) {
      UserManagementProvider()
          .openAcceptInvite(context, invite: invite)
          .then((value) {
        setState(() {
          acceptingIsLoading = false;
        });
        return value;
      });
    }
  }

  verifyRequirementsToAcceptInvite(BuildContext context,
      {required Invite invite}) async {
    setState(() {
      acceptingIsLoading = true;
    });

    final needToRegister = await checkIfUserNeedsToRegister(invite: invite);
    final userSession = await checkSession();
    if (!mounted) return;
    if (needToRegister) {
      widget
          .showMessage<bool>(context,
              content:
                  'Para continuar debes crear una cuenta.\nTe mandaremos a la pantalla de registro para que puedas continuar.',
              title: 'Bienvenido a 500Historias')
          .then((value) {
        registerUserFirst(context, invite: invite);
      });
      return;
    }
    if (userSession == null) {
      widget
          .showMessage<bool>(context,
              content:
                  'Debes iniciar sesión, te mandaremos a la pantalla de inicio de sesión para que puedas continuar.',
              title: 'Iniciar sesión')
          .then((value) {
        loginFirst(invite: invite);
      });
      return;
    }
    await navigateToAcceptInvite(context, invite: invite);
  }

  void loginFirst({required Invite invite}) async {
    const AuthProvider().login(context).then((login) {
      if (login != true) throw Exception('Error al iniciar sesión');
      GetIt.I<SecureStorageService>()
          .getSessionData()
          .then((session) => navigateToAcceptInvite(context, invite: invite));
      setState(() {
        acceptingIsLoading = false;
      });
    }, onError: (error) {
      setState(() {
        acceptingIsLoading = false;
      });
      widget.showMessage<bool>(context,
          content:
              'No pudimos iniciar sesión, por favor intenta de nuevo más tarde.',
          title: 'Error al iniciar sesión');
      throw Exception('Error al iniciar sesión');
    });
  }

  registerUserFirst(BuildContext context, {required Invite invite}) {
    UserManagementProvider()
        .openRegisterReader(context, invite: invite, autoNavigateToHome: false)
        .then((value) {
      if (value != true) throw Exception('Error al registrar');
      navigateToAcceptInvite(context, invite: invite);
      setState(() {
        acceptingIsLoading = false;
      });
    }, onError: (error) {
      setState(() {
        acceptingIsLoading = false;
      });
      widget.showMessage<bool>(context,
          content:
              'No pudimos crear tu cuenta, por favor intenta de nuevo más tarde.',
          title: 'Error al crear tu cuenta');
      throw Exception('Error al registrar');
    });
  }

  String getHeader(Invite? invite) {
    if (invite != null) {
      switch (invite.invitedRole) {
        case Role.admin:
          return '${invite.inviter?.firstName} te ha invitado a formar parte de 500Historias como administrador';
        case Role.reader:
          return '${invite.inviter?.firstName} te ha invitado a formar parte del torneo como lector';
        case Role.captain:
          return '${invite.inviter?.firstName} te ha invitado a ser capitán';
        case Role.prof:
          return '${invite.inviter?.firstName} te ha invitado a formar parte de 500Historias como profesor';
        default:
          return '${invite.inviter?.firstName} te ha invitado a formar parte de 500Historias';
      }
    } else {
      return 'Error al cargar la invitación';
    }
  }

  String getSubtitle(Invite? invite) {
    if (invite != null) {
      switch (invite.invitedRole) {
        case Role.admin:
          return '${invite.inviter?.firstName} te ha invitado a formar parte de 500Historias como administrador, esto significa que podrás administrar el sistema y crear torneos.';
        case Role.reader:
          return 'Has recibido una invitacion para formar parte del equipo:';
        case Role.captain:
          return 'Has recibido una invitacion para ser capitán y formar tu equipo en la escuela "${invite.school?.name}"';
        case Role.prof:
          return '${invite.inviter?.firstName} te ha invitado a formar parte de 500Historias, esto significa que podrás registrar tu escuela e invitar capitanes y lectores.';
        default:
          return 'Has recibido una invitacion para formar parte de 500 Historias';
      }
    } else {
      return 'Error al cargar la invitación';
    }
  }
}

class ReceivedInvitationMessage extends StatelessWidget {
  const ReceivedInvitationMessage({
    super.key,
    this.headline = 'Te han invitado a formar parte de 500 Historias',
    this.message =
        'Has recibido una invitacion para formar parte de 500 Historias en el equipo:',
    this.team,
    this.isLoading = false,
    required this.onAccept,
  });

  final String headline;
  final String message;
  final Team? team;
  final VoidCallback onAccept;
  final bool isLoading;

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
        footer: BigButton(
          text: 'Aceptar invitación',
          onPressed: onAccept,
          isLoading: isLoading,
        ),
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
            GroupListItem(
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
