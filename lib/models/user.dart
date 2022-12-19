class User {
  final String name;
  final String? avatarUrl;

  User({required this.name, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      avatarUrl: json['avatar_url'],
    );
  }
}
