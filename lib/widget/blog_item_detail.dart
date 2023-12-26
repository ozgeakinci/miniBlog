import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniblog/models/blog.dart';
import 'package:http/http.dart' as http;

class BlogItemDetail extends StatefulWidget {
  const BlogItemDetail({Key? key, required this.blogId}) : super(key: key);
  final dynamic blogId;

  @override
  State<BlogItemDetail> createState() => _BlogItemDetailState();
}

class _BlogItemDetailState extends State<BlogItemDetail> {
  late Blog blog;

  @override
  void initState() {
    super.initState();
    blog = Blog();
    fetchBlogId();
  }

  //6996998a-7569-47c7-9edb-08dc01eef2df

  fetchBlogId() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    final dynamic jsonData = json.decode(response.body);

    setState(() {
      blog = Blog.fromJson(jsonData);
    });
  }

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
      body: Padding(
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
                        child: blog.thumbnail != null
                            ? Image.network(blog.thumbnail.toString())
                            : const CircularProgressIndicator(),
                      )),
                )),
            ListTile(
              title: Text(
                blog.title.toString(),
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
                    blog.content.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 330,
                  ),
                  Text(blog.author.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
