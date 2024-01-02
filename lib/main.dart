import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/repositories/article_repository.dart';
import 'package:miniblog/screen/homepage.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ArticleBloc(articleRepository: ArticleRepository()),
        ),
        BlocProvider(
            create: (context) => ArticleDetailBloc(ArticleRepository()))
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: Homepage()),
    ),
  );
}
