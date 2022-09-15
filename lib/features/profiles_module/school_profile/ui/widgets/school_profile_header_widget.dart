import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/data/entities/school_entity.dart';

import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/utils/constants.dart';
import '../bloc/cubit/school_profile_cubit.dart';

class SchoolProfileHeader extends StatelessWidget {
  const SchoolProfileHeader({Key? key, required this.state}) : super(key: key);

  final SchoolProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            const SizedBox(height: Constants.space21),
            SchoolProfileAvatar(
              team: state.data,
              canEdit: state.canEdit,
              editOnPressed: () {},
            ),
            const SizedBox(height: Constants.space21),
            const Align(
              alignment: Alignment.center,
              child: Text(
                // state.data?.name ?? '',
                "Colegio Prueba",
                textAlign: TextAlign.center,
                style: TextStyle(
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
  const SchoolProfileAvatar(
      {Key? key,
      required this.team,
      this.canEdit = false,
      required this.editOnPressed})
      : super(key: key);

  final School? team;
  final bool canEdit;
  final void Function()? editOnPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircleAvatar(
            radius: 68,
            backgroundImage: NetworkImage(team?.avatarUrl ?? ''),
          ),
        ),
        if (canEdit == true)
          Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff385775)),
              child: IconButton(
                  onPressed: editOnPressed,
                  icon: Center(
                    child: SvgPicture.asset(
                        'assets/icons/camera-outline-icon.svg'),
                  ))),
      ],
    );
  }
}
