class User {
  final String id;
  final String name;
  final String phoneNumber;
  final String accessToken;
  final String? email;
  final String? avatar;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.accessToken,
    this.email,
    this.avatar,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json, String token) {
    return User(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      accessToken: token,
      email: json['email'],
      avatar: json['avatar'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': avatar,
      'role': role,
    };
  }
} 