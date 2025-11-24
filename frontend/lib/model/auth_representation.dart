class AuthRepresentation {
  final String username;
  final String password;

  AuthRepresentation({ required this.username, required this.password });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory AuthRepresentation.fromJson(Map<String, dynamic> json) {
    return AuthRepresentation(
      username: json['username'],
      password: json['password'],
    );
  }
}