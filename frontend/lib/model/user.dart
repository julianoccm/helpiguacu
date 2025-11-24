class User {
  final int? id;
  final String name;
  final String cpf;
  final String email;
  final String password;
  final String cep;
  final String addresNumber;
  final String addresComplement;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.name,
    required this.cpf,
    required this.email,
    required this.password,
    required this.cep,
    required this.addresNumber,
    required this.addresComplement,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      cpf: json['cpf'],
      email: json['email'],
      password: json['password'],
      cep: json['cep'],
      addresNumber: json['addresNumber'],
      addresComplement: json['addresComplement'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'cpf': cpf,
      'email': email,
      'password': password,
      'cep': cep,
      'addresNumber': addresNumber,
      'addresComplement': addresComplement,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
