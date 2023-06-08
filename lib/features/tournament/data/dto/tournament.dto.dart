// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tournament.dto.g.dart';

@JsonSerializable()
class TournamentDto {
  TournamentDto({
    this.id,
    this.name,
    this.description,
    this.startAt,
    this.endsAt,
    this.tagId,
    this.coverUrl,
  });

  factory TournamentDto.fromJson(Map<String, dynamic> json) =>
      _$TournamentDtoFromJson(json);

  final int? id;
  final String? name;
  final String? description;
  final DateTime? startAt;
  final DateTime? endsAt;
  final int? tagId;
  final String? coverUrl;

  Map<String, dynamic> toJson() => _$TournamentDtoToJson(this);

  TournamentDto copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? startAt,
    DateTime? endsAt,
    int? tagId,
    String? coverUrl,
  }) {
    return TournamentDto(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      startAt: startAt ?? this.startAt,
      endsAt: endsAt ?? this.endsAt,
      tagId: tagId ?? this.tagId,
      coverUrl: coverUrl ?? this.coverUrl,
    );
  }
}
