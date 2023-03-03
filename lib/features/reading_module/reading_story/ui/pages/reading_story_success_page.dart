import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/data/entities/daily_challenge_entity.dart';
import '../../../../../core/data/entities/story_entity.dart';
import '../../../../../core/data/entities/user_entity.dart';
import '../../../../../core/data/models/jwt_token_model.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../core/ui/widgets/big_button.dart';
import '../../../../../core/ui/widgets/padding_column.dart';
import '../../../../../core/ui/widgets/percentage_progress_bar.dart';
import '../../../../../core/ui/widgets/story_cover.dart';
import '../../../../../core/ui/widgets/user_avatar.dart';
import '../../../../../core/utils/constants.dart';
import '../../reading_story_provider.dart';

class ReadingStorySuccessPage extends StatefulWidget {
  const ReadingStorySuccessPage({
    Key? key,
    required this.points,
    this.recomended,
    this.dailyChallenge,
    required this.user,
  }) : super(key: key);

  final int? points;
  final List<Story>? recomended;
  final DailyChallenge? dailyChallenge;
  final User? user;

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: (widget.dailyChallenge != null)
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
                          user: widget.user!,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                            color: Color.fromRGBO(
                                                105, 251, 203, 1),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ),
                          ),
                        if (widget.dailyChallenge != null)
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
                        if (widget.dailyChallenge != null)
                          ...widget.dailyChallenge!.challenge
                              .map((storyProgress) => StoryCover(
                                    story: storyProgress.story,
                                    onTap: () => _navigateToStoryPage(
                                        context, storyProgress.story),
                                  ))
                      ],
                    ),
                  ),
                if (widget.dailyChallenge != null)
                  SizedBox(
                    width: 145,
                    child: PaddingColumn(
                        padding: const EdgeInsets.only(top: Constants.space12),
                        children: <Widget>[
                          PercentageProgressBar(
                            completedPercentage: calculatePercentage(
                                widget.dailyChallenge?.count,
                                widget.dailyChallenge?.readed),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${widget.dailyChallenge?.readed} de ${widget.dailyChallenge?.count} leidos',
                            style: TextStyle(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ]),
                  ),
                Expanded(child: Container()),
                PaddingColumn(
                  padding: const EdgeInsets.all(Constants.space21),
                  children: [
                    // BigButton(
                    //     text: 'Volver',
                    //     onPressed: () {
                    //       Navigator.of(context, rootNavigator: true).pop(true);
                    //       Navigator.of(context, rootNavigator: true).pop(true);
                    //     }),
                    // const SizedBox(height: Constants.space12),
                    BigButton(
                        // filled: false,
                        text: 'Ir al home',
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pushNamedAndRemoveUntil(Routes.homeNavigator,
                                  (Route<dynamic> route) => false);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int calculatePercentage(int? total, int? current) {
    if (total != null && current != null) {
      if (total > 0) {
        return (current * 100 ~/ total).toInt();
      }
      return 0;
    }
    return 0;
  }

  void _navigateToStoryPage(
    BuildContext context,
    Story story,
  ) {
    Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
        builder: (_) => ReadingStoryProvider(
              storyId: story.id,
            )));
  }
}
