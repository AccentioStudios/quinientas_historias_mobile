import 'package:auto_size_text/auto_size_text.dart';
import 'package:custom_nested_scroll_view/custom_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/failures/failures.dart';
import '../../../../core/ui/widgets/outlined_card.dart';

import '../../../../core/data/entities/tournament_entity.dart';
import '../../../../core/mixins/error_handling.dart';
import '../../../../core/ui/widgets/padding_column.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/utils/constants.dart';
import '../../tournament_provider.dart';
import '../bloc/cubit/tournament_cubit.dart';
import '../widgets/tournament_header_widget.dart';

class TournamentPage extends StatefulWidget with ErrorHandling {
  const TournamentPage({Key? key}) : super(key: key);

  @override
  State<TournamentPage> createState() => _TournamentPageState();
}

class _TournamentPageState extends State<TournamentPage>
    with TickerProviderStateMixin {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getTournaments();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        // final me = state.listPage?.itemList.where((item) => item.user?.id == 1);
        return RefreshIndicator(
          onRefresh: () => getTournaments(),
          child: Scaffold(
              body: state.tournamentIsLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : CustomNestedScrollView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      headerSliverBuilder: (context, innerBoxIsScrolled) => [
                            CustomSliverOverlapAbsorber(
                              handle: CustomNestedScrollView
                                  .sliverOverlapAbsorberHandleFor(context),
                              sliver: const TournamentHeaderWidget(),
                            ),
                            SliverToBoxAdapter(
                              child: PaddingColumn(
                                padding: const EdgeInsets.only(
                                    left: Constants.space16,
                                    right: Constants.space16,
                                    top: Constants.space21),
                                children: [
                                  ...state.tournaments
                                      .where((t) =>
                                          t.active == true &&
                                          t.endsAt.isAfter(DateTime.now()))
                                      .map(
                                        (e) => TournamentListCard(
                                          tournament: e,
                                        ),
                                      ),
                                ],
                              ),
                            ),
                          ],
                      body: ListView())),
        );
      },
    );
  }

  getTournaments() {
    return context
        .read<TournamentCubit>()
        .getAllTournaments()
        .onError<HttpFailure>(
            (error, stackTrace) => widget.handleError(context, error));
  }
}

class TournamentListCard extends StatelessWidget {
  const TournamentListCard({super.key, required this.tournament});

  final Tournament tournament;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Constants.space21),
      child: OutlinedCard(
          onTap: () => _openTournament(context, tournament),
          padding: EdgeInsets.zero,
          backgroundColor: brandBlue.withOpacity(0.08),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          child: Column(
            children: [
              PaddingColumn(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.space16, vertical: Constants.space12),
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: AutoSizeText.rich(
                                style: DefaultTextStyle.of(context)
                                    .style
                                    .copyWith(fontSize: 14),
                                TextSpan(text: tournament.name),
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (tournament.participating == true)
                              Text(
                                'Participando',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.tertiary),
                              )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: Constants.space12),
                  Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: AutoSizeText.rich(
                            TextSpan(
                              style: DefaultTextStyle.of(context)
                                  .style
                                  .copyWith(fontSize: 13),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${tournament.storyCount ?? 0} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                const TextSpan(text: 'historias    '),
                                TextSpan(
                                  text: '${tournament.usersCount} ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                                const TextSpan(text: 'participantes'),
                              ],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ])
                ],
              ),
              AspectRatio(
                aspectRatio: 350 / 160,
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.blueAccent,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/cover-tournament-placeholder-image.png'))),
                ),
              )
            ],
          )),
    );
  }

  _openTournament(BuildContext context, Tournament tournament) {
    TournamentProvider.openTournament(context, tournament: tournament);
  }
}
