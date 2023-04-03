import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/functions.dart';
import '../cubit/user_management_cubit.dart';

class RegisterUserAvatar extends StatelessWidget {
  const RegisterUserAvatar({
    Key? key,
    required this.state,
  }) : super(key: key);

  final UserManagementState state;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserManagementCubit>();
    return Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        if (state.avatarMemory != null)
          SizedBox(
            height: 138,
            width: 138,
            child: FutureBuilder(
              future: state.avatarMemory!.readAsBytes(),
              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if (snapshot.hasData) {
                  return CircleAvatar(
                      backgroundImage: MemoryImage(snapshot.data));
                }
                return CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          )
        else
          SizedBox(
            height: 138,
            width: 138,
            child: state.user?.avatarUrl != null
                ? CircleAvatar(
                    backgroundImage: state.user?.avatarUrl != null
                        ? NetworkImage(state.user?.avatarUrl ?? '')
                        : null,
                  )
                : OverflowBox(
                    maxHeight: 180,
                    maxWidth: 180,
                    child: Transform.translate(
                      offset: const Offset(-15, -12),
                      child: SvgPicture.asset(
                          'assets/images/user-register-avatar-empty-space-image.svg'),
                    ),
                  ),
          ),
        Positioned(
          bottom: -10,
          right: -18,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color(0xff385775),
                  borderRadius: Constants.borderRadius50),
              child: SizedBox(
                height: 37,
                child: TextButton.icon(
                  label: Text(
                    'Subir Foto',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  onPressed: () async {
                    cubit.handleSaveAvatarMemory(await pickPhoto(
                        webUiSettings: Constants.getWebUiSettings(context)));
                  },
                  icon: Center(
                    child: SvgPicture.asset(
                        'assets/icons/camera-outline-icon.svg'),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
