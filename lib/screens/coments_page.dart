import 'package:flutter/material.dart';

import '../model/comentarios.dart';
import '../service/api_service.dart';

class CommentsPage extends StatefulWidget {
  const CommentsPage({
    super.key,
    required this.postId,
    required this.postTitle,
  });

  final int postId;
  final String postTitle;

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final _api = ApiService();
  late Future<List<Comentario>> _commentsFuture;

  @override
  void initState() {
    super.initState();
    _commentsFuture = _api.buscarComentariosDoPost(widget.postId);
  }

  Future<void> _atualizar() async {
    setState(() {
      _commentsFuture = _api.buscarComentariosDoPost(widget.postId);
    });
    await _commentsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F0F7),
      appBar: AppBar(
        title: Text(
          'Comentários',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: FutureBuilder<List<Comentario>>(
        future: _commentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _mensagemErro(
              snapshot.error.toString(),
              _atualizar,
            );
          }

          final comentarios = snapshot.data ?? [];

          if (comentarios.isEmpty) {
            return const Center(
              child: Text('Este post não tem comentários.'),
            );
          }

          return RefreshIndicator(
            onRefresh: _atualizar,
            child: ListView.separated(
              itemCount: comentarios.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final comentario = comentarios[index];

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        comentario.name,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        comentario.email,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      const SizedBox(height: 8),
                      Text(comentario.body),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _mensagemErro(String mensagem, Future<void> Function() tentarNovamente) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(mensagem, textAlign: TextAlign.center),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: tentarNovamente,
            child: const Text('Tentar novamente'),
          ),
        ],
      ),
    );
  }
}