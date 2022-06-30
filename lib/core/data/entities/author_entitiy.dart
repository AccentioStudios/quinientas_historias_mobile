import 'dart:convert';

class Author {
  Author({
    required this.name,
    required this.lastname,
  });
  final String name;
  final String lastname;

  Author copyWith({
    String? name,
    String? lastname,
  }) {
    return Author(
      name: name ?? this.name,
      lastname: lastname ?? this.lastname,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'lastname': lastname,
    };
  }

  factory Author.fromMap(Map<String, dynamic> map) {
    return Author(
      name: map['name'] ?? '',
      lastname: map['lastname'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Author.fromJson(String source) => Author.fromMap(json.decode(source));

  @override
  String toString() => 'Author(name: $name, lastname: $lastname)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Author && other.name == name && other.lastname == lastname;
  }

  @override
  int get hashCode => name.hashCode ^ lastname.hashCode;
}
