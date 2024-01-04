import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:miniblog/blocs/article_detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_event.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_state.dart';

class BlogItemDetail extends StatefulWidget {
  const BlogItemDetail({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  State<BlogItemDetail> createState() => _BlogItemDetailState();
}

class _BlogItemDetailState extends State<BlogItemDetail> {
  // @override
  // void initState() {
  //   super.initState();
  //   blog = Blog();
  //   fetchBlogId();
  // }

  //6996998a-7569-47c7-9edb-08dc01eef2df

  // fetchBlogId() async {
  //   Uri url = Uri.parse(
  //       "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
  //   final response = await http.get(url);
  //   final dynamic jsonData = json.decode(response.body);

  //   setState(() {
  //     blog = Blog.fromJson(jsonData);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xff005FEE),
          title: Text(
            'Blog Details',
            style: GoogleFonts.comfortaa(color: Colors.white, fontSize: 24),
          ),
        ),
        body: ListView(
          children: [
            BlocBuilder<ArticleDetailBloc, ArticleDetailState>(
              builder: (context, state) {
                print('Current state $state');
                if (state is DetailInitial) {
                  context
                      .read<ArticleDetailBloc>()
                      .add(FetchArticleDetail(id: widget.id));
                  return const Center(child: Text('Veriler gönderiliyor...'));
                }
                if (state is DetailLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is DetailLoaded) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        AspectRatio(
                            aspectRatio: 4 / 2,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  width: double.infinity,
                                  child: Center(
                                    child: state.blog.thumbnail != null
                                        ? Image.network(
                                            state.blog.thumbnail.toString())
                                        : const CircularProgressIndicator(),
                                  )),
                            )),
                        ListTile(
                          title: Text(
                            state.blog.title!,
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                state.blog.content!,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(
                                height: 150,
                              ),
                              Text(state.blog.author!),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }

                return Center(child: Text(widget.id));
              },
            ),
          ],
        ));
  }
}
