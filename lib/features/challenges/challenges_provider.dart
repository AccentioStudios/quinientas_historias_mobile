import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/challenges_repository.dart';
import 'data/useCases/challenges_usecases.dart';
import 'ui/cubit/challenges_cubit.dart';
import 'ui/pages/webview_page.dart';

class ChallengesProvider extends StatelessWidget {
  const ChallengesProvider({Key? key, this.url}) : super(key: key);

  final String? url;
  @override
  Widget build(BuildContext context) {
    // get arguments from route
    final String? args = ModalRoute.of(context)?.settings.arguments as String?;
    final challenge = jsonDecode(args?.toString() ?? '');
    return BlocProvider(
        create: (BuildContext context) => ChallengesCubit(
            challengesUseCases:
                ChallengesUseCases(repository: ChallengesRepository())),
        child: ChallengesMinigameWebView(
          url: challenge['url'],
          name: challenge['name']!,
          description: challenge['description'],
          id: challenge['id'],
        ));
  }
}
