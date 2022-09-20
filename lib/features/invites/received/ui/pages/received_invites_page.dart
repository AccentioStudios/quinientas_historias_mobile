import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';

import '../../../../../core/ui/pages/common_page_layout.dart';
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
    context.read<ReceivedInvitesCubit>().validateCode(widget.email, widget.code,
        onSuccess: () {},
        onError: (error) => widget.handleError(context, error));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReceivedInvitesCubit, ReceivedInvitesState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CommonPageLayout(
                headline:
                    '${state.whoIsInviting?.firstName} te ha invitado a formar parte del torneo',
                message:
                    'Has recibido una invitacion para formar parte del equipo:\n\n${state.team?.name}',
                svgImagePath: 'assets/images/trophy-image.svg',
                btnLabel: 'Aceptar invitación',
                onBtnTap: () {},
              );
      },
    );
  }
}
