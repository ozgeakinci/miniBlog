import 'package:miniblog/models/blog.dart';

abstract class ArticleDetailState {}

class DetailInitial extends ArticleDetailState {}

class DetailLoading extends ArticleDetailState {}

class DetailLoaded extends ArticleDetailState {
  final Blog blog;

  DetailLoaded({required this.blog});
}

class DetailError extends ArticleDetailState {}
