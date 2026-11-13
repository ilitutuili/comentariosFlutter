import '../model/comentarios.dart';
import '../model/post.dart';

class ApiService {
  Future<List<Post>> buscarPostsDoUsuario(int userId) async {
    return const [
      Post(
        id: 1,
        userId: 1,
        title: 'Conheça o nosso marketplace',
        body: 'Um espaço para descobrir produtos de diferentes vendedores e encontrar novas opções em um só lugar.',
      ),
      Post(
        id: 2,
        userId: 1,
        title: 'Vendedores e produtos em destaque',
        body: 'Explore as vitrines dos vendedores, conheça seus produtos e compare as opções disponíveis.',
      ),
      Post(
        id: 3,
        userId: 1,
        title: 'Encontre o que você procura',
        body: 'Navegue pelas categorias do marketplace e descubra itens para diferentes gostos e necessidades.',
      ),
      Post(
        id: 4,
        userId: 1,
        title: 'Uma experiência de compra simples',
        body: 'Veja os detalhes de cada anúncio e escolha com calma o produto que combina com você.',
      ),
      Post(
        id: 5,
        userId: 1,
        title: 'Novidades do marketplace',
        body: 'Sempre há novos produtos e vendedores para conhecer. Volte para conferir as novidades!',
      ),
    ];
  }

  Future<List<Comentario>> buscarComentariosDoPost(int postId) async {
    return [
      Comentario(
        postId: postId,
        id: 1,
        name: 'Equipe do Marketplace',
        email: 'equipe@marketplace.example',
        body: 'Obrigado por visitar nosso marketplace! Reunimos diferentes opções para facilitar sua busca.',
      ),
      Comentario(
        postId: postId,
        id: 2,
        name: 'Equipe do Marketplace',
        email: 'equipe@marketplace.example',
        body: 'Explore as categorias e use os detalhes dos anúncios para comparar os produtos.',
      ),
      Comentario(
        postId: postId,
        id: 3,
        name: 'Equipe do Marketplace',
        email: 'equipe@marketplace.example',
        body: 'Cada vendedor apresenta seus produtos para você conhecer melhor as opções disponíveis.',
      ),
      Comentario(
        postId: postId,
        id: 4,
        name: 'Equipe do Marketplace',
        email: 'equipe@marketplace.example',
        body: 'Ficou com dúvida sobre um produto? Consulte as informações do anúncio antes de escolher.',
      ),
      Comentario(
        postId: postId,
        id: 5,
        name: 'Equipe do Marketplace',
        email: 'equipe@marketplace.example',
        body: 'Estamos preparando novidades para deixar sua experiência no marketplace cada vez melhor.',
      ),
    ];
  }
}
