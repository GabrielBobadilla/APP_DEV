enum UserRole { admin, trainor, president, member }

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

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'password': password,
        'name': name,
        'role': role.name,
        'rpagId': rpagId,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        username: json['username'] as String,
        password: json['password'] as String,
        name: json['name'] as String,
        role: UserRole.values.firstWhere((r) => r.name == json['role']),
        rpagId: json['rpagId'] as String?,
      );
}