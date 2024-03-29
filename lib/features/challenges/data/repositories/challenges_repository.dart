import '../../../../core/data/entities/challenge_sar_entity.dart';
import '../../../../core/data/models/list_page.dart';
import '../../../../core/integrations/api_service.dart';
import '../dto/register_new_challenge_response.dto.dart';
import '../dto/sar_health_response.dto.dart';
import '../entities/challenge_sar_event.dart';

class ChallengesRepository with ApiService {
  Stream<SarHealthResponseDto> checkHealth() async* {
    yield* sarApi.get('/health').handleJson(mapper: (json) {
      return SarHealthResponseDto.fromMap(json);
    });
  }

  Stream<RegisterNewChallengeResponseDto> registerNewChallenge(
      ChallengeSar challenge) async* {
    await sarApi.refreshToken();
    yield* sarApi.post('/v1/challenge', data: challenge.toJson()).handleJson(
        mapper: (json) {
      return RegisterNewChallengeResponseDto.fromMap(json);
    });
  }

  Stream<void> sendEvent(ChallengeSarEvent event) async* {
    yield* appApi
        .post('/v2/sar/event', data: event.toJson())
        .handleJson(mapper: (json) => ChallengeSarEvent.fromJson(json));
  }

  Stream<ListPage<ChallengeSar>> getChallenges({
    int? id,
    String? title,
    int? tournamentId,
    String? orderBy,
    int? pageKey,
  }) async* {
    yield* appApi.get('/v2/challenge/search', queryParameters: {
      'id': id?.toString(),
      'title': title,
      'tournamentId': tournamentId?.toString(),
      'orderBy': orderBy,
      'page': pageKey?.toString(),
    }).handle(mapper: (data) {
      final stories = ((data as dynamic)['itemList'] as List<dynamic>)
          .map<ChallengeSar>((dynamic item) {
        return ChallengeSar.fromJson(item as Map<String, dynamic>);
      }).toList();

      return ListPage<ChallengeSar>(
        grandTotalCount: (data as dynamic)['grandTotalCount'],
        itemList: stories,
      );
    });
  }
}
