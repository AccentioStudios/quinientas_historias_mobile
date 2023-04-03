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
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/layouts/layout_with_footer.dart';
import '../../../../../core/ui/pages/common_page_layout.dart';
import '../../../../user_managment/user_management_provider.dart';
import '../../../send/ui/widgets/team_list_item.dart';
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
                : CommonPageLayout(
                    headline: 'Esta invitación ya no es válida',
                    message:
                        'Has recibido una invitación para formar parte de 500Historias. Sin embargo, parece que ya no es válida o ya fué usada.',
                    svgImagePath: 'assets/images/broken-invitation-image.svg',
                    btnLabel: 'Entiendo',
                    onBtnTap: () {
                      Navigator.of(context, rootNavigator: true)
                          .popUntil((route) => route.isFirst);
                    },
                  );
      },
    );
  }

  navigateToAcceptInvite(BuildContext context, {required Invite invite}) async {
    final session = await SecureStorageHelper.getSessionData();
    if (session != null) {
      // ignore: use_build_context_synchronously
      UserManagementProvider()
          .openAcceptInvite(context, invite: invite, session: session);
    }
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
