import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/data/dto/auth_dto.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/core/routes/auto_router.dart';

import 'package:quinientas_historias/features/user_managment/ui/cubit/user_management_cubit.dart';

import '../../../../core/data/entities/invites_entity.dart';
import '../../../../core/data/entities/user_entity.dart';

import '../../../../core/ui/layouts/layout_with_footer.dart';
import '../../../../core/ui/widgets/big_button.dart';
import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/functions.dart';
import '../../../invites/send/ui/pages/invites_send_invitation_page.dart';
import '../../../invites/send/ui/widgets/team_list_item.dart';

class ConfirmationExistingUserAcceptInvite extends StatelessWidget
    with ErrorHandling {
  const ConfirmationExistingUserAcceptInvite(
      {super.key, this.session, required this.invite});

  final JwtPayload? session;
  final Invite invite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<UserManagementCubit, UserManagementState>(
        builder: (context, state) {
          return state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : LayoutWithFooter(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constants.space21),
                  paddingFooter: const EdgeInsets.symmetric(
                      horizontal: Constants.space21,
                      vertical: Constants.space21),
                  footer: BigButton(
                      svgIconPath: 'assets/icons/arrow-forward.svg',
                      text: 'Siguiente ',
                      onPressed: () {
                        confirmation(context, invite);
                      }),
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      'Confirmar',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Al entrar al equipo pasarás a formar parte del torneo, cada puntos que hagas aparecerá en la tabla de posiciones representando al equipo.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: Constants.space30),
                    UserListTile(
                      user: getUserData(),
                      onTap: (_) {},
                      trailingWidget: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 0),
                          height: 30,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(6)),
                          child: Transform.translate(
                            offset: const Offset(0, 6),
                            child: Text(
                              getRoleText(invite.invitedRole),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.onTertiary),
                            ),
                          )),
                    ),
                    const SizedBox(height: Constants.space30),
                    Center(
                        child: SvgPicture.asset(
                            'assets/images/line-dotted-vertical.svg')),
                    const SizedBox(height: Constants.space30),
                    TeamListItem(
                      avatarWidget: GroupAvatar(
                        type: GroupAvatarType.team,
                        avatarUrl: invite.team!.avatarUrl,
                      ),
                      label: Text(invite.team!.name),
                      secondRow: invite.team?.tournament?.name != null
                          ? [
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: Constants.space8,
                                    right: Constants.space8),
                                child: SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: SvgPicture.asset(
                                    'assets/icons/trophy-outline-icon.svg',
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: Constants.space8),
                                child: Text(
                                  invite.team!.tournament!.name!,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurfaceVariant),
                                ),
                              ),
                            ]
                          : [],
                    ),
                  ],
                );
        },
      ),
    );
  }

  User? getUserData() {
    // If invite is for a existing user, we return that user
    // if not, we return the user that is logged in
    if (invite.invited != null) {
      return invite.invited;
    } else {
      return session?.toUserEntity();
    }
  }

  confirmation(BuildContext context, Invite invite) {
    context.read<UserManagementCubit>().acceptInvite(invite,
        onSuccess: () {
          navigateToHome(context);
        },
        onError: (error) => handleError(context, error));
  }

  navigateToHome(BuildContext context) {
    AutoRouter.of(context).popUntil((route) => route.isFirst);
    AutoRouter.of(context).push(const ShellRoute());
  }
}
