enum UserRole { admin, trainor, president }

class User {
  final String id;
  final String username;
  final String password;
  final String name;
  final UserRole role;
  final String? rpagId;

  const User({
    required this.id,
    required this.username,
    required this.password,
    required this.name,
    required this.role,
    this.rpagId,
  });

  User copyWith({
    String? id,
    String? username,
    String? password,
    String? name,
    UserRole? role,
    String? rpagId,
  }) {
    return User(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      name: name ?? this.name,
      role: role ?? this.role,
      rpagId: rpagId ?? this.rpagId,
    );
  }
}
