import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/atricle_add_bloc/article_add_event.dart';
import 'package:miniblog/blocs/atricle_add_bloc/article_add_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleAddBloc extends Bloc<ArticleAddEvent, ArticleAddState> {
  final ArticleRepository articleRepository;
  ArticleAddBloc(this.articleRepository) : super(ArticleAddLoaded()) {
    on<AddArticle>(_onAddArticle);
  }

  void _onAddArticle(AddArticle event, Emitter<ArticleAddState> emit) async {
    emit(ArticleAddLoaded());
    try {
      await articleRepository.addArticle(
          event.title, event.content, event.author, event.imageFile as File?);
      emit(ArticleAddLoaded());
    } catch (e) {
      emit(ArticleAddError());
    }
  }
}
