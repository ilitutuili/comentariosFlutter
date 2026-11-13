import 'package:flutter/material.dart';

import '../model/post.dart';
import '../service/api_service.dart';
import 'coments_page.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({
    super.key,
    required this.userId,
    required this.onLogout,
  });

  final int userId;
  final Future<void> Function() onLogout;

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  final _api = ApiService();
  late Future<List<Post>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _postsFuture = _api.buscarPostsDoUsuario(widget.userId);
  }

  Future<void> _atualizar() async {
    setState(() {
      _postsFuture = _api.buscarPostsDoUsuario(widget.userId);
    });
    await _postsFuture;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F0F7),
      appBar: AppBar(
        title: const Text('Meu Marketplace'),
        actions: [
          IconButton(
            tooltip: 'Sair',
            onPressed: widget.onLogout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _postsFuture,
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

          final posts = snapshot.data ?? [];

          if (posts.isEmpty) {
            return const Center(child: Text('Este usuário não tem posts.'));
          }

          return RefreshIndicator(
            onRefresh: _atualizar,
            child: ListView.separated(
              itemCount: posts.length,
              separatorBuilder: (_, _) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final post = posts[index];

                return ListTile(
                  title: Text(
                    post.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    post.body,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => CommentsPage(
                          postId: post.id,
                          postTitle: post.title,
                        ),
                      ),
                    );
                  },
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
