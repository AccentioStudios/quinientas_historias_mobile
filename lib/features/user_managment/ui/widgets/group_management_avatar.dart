import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/ui/widgets/group_avatar.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/functions.dart';
import '../cubit/group_management_cubit.dart';

class RegisterGroupAvatar extends StatelessWidget {
  const RegisterGroupAvatar({
    Key? key,
    required this.state,
    required this.type,
  }) : super(key: key);

  final GroupManagementState state;
  final GroupAvatarType type;
  @override
  Widget build(BuildContext context) {
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
            child: GroupAvatar(
              avatarUrl: state.groupManagementRequest?.avatarUrl,
              type: type,
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
                    context.read<GroupManagementCubit>().handleSaveAvatarMemory(
                        await pickPhoto(
                            webUiSettings:
                                Constants.getWebUiSettings(context)));
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
