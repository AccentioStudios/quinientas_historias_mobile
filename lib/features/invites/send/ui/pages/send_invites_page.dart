import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/data/entities/team_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/dismissible_list_tile.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/headline.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/send_invites_cubit.dart';
import 'invites_send_invitation_page.dart';

class SendInvitesPage extends StatefulWidget with ErrorHandling {
  const SendInvitesPage({
    Key? key,
    required this.typeUserToInvite,
    this.team,
    this.schoolId,
  }) : super(key: key);

  final Role typeUserToInvite;
  final Team? team;
  final int? schoolId;
  @override
  State<SendInvitesPage> createState() => _SendInvitesPageState();
}

class _SendInvitesPageState extends State<SendInvitesPage> {
  @override
  void didChangeDependencies() {
    getInvitations(context, widget.team);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendInvitesCubit, SendInvitesState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                getTitle(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.space21, vertical: Constants.space4),
              child: BigButton(
                svgIconPath: 'assets/icons/user-plus-outline-icon.svg',
                elevation: 5,
                onPressed: () => navigateToInvite(context),
                text: getTitle(),
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space21),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Constants.space21),
                    _HeroImage(
                      team: widget.team,
                      schoolId: widget.schoolId,
                    ),
                    const SizedBox(height: Constants.space41),
                    Text(
                      getHeader(),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: Constants.space21),
                    Text(
                      getSubtitle(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    Headline(
                      label: getHeadlineList(),
                    ),
                    _InvitesList(
                      invites: state.invites,
                      isLoading: state.isLoading,
                      invitedTypeFilter: getInvitedTypeFilter(),
                      onDismissed: deleteInvitation,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  Role getInvitedTypeFilter() {
    if (widget.team != null) {
      return Role.reader;
    }
    if (widget.schoolId != null) {
      return Role.captain;
    }
    return Role.reader;
  }

  String getTitle() {
    if (widget.team != null) return 'Invitar a un lector';
    if (widget.schoolId != null) return 'Invitar a un capitán';
    return 'Invitar';
  }

  String getHeader() {
    if (widget.team != null || widget.typeUserToInvite == Role.reader) {
      return 'Haz crecer el equipo';
    }
    if (widget.schoolId != null || widget.typeUserToInvite == Role.captain) {
      return 'Integra nuevos capitanes al torneo';
    }
    return 'Invita personas a 500Historias';
  }

  String getSubtitle() {
    if (widget.team != null || widget.typeUserToInvite == Role.reader) {
      return 'Invita a más lectores a formar parte de "${widget.team?.name}" y ganen juntos en esta temporada';
    }
    if (widget.schoolId != null || widget.typeUserToInvite == Role.captain) {
      return 'Los capitanes pueden crear sus equipos e invitar nuevos lectores también';
    }
    return '';
  }

  String getHeadlineList() {
    if (widget.team != null || widget.typeUserToInvite == Role.reader) {
      return 'Lectores invitados al equipo';
    }
    if (widget.schoolId != null || widget.typeUserToInvite == Role.captain) {
      return 'Capitanes invitados';
    }
    return 'Invitaciones mandadas';
  }

  void deleteInvitation(Invite invite) {
    context.read<SendInvitesCubit>().deleteInvitation(invite,
        onSuccess: () {
          getInvitations(context, widget.team);
        },
        onError: (error) => widget.handleError(context, error, onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }));
  }

  void getInvitations(BuildContext context, Team? team) {
    context.read<SendInvitesCubit>().getInvitations(
        teamId: team?.id,
        onSuccess: () {},
        onError: (error) => widget.handleError(context, error, onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            }));
  }

  void navigateToInvite(BuildContext context) {
    Navigator.of(context)
        .push<bool>(MaterialPageRoute(
            builder: (_) => BlocProvider.value(
                  value: context.read<SendInvitesCubit>(),
                  child: InvitesSendInvitationPage(
                    typeUserToInvite: widget.typeUserToInvite,
                    schoolId: widget.schoolId,
                    team: widget.team,
                  ),
                )))
        .then((refresh) {
      getInvitations(context, widget.team);
    });
  }
}

class _HeroImage extends StatelessWidget {
  const _HeroImage({
    Key? key,
    this.team,
    this.schoolId,
  }) : super(key: key);

  final Team? team;
  final int? schoolId;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.none,
        width: 150,
        height: 200,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                child:
                    SvgPicture.asset('assets/images/invite-friend-image.svg'),
              ),
            ),
            if (team != null)
              Positioned(
                right: 0,
                bottom: -5,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  elevation: 12,
                  child: GroupAvatar(
                    type: GroupAvatarType.team,
                    width: 70,
                    height: 70,
                    avatarUrl: team?.avatarUrl,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _InvitesList extends StatelessWidget {
  const _InvitesList({
    Key? key,
    required this.invites,
    required this.isLoading,
    required this.onDismissed,
    required this.invitedTypeFilter,
  }) : super(key: key);
  final List<Invite> invites;
  final bool isLoading;
  final Function(Invite) onDismissed;
  final Role invitedTypeFilter;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading) const Center(child: CircularProgressIndicator()),
        if (!isLoading)
          ...invites.map((item) {
            if (item.invitedRole == invitedTypeFilter) {
              return Padding(
                padding: const EdgeInsets.only(bottom: Constants.space12),
                child: DismissibleListTile(
                  onDismissed: (direction) => onDismissed(item),
                  key: Key(item.invitedEmail),
                  title: Text(
                    item.invitedEmail,
                    style: DefaultTextStyle.of(context)
                        .style
                        .copyWith(fontSize: 16),
                  ),
                  trailing: _InvitationStateChip(
                    accepted: item.accepted,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          }),
        if (!isLoading) const SizedBox(height: 60 + Constants.space41),
      ],
    );
  }
}

class _InvitationStateChip extends StatelessWidget {
  const _InvitationStateChip({Key? key, required this.accepted})
      : super(key: key);
  final bool accepted;
  @override
  Widget build(BuildContext context) {
    Color colorState = accepted
        ? Theme.of(context).brightness == Brightness.light
            ? successColor
            : successDarkColor
        : Theme.of(context).primaryColor;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: colorState),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          accepted ? 'Aceptado' : 'Invitado',
          style: TextStyle(
            color: colorState,
          ),
        ));
  }
}
