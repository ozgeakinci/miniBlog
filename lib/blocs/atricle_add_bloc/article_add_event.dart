import 'dart:io';

abstract class ArticleAddEvent {}

class AddArticle extends ArticleAddEvent {
  final String title;
  final String content;
  final String author;
  final String imageFile;

  AddArticle(
      {required this.title,
      required this.content,
      required this.author,
      required this.imageFile});
}
