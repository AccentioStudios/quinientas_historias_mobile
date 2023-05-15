import 'dart:convert';

class GroupManagementRequest {
  GroupManagementRequest(
      {this.id, this.name, this.avatarUrl, this.tournamentId, this.schoolId});

  final int? id;
  final String? name;
  final String? avatarUrl;
  final int? tournamentId;
  final int? schoolId;

  GroupManagementRequest copyWith({
    int? id,
    String? name,
    String? avatarUrl,
    int? tournamentId,
    int? schoolId,
  }) {
    return GroupManagementRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      tournamentId: tournamentId ?? this.tournamentId,
      schoolId: schoolId ?? this.schoolId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'tournamentId': tournamentId,
      'schoolId': schoolId,
    };
  }

  factory GroupManagementRequest.fromMap(Map<String, dynamic> map) {
    return GroupManagementRequest(
      id: map['id']?.toInt(),
      name: map['name'],
      avatarUrl: map['avatarUrl'],
      tournamentId: map['tournamentId']?.toInt(),
      schoolId: map['schoolId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory GroupManagementRequest.fromJson(String source) =>
      GroupManagementRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'UserManagementRequest(id: $id, name: $name, avatarUrl: $avatarUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GroupManagementRequest &&
        other.id == id &&
        other.name == name &&
        other.avatarUrl == avatarUrl &&
        other.tournamentId == tournamentId &&
        other.schoolId == schoolId;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      avatarUrl.hashCode ^
      tournamentId.hashCode ^
      schoolId.hashCode;
}
