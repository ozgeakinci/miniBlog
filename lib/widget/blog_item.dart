import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';

import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_event.dart';
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/widget/blog_item_detail.dart';

class BlogItem extends StatefulWidget {
  const BlogItem({super.key, required this.blog});

  final Blog blog;

  @override
  State<BlogItem> createState() => _BlogItemState();
}

class _BlogItemState extends State<BlogItem> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(builder: (contex, state) {
      return InkWell(
        onTap: () {
          if (state is ArticleLoaded) {
            context.read<ArticleDetailBloc>().add(ResentEvent());
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => BlogItemDetail(id: widget.blog.id!)));
        },
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                AspectRatio(
                    aspectRatio: 2,
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        child: Center(
                            child: Image.network(
                          widget.blog.thumbnail!,
                          fit: BoxFit.cover,
                        )))),
                ListTile(
                    title: Text(
                      widget.blog.title!,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    subtitle: Text(widget.blog.author!))
              ],
            ),
          ),
        ),
      );
    });
  }
}
