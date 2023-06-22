import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../core/data/dto/auth_dto.dart';
import '../../core/integrations/secure_storage_service.dart';
import 'data/repositories/challenges_repository.dart';
import 'data/useCases/challenges_usecases.dart';
import 'ui/cubit/challenges_cubit.dart';
import 'ui/pages/webview_page.dart';

@RoutePage()
class ChallengesProvider extends StatelessWidget {
  const ChallengesProvider({
    super.key,
    @QueryParam('id') this.id,
    @QueryParam('url') this.url,
    @QueryParam('storyId') this.storyId,
    @QueryParam('name') this.name,
    @QueryParam('testMode') this.testMode,
    @QueryParam('description') this.description,
    this.useHttps,
  });
  final String? url;
  final String? storyId;
  final String? name;
  final String? description;
  final String? id;
  final String? testMode;
  final bool? useHttps;
  @override
  Widget build(BuildContext context) {
    // verify if id, url, name, description, and userId are not null, if they are, return a Scaffold with a message
    if (id == null || url == null || name == null || description == null) {
      return const Scaffold(
        body: Center(
          child: Text(
            'No se pudo cargar el minijuego, faltan datos para identificar el usuario o el minijuego',
          ),
        ),
      );
    }
    return BlocProvider(
      create: (BuildContext context) => ChallengesCubit(
          challengesUseCases:
              ChallengesUseCases(repository: ChallengesRepository())),
      child: FutureBuilder<JwtPayload?>(
        future: GetIt.I<SecureStorageService>().getSessionData(),
        builder: (BuildContext context, AsyncSnapshot<JwtPayload?> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              return ChallengesMinigameWebView(
                userId: snapshot.data!.id.toString(),
                storyId: storyId,
                id: int.tryParse(id!)!,
                url: url!,
                name: name!,
                description: description!,
                testMode: testMode,
                useHttps: useHttps,
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: Text(
                    'No se pudo cargar el minijuego, usuario no esta identificado',
                  ),
                ),
              );
            }
          }
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      ),
    );
  }
}
