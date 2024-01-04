import 'dart:io';

import 'package:image_picker/image_picker.dart';

abstract class ArticleAddEvent {}

class AddArticle extends ArticleAddEvent {
  final String title;
  final String content;
  final String author;
  final XFile? imageFile;

  AddArticle(
      {required this.title,
      required this.content,
      required this.author,
      required this.imageFile});
}
