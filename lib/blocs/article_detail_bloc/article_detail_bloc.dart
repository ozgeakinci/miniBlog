import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_event.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_state.dart';
import 'package:miniblog/repositories/article_repository.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArticleRepository articleRepository;
  ArticleDetailBloc(this.articleRepository) : super(DetailInitial()) {
    on<FetchArticleDetail>(_onFetchArticleDetail);
    on<ResentEvent>(_onResetEvent);
  }

  void _onFetchArticleDetail(
      FetchArticleDetail event, Emitter<ArticleDetailState> emit) async {
    emit(DetailLoading());
    try {
      final blogId = await articleRepository.fetchBlogId(event.id);
      emit(DetailLoaded(blog: blogId));
    } catch (e) {
      emit(DetailError());
    }
  }

  void _onResetEvent(ResentEvent event, Emitter<ArticleDetailState> emit) {
    emit(DetailInitial());
  }
}
