abstract class ArticleDetailEvent {}

class FetchArticleDetail extends ArticleDetailEvent {
  String id;

  FetchArticleDetail({required this.id});
}

class ResentEvent extends ArticleDetailEvent {}
