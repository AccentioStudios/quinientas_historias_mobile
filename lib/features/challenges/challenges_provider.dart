import 'dart:convert';

import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/repositories/challenges_repository.dart';
import 'data/useCases/challenges_usecases.dart';
import 'ui/cubit/challenges_cubit.dart';
import 'ui/pages/webview_page.dart';

// class ChallengesProvider extends StatelessWidget {
//   const ChallengesProvider({Key? key, @QueryParam('url') this.url})
//       : super(key: key);

//   final String? url;
//   @override
//   Widget build(BuildContext context) {
//     // get arguments from route
//     // final String? args = ModalRoute.of(context)?.settings.arguments as String?;
//     // final challenge = jsonDecode(args?.toString() ?? '');
//     return BlocProvider(
//         create: (BuildContext context) => ChallengesCubit(
//             challengesUseCases:
//                 ChallengesUseCases(repository: ChallengesRepository())),
//         child: ChallengesMinigameWebView(
//           url: 'http://localhost:3001',
//           name: 'Test Game',
//           description: 'Test Desc',
//           id: 1,
//         ));
//   }
// }

@RoutePage()
class ChallengesProvider extends StatelessWidget {
  const ChallengesProvider({
    Key? key,
    @QueryParam('url') this.url,
    @QueryParam('name') this.name,
    @QueryParam('description') this.description,
    @QueryParam('id') this.id,
  }) : super(key: key);
  final String? url;
  final String? name;
  final String? description;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ChallengesCubit(
          challengesUseCases:
              ChallengesUseCases(repository: ChallengesRepository())),
      child: ChallengesMinigameWebView(
        url: url ?? '',
        name: name ?? 'Test Game',
        description: description ?? 'Test Desc',
        id: int.tryParse(id ?? '1') ?? 1,
      ),
    );
  }
}
