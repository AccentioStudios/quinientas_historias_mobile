import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quinientas_historias/core/mixins/bottom_sheet_messages.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../../../core/data/entities/user_entity.dart';
import '../../../send_invite_provider.dart';

@RoutePage()
class InvitesAdminPage extends StatefulWidget with SheetMessages {
  const InvitesAdminPage({super.key, @QueryParam('role') String? role});

  @override
  State<InvitesAdminPage> createState() => _InvitesAdminPageState();
}

class _InvitesAdminPageState extends State<InvitesAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invitar usuarios'),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
          physics: const AlwaysScrollableScrollPhysics()
              .applyTo(const BouncingScrollPhysics()),
          children: [
            ListTile(
              title: const Text('Invitar Capitanes'),
              subtitle: const Text(
                  'Invita a capitanes para que formen equipos en la escuela'),
              trailing: const Icon(Icons.add),
              onTap: () => _navigateToInvite(context, Role.captain),
            ),
            const SizedBox(height: Constants.space12),
            ListTile(
              title: const Text('Invitar Lectores'),
              subtitle: const Text(
                  'Invita a lectores a formar parte de un equipo en particular.'),
              trailing: const Icon(Icons.add),
              onTap: () => _navigateToInvite(context, Role.reader),
            ),
            const SizedBox(height: Constants.space12),
            ListTile(
              title: const Text('Invitar profesores'),
              subtitle: const Text(
                  'Invita a profesores a registrar sus colegios para que inviten a capitanes y lectores.'),
              trailing: const Icon(Icons.add),
              onTap: () => _navigateToInvite(context, Role.prof),
            ),
            const SizedBox(height: Constants.space12),
            ListTile(
              title: const Text('Invitar Administradores'),
              subtitle: const Text(
                  'Invita a administradores para que administren el sistema.'),
              trailing: const Icon(Icons.add),
              onTap: () => _navigateToInvite(context, Role.admin),
            ),
          ]),
    );
  }

  void _navigateToInvite(BuildContext context, Role role) async {
    switch (role) {
      case Role.admin:
        break;
      case Role.prof:
        final chooseSchool = await widget.showMessage<bool>(
          context,
          height: 350,
          title: '¿Quieres invitar a un profesor a una escuela?',
          content:
              'Tienes la opcion de invitar a un profesor a una escuela en especifico o invitar a un profesor sin escuela y que el se encargue de crear una escuela.',
          btnLabel: 'Invitar a escuela',
          secondaryBtnLabel: 'Invitar sin escuela',
        );
        int? schoolId;
        if (chooseSchool == true) {
          if (context.mounted) {
            final school = await SendInviteProvider.chooseSchoolForInviteAdmin(
                context,
                role: Role.prof);
            if (school != null) {
              schoolId = school.id;
            } else {
              return;
            }
          }
        }
        if (chooseSchool == null) return;
        if (context.mounted) {
          SendInviteProvider.open(
            context,
            schoolId: schoolId,
            typeUserToInvite: Role.prof,
          ).then((refresh) {});
        }

        break;
      case Role.captain:
        SendInviteProvider.chooseTournamentForInviteAdmin(context)
            .then((tournament) {
          if (tournament != null) {
            SendInviteProvider.chooseSchoolForInviteAdmin(context,
                    role: Role.captain)
                .then((school) {
              if (school != null) {
                SendInviteProvider.open(
                  context,
                  schoolId: school.id,
                  tournamentId: tournament.id,
                  typeUserToInvite: Role.captain,
                ).then((refresh) {});
              }
            });
          } else {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(msg: "Debes seleccionar un torneo");
            });
          }
        });
        break;
      case Role.reader:
        SendInviteProvider.chooseTournamentForInviteAdmin(context)
            .then((tournament) {
          if (tournament != null) {
            SendInviteProvider.chooseSchoolForInviteAdmin(context)
                .then((school) {
              if (school != null) {
                SendInviteProvider.chooseTeamForInviteProfAndAdmin(
                  context,
                  schoolId: school.id,
                ).then((team) {
                  if (team != null) {
                    SendInviteProvider.open(
                      context,
                      team: team,
                      typeUserToInvite: Role.reader,
                    ).then((value) {});
                  }
                });
              }
            });
          } else {
            Fluttertoast.cancel().then((value) {
              Fluttertoast.showToast(msg: "Debes seleccionar un torneo");
            });
          }
        });
        break;
      default:
        break;
    }
  }
}
