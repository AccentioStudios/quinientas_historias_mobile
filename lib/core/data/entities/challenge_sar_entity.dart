import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_sar_entity.g.dart';

@JsonSerializable()
class ChallengeSar {
  ChallengeSar({
    required this.name,
    required this.url,
    required this.probability,
    required this.required,
    required this.active,
    required this.tournaments,
    required this.params,
    this.sessionToken,
  });
  final String name;
  final String url;
  final double probability;
  final bool required;
  final bool active;
  final List<int> tournaments;
  final List<String> params;
  final String? sessionToken;
}
