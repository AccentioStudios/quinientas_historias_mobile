import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/ui/widgets/single_chip_without_icon.dart';
import 'package:quinientas_historias/features/profiles_module/team_profile/ui/bloc/cubit/team_profile_cubit.dart';

import '../../../../../core/ui/widgets/single_chip.dart';
import '../../../../../core/utils/colors.dart';
import '../../../../../core/utils/constants.dart';

class TeamProfileHeaderWidget extends StatelessWidget {
  const TeamProfileHeaderWidget({Key? key, required this.state})
      : super(key: key);

  final TeamProfileState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          elevation: 0,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                //CODIGO
              },
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/user-plus.svg'),
                  const Padding(
                    padding:
                        EdgeInsets.only(right: Constants.space18, left: 10.0),
                    child: Text("Invitar lectores",
                        style: TextStyle(
                            fontSize: 14, color: onSurfaceMutedTextDarkColor)),
                  ),
                ],
              ),
            ),
          ],
        ),
        PaddingColumn(
          padding: const EdgeInsets.symmetric(horizontal: Constants.space18),
          children: [
            const SizedBox(height: 44.0),
            SizedBox(
              height: 140,
              width: 140,
              child: Stack(
                clipBehavior: Clip.none,
                fit: StackFit.expand,
                children: [
                  CircleAvatar(
                    backgroundColor: onSurfaceMutedTextDarkColor,
                    child: CircleAvatar(
                      radius: 68,
                      backgroundImage:
                          NetworkImage(state.data?.avatarUrl ?? ''),
                      // AssetImage("assets/images/logo-equipo.png"),
                    ),
                  ),
                  Positioned(
                      bottom: -28,
                      right: -28,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 0,
                        shape: const CircleBorder(),
                        child: Container(
                          height: 64,
                          width: 64,
                          color: Colors.transparent,
                          child: SvgPicture.asset('assets/icons/plus.svg'),
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: Constants.space21),
            Align(
              alignment: Alignment.center,
              child: Text(
                state.data?.name ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: Constants.space41,
            ),
            _PointsRow(
                //state para los valores
                points: state.data?.score ?? 12000,
                readings: 550,
                schoolname: "Escuela Paralelepipedo")
          ],
        ),
      ],
    );
  }
}

class _PointsRow extends StatelessWidget {
  const _PointsRow({
    Key? key,
    required this.points,
    required this.readings,
    required this.schoolname,
  }) : super(key: key);

  final int points;
  final int readings;
  final String schoolname;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Expanded(
              child: SingleChip(
                primaryLabel: points.toString(),
                secondaryLabel: 'Puntos Equipo',
                svgIconPath: 'assets/icons/points-outline-icon.svg',
              ),
            ),
            const SizedBox(width: Constants.space18),
            Expanded(
              child: SingleChip(
                primaryLabel: readings.toString(),
                secondaryLabel: 'Lecturas',
                svgIconPath: 'assets/icons/book-open-outline-icon.svg',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: Constants.space16,
        ),
        SingleChipWithoutIcon(
          primaryLabel: 'Escuela',
          secondaryLabel: schoolname.toString(),
        ),
      ],
    );
  }
}
