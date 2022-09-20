import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quinientas_historias/core/ui/widgets/percentage_progress_bar.dart';
import 'package:quinientas_historias/core/ui/widgets/story_cover.dart';
import 'package:quinientas_historias/core/ui/widgets/user_avatar.dart';
import 'package:quinientas_historias/core/utils/constants.dart';

import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../core/helpers/secure_storage_helper.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/utils/colors.dart';

class ReadingStorySuccessPage extends StatefulWidget {
  const ReadingStorySuccessPage({
    Key? key,
    required this.points,
    required this.recomendedStories,
    required this.sessionData,
  }) : super(key: key);

  final int? points;
  final List<Story>? recomendedStories;
  final JWTTokenModel? sessionData;

  @override
  State<ReadingStorySuccessPage> createState() =>
      _ReadingStorySuccessPageState();
}

class _ReadingStorySuccessPageState extends State<ReadingStorySuccessPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var state = context.read<ReadingStoryCubit>().state;
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Stack(
                alignment: (widget.points != null)
                    ? Alignment.topCenter
                    : Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: (widget.points != null) ? 375 : 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: RadialGradient(
                        center: (widget.points != null)
                            ? const Alignment(0, -0.3)
                            : const Alignment(0, 0),
                        colors: const [
                          Color.fromRGBO(8, 69, 136, 1),
                          Color.fromRGBO(16, 28, 41, 1)
                        ],
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: Constants.space41,
                      ),
                      UserAvatar(
                        user: widget.sessionData!.user,
                        height: 110,
                        width: 110,
                      ),
                      const SizedBox(
                        height: Constants.space21,
                      ),
                      const Text(
                        "Completaste una lectura",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: Constants.space12,
                      ),
                      const Text(
                        "¡Sigue así!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: Constants.space16,
                      ),
                      if (widget.points != null)
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: Constants.borderRadius18,
                                border: Border.all(
                                    color: const Color.fromRGBO(
                                        105, 251, 203, 1))),
                            child: InkWell(
                              borderRadius: Constants.borderRadius18,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: Constants.space12,
                                  vertical: Constants.space8,
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/points-icon.svg',
                                        height: Constants.space16,
                                        color: const Color.fromRGBO(
                                            105, 251, 203, 1),
                                      ),
                                      Text(' + ${widget.points} ',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color.fromRGBO(
                                                  105, 251, 203, 1))),
                                      const Text(
                                        'Puntos',
                                        style: TextStyle(
                                          color:
                                              Color.fromRGBO(105, 251, 203, 1),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        ),
                      if (widget.points != null)
                        const Padding(
                          padding: EdgeInsets.only(top: Constants.space41),
                          child: Text(
                            'Escoge tu siguiente lectura: ',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
              if (widget.points != null)
                Padding(
                  padding: const EdgeInsets.only(
                      left: Constants.space41,
                      right: Constants.space41,
                      bottom: Constants.space12),
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    crossAxisSpacing: Constants.space16,
                    childAspectRatio: 109 / 147,
                    crossAxisCount: 2,
                    children: <Widget>[
                      if (widget.recomendedStories != null)
                        ...widget.recomendedStories!.map((story) =>
                            StoryCover(story: story, onTap: () => {}))
                    ],
                  ),
                ),
              if (widget.points != null)
                const Padding(
                  padding: EdgeInsets.only(
                      left: 100,
                      right: 100,
                      top: Constants.space12,
                      bottom: Constants.space8),
                  child: PercentageProgressBar(
                    backgroundColor: division1Color,
                  ),
                ),
              if (widget.points != null)
                const Text("Faltan para completar tu reto diario"),
              Expanded(child: Container()),
              Padding(
                padding: const EdgeInsets.all(Constants.space21),
                child: BigButton(
                    text: 'Volver al home',
                    svgIconPath: 'assets/icons/home-outline-icon.svg',
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pushNamed(Routes.homeNavigator);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 /*Text(
                'Success Page: Points $points',
              ),
              SizedBox(
                height: Constants.space12,
              ),
              if (recomendedStories != null)
                ...recomendedStories!
                    .map((story) => Text(story.title))
                    .toList(),
              BigButton(
                  text: 'Volver al home',
                  svgIconPath: 'assets/icons/home-outline-icon.svg',
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed(Routes.homeNavigator);
                  })*/