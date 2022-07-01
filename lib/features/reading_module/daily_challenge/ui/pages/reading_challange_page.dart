import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quinientas_historias/core/mixins/error_handling.dart';
import 'package:quinientas_historias/features/reading_module/daily_challenge/bloc/cubit/daily_challenge_cubit.dart';

import '../widgets/reading_carousel_story.dart';

class DailyChallengePage extends StatefulWidget with ErrorHandling {
  const DailyChallengePage({Key? key}) : super(key: key);

  @override
  State<DailyChallengePage> createState() => _DailyChallengePageState();
}

class _DailyChallengePageState extends State<DailyChallengePage> {
  @override
  void didChangeDependencies() {
    BlocProvider.of<DailyChallengeCubit>(context)
        .getData(onError: (error) => widget.handleError(context, error));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DailyChallengeCubit, DailyChallengeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            toolbarHeight: 64,
            title: const Text('Mis Lecturas Diarias'),
          ),
          body: state.loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  child: Column(
                  children: const <Widget>[
                    ReadingCarouselStory(
                      stories: [],
                    ),
                  ],
                )),
        );
      },
    );
  }
}
