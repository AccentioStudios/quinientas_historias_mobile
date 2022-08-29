import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/utils/colors.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../core/data/entities/invites_entity.dart';
import '../../../../core/data/entities/user_entity.dart';
import '../../../../core/ui/widgets/big_button.dart';

class InvitesPage extends StatelessWidget {
  const InvitesPage({Key? key, required this.typeUserToInvite})
      : super(key: key);

  final UserType typeUserToInvite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Invitar a un amigo',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.space21, vertical: Constants.space4),
          child: BigButton(
            svgIconPath: 'assets/icons/user-plus-outline-icon.svg',
            elevation: 5,
            onPressed: () {},
            text: 'Invitar a un amigo',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space30),
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
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                const SizedBox(height: Constants.space21),
                const Text(
                  'Invita a más lectores a formar parte del equipo y ganen juntos en esta temporada',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: Constants.space41),
                _InvitesList(
                  invites: [
                    Invite(
                        id: 1,
                        invitedEmail: 'adsasdd@adads.com',
                        invitedType: UserType.reader,
                        accepted: true),
                    Invite(
                        id: 2,
                        invitedEmail: 'adsadasdasdsdd@adads.com',
                        invitedType: UserType.reader,
                        accepted: false),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class _InvitesList extends StatelessWidget {
  const _InvitesList({Key? key, required this.invites}) : super(key: key);
  final List<Invite> invites;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...invites.map(
          (item) => Dismissible(
            key: Key(item.id.toString()),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(item.invitedEmail),
              trailing: _InvitationStateChip(
                accepted: item.accepted,
              ),
            ),
          ),
        )
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
    Color _colorState = accepted
        ? Theme.of(context).brightness == Brightness.light
            ? successColor
            : successDarkColor
        : Theme.of(context).primaryColor;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: _colorState),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Text(
          accepted ? 'Aceptado' : 'Invitado',
          style: TextStyle(
            color: _colorState,
          ),
        ));
  }
}
