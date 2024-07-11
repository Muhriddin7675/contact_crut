class AuthData {
  final int? id;
  final String email;
  final String password;

  AuthData(this.id, {required this.email, required this.password});

  factory AuthData.fromJson(Map<String, dynamic> json) =>
      AuthData(json['id'], email: json['email'], password: json['password']);

  Map<String, dynamic> toJson() => {'id': id, 'email': email, 'password': password};
}
