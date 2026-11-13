class Comentario {
  final int postId;
  final int id;
  final String name;
  final String email;
  final String body;

  const Comentario({
    required this.postId,
    required this.id,
    required this.name,
    required this.email,
    required this.body,
  });

  factory Comentario.fromJson(Map<String, dynamic> json) {
    return Comentario(
      postId: json['postId'] as int,
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      body: json['body'] as String,
    );
  }
}