import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:miniblog/blocs/atricle_add_bloc/article_add_event.dart';
import 'package:miniblog/blocs/atricle_add_bloc/article_add_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleAddBloc extends Bloc<ArticleAddEvent, ArticleAddState> {
  final ArticleRepository articleRepository;
  ArticleAddBloc(this.articleRepository) : super(ArticleAddInitial()) {
    on<AddArticle>(_onAddArticle);
  }

  void _onAddArticle(AddArticle event, Emitter<ArticleAddState> emit) async {
    try {
      await articleRepository.addArticle(
          event.title, event.content, event.author, event.imageFile);
    } catch (e) {
      emit(ArticleAddError());
    }
  }
}
