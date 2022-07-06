import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/ui/widgets/headline.dart';

import '../../../../core/data/entities/story_entity.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/arrow_leaderboard.dart';
import '../../../../core/ui/widgets/big_chip.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/ui/widgets/story_cover.dart';
import '../../../../core/utils/constants.dart';
import '../../../reading_module/data/models/author_model.dart';
import '../../bloc/cubit/home_cubit.dart';
import '../components/header_card_component.dart';

class HomePage extends StatefulWidget with ErrorHandling {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<HomeCubit>(context)
        .getDashboard(onError: (error) => widget.handleError(context, error));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: state.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  padding: const EdgeInsets.only(top: 0),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    HeaderCard(state: state),
                    const SizedBox(height: Constants.space21),
                    PaddingColumn(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.space18),
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            HomePositionsChip(
                              onTap: () {},
                              label: 'Mi equipo',
                              position: '8',
                              content: state.user?.team.name ?? '',
                              arrowLeaderBoard: const ArrowLeaderBoard(
                                number: 2,
                              ),
                            ),
                            const SizedBox(width: Constants.space18),
                            HomePositionsChip(
                              onTap: () {},
                              label: 'Mi escuela',
                              position: '4',
                              content: state.user?.school.name ?? '',
                              arrowLeaderBoard:
                                  const ArrowLeaderBoard(number: 1),
                            ),
                          ],
                        ),
                        Headline(
                          label: 'Explorar Lecturas',
                          linkText: 'Ver más',
                          onTap: () {},
                        ),
                        GridView.count(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: Constants.space12,
                          mainAxisSpacing: Constants.space12,
                          childAspectRatio: 109 / 147,
                          crossAxisCount: 3,
                          children: [
                            ...stories.map((story) => StoryCover(story: story)),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
        );
      },
    );
  }
}

List<Story> stories = [
  Story(
    id: '1',
    title: 'The Awesome Book',
    coverColor: 'FFCD81',
    author: Author(
      id: '1',
      email: 'test@test.com',
      firstName: 'Lorem',
      lastName: 'Ipsum',
    ),
  ),
  Story(
    id: '2',
    title: 'The Amazing Book',
    coverColor: '88C9F9',
    author: Author(
      id: '1',
      email: 'test@test.com',
      firstName: 'Lorem',
      lastName: 'Ipsum',
    ),
  ),
  Story(
    id: '3',
    title: 'The Spectacular Book',
    coverColor: 'ADE9B3',
    author: Author(
      id: '1',
      email: 'test@test.com',
      firstName: 'Lorem',
      lastName: 'Ipsum',
    ),
  ),
  Story(
    id: '4',
    title: 'The Spectacular Book',
    coverColor: 'C494F3',
    author: Author(
      id: '1',
      email: 'test@test.com',
      firstName: 'Lorem',
      lastName: 'Ipsum',
    ),
  ),
];

class HomePositionsChip extends StatelessWidget {
  const HomePositionsChip(
      {Key? key,
      required this.label,
      required this.content,
      required this.position,
      required this.arrowLeaderBoard,
      this.onTap})
      : super(key: key);

  final String label;
  final String content;
  final String position;
  final ArrowLeaderBoard arrowLeaderBoard;
  final GestureTapCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BigChip(
        onTap: onTap,
        padding: const EdgeInsets.symmetric(
            horizontal: Constants.space16, vertical: Constants.space16),
        primary: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            arrowLeaderBoard
          ],
        ),
        secondary: Padding(
          padding: const EdgeInsets.only(top: Constants.space8),
          child: SizedBox(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                AutoSizeText(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                  minFontSize: 14,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                AutoSizeText(
                  '#$position',
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}