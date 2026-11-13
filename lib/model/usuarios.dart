class Usuario {
  final int id;
  final String username;

  const Usuario({
    required this.id,
    required this.username,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'] as int,
      username: json['username'] as String,
    );
  }
}