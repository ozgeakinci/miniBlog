import 'package:miniblog/models/blog.dart';

abstract class ArticleState {}

class ArticleInitial extends ArticleState {}

class ArticleLoading extends ArticleState {}

class ArticleLoaded extends ArticleState {
  final List<Blog> blogs;

  ArticleLoaded({required this.blogs});
}

class ArticleError extends ArticleState {}

//Detail page

