import 'dart:convert';

class GroupManagementRequest {
  GroupManagementRequest({
    this.id,
    this.name,
    this.avatarUrl,
  });

  final int? id;
  final String? name;
  final String? avatarUrl;

  GroupManagementRequest copyWith({
    int? id,
    String? name,
    String? avatarUrl,
  }) {
    return GroupManagementRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
    };
  }

  factory GroupManagementRequest.fromMap(Map<String, dynamic> map) {
    return GroupManagementRequest(
      id: map['id']?.toInt(),
      name: map['name'],
      avatarUrl: map['avatarUrl'],
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
        other.avatarUrl == avatarUrl;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ avatarUrl.hashCode;
}
