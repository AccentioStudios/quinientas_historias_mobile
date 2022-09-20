import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/features/invites/send/ui/bloc/cubit/send_invites_cubit.dart';

import '../../../../../core/data/entities/invites_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/mixins/error_handling.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';
import 'invites_send_invitation_page.dart';

class SendInvitesPage extends StatefulWidget with ErrorHandling {
  const SendInvitesPage({Key? key, required this.typeUserToInvite})
      : super(key: key);

  final UserType typeUserToInvite;

  @override
  State<SendInvitesPage> createState() => _SendInvitesPageState();
}

class _SendInvitesPageState extends State<SendInvitesPage> {
  @override
  void didChangeDependencies() {
    getInvitations(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SendInvitesCubit, SendInvitesState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(
                'Invitar a un amigo',
                style: TextStyle(fontWeight: FontWeight.bold),
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
                text: 'Invitar a un amigo',
              ),
            ),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: Constants.space30),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: Constants.space21),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        child: SvgPicture.asset(
                            'assets/images/invite-friend-image.svg'),
                      ),
                    ),
                    const SizedBox(height: Constants.space41),
                    const Text(
                      'Haz crecer tu equipo',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                    const SizedBox(height: Constants.space21),
                    const Text(
                      'Invita a más lectores a formar parte del equipo y ganen juntos en esta temporada',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: Constants.space41),
                    _InvitesList(
                      invites: state.invites,
                      isLoading: state.isLoading,
                    )
                  ],
                ),
              ),
            ));
      },
    );
  }

  void getInvitations(BuildContext context) {
    context.read<SendInvitesCubit>().getInvitations(
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
                  ),
                )))
        .then((refresh) {
      getInvitations(context);
    });
  }
}

class _InvitesList extends StatelessWidget {
  const _InvitesList({Key? key, required this.invites, required this.isLoading})
      : super(key: key);
  final List<Invite> invites;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isLoading) const Center(child: CircularProgressIndicator()),
        if (!isLoading)
          ...invites.map(
            (item) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.invitedEmail),
              trailing: _InvitationStateChip(
                accepted: item.accepted == 1,
              ),
            ),
          ),
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
