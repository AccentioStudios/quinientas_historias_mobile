// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'challenge_sar_entity.g.dart';

@JsonSerializable()
class ChallengeSar {
  ChallengeSar({
    this.id,
    required this.name,
    required this.description,
    required this.url,
    required this.probability,
    required this.required,
    required this.tournaments,
    required this.steps,
    required this.params,
    required this.triggers,
    required this.weight,
    required this.active,
    required this.points,
  });

  factory ChallengeSar.fromJson(Map<String, dynamic> json) =>
      _$ChallengeSarFromJson(json);
  final int? id;
  final String name;
  final String description;
  final String url;
  final double probability;
  final double weight;
  final bool required;
  final bool active;
  final List<String> triggers;
  final List<int> tournaments;
  final int? steps;
  final List<String> params;
  final int? points;

  Map<String, dynamic> toJson() => _$ChallengeSarToJson(this);

  ChallengeSar copyWith({
    int? id,
    String? name,
    String? description,
    String? url,
    double? probability,
    double? weight,
    bool? required,
    bool? active,
    List<String>? triggers,
    List<int>? tournaments,
    int? steps,
    List<String>? params,
    int? points,
  }) {
    return ChallengeSar(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      url: url ?? this.url,
      probability: probability ?? this.probability,
      weight: weight ?? this.weight,
      required: required ?? this.required,
      active: active ?? this.active,
      triggers: triggers ?? this.triggers,
      tournaments: tournaments ?? this.tournaments,
      steps: steps ?? this.steps,
      params: params ?? this.params,
      points: points ?? this.points,
    );
  }
}
