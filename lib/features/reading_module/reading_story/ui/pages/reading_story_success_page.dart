import 'package:flutter/material.dart';
import 'package:flutter_html/custom_render.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/outlined_card.dart';
import 'package:quinientas_historias/core/ui/widgets/padding_column.dart';
import 'package:quinientas_historias/core/ui/widgets/single_chip.dart';
import 'package:quinientas_historias/core/utils/colors.dart';
import 'package:quinientas_historias/core/utils/constants.dart';
import 'package:quinientas_historias/features/profiles_module/user_profile/ui/widgets/user_profile_avatar.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../widgets/reading_story_appbar.dart';

class ReadingStorySuccessPage extends StatelessWidget {
  const ReadingStorySuccessPage({
    Key? key,
    required this.points,
    required this.recomendedStories,
  }) : super(key: key);

  final int? points;
  final List<Story>? recomendedStories;
  @override
  Widget build(BuildContext context) {
    // var state = context.read<ReadingStoryCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: Constants.space41,
              ),
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.lightBlue,
              ),
              SizedBox(
                height: Constants.space21,
              ),
              Text(
                "Completaste una lectura",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: Constants.space12,
              ),
              Text(
                "¡Sigue así!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: Constants.space16,
              ),
              FittedBox(
                fit: BoxFit.fitWidth,
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: backgroundDarkColor,
                      borderRadius: Constants.borderRadius18,
                      border:
                          Border.all(color: Color.fromRGBO(105, 251, 203, 1))),
                  child: InkWell(
                    borderRadius: Constants.borderRadius18,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Constants.space12,
                        vertical: Constants.space8,
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/points-icon.svg',
                              height: Constants.space16,
                              color: Color.fromRGBO(105, 251, 203, 1),
                            ),
                            Text(' + $points ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(105, 251, 203, 1))),
                            Text(
                              'Puntos',
                              style: TextStyle(
                                color: Color.fromRGBO(105, 251, 203, 1),
                              ),
                            )
                          ]),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: Constants.space41,
              ),
              Text(
                'Escoge tu siguiente lectura: ',
                style: TextStyle(fontWeight: FontWeight.w600),
              )
              /*Text(
                'Success Page: Points $points',
              ),
              if (recomendedStories != null)
                ...recomendedStories!.map((story) => Text(story.title)).toList(),
              BigButton(
                  text: 'Volver al home',
                  svgIconPath: 'assets/icons/home-outline-icon.svg',
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Routes.homeNavigator);
                  })*/
            ],
          ),
        ),
      ),
    );
  }
}
