import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/screen/add_blog.dart';
import 'package:miniblog/widget/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff005FEE),
          title: Text(
            'Blogs',
            style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 24),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddBlog()));
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 32,
                ))
          ],
        ),
        body: BlocBuilder<ArticleBloc, ArticleState>(
          builder: (context, state) {
            if (state is ArticleInitial) {
              context.read<ArticleBloc>().add(FetchArticles());
              return const Center(child: Text('veri yükleniyor...'));
            }
            if (state is ArticleLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is ArticleLoaded) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ArticleBloc>().add(FetchArticles());
                },
                child: ListView.builder(
                    itemCount: state.blogs.length,
                    itemBuilder: (context, index) =>
                        BlogItem(blog: state.blogs.reversed.toList()[index])),
              );
            }
            return const Center(
              child: Text('Unknown State'),
            );
          },
        ));
  }
}
