import 'package:flutter/material.dart';

import '../../../../../core/data/dto/school_profile_dto.dart';
import '../../../../../core/ui/widgets/group_avatar.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/school_profile_cubit.dart';

class SchoolProfileHeader extends StatelessWidget {
  const SchoolProfileHeader({super.key, required this.state});

  final SchoolProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            const SizedBox(height: Constants.space21),
            SchoolProfileAvatar(school: state.school),
            const SizedBox(height: Constants.space21),
            Align(
              alignment: Alignment.center,
              child: Text(
                state.school?.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SchoolProfileAvatar extends StatelessWidget {
  const SchoolProfileAvatar({super.key, required this.school});

  final SchoolProfileDto? school;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 140,
      child: GroupAvatar(
        avatarUrl: school?.avatarUrl,
        type: GroupAvatarType.school,
      ),
    );
  }
}
