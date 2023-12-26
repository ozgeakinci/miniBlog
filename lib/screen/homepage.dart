import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/blog.dart';
import 'package:miniblog/screen/add_blog.dart';
import 'package:miniblog/widget/blog_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List blogs = [];
  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    setState(() {
      blogs = jsonData.map((json) => Blog.fromJson(json)).toList();
    });
  }

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
        body: blogs.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  fetchBlogs();
                },
                child: ListView.builder(
                    itemCount: blogs.length,
                    itemBuilder: (context, index) => BlogItem(
                          blog: blogs[index],
                        )),
              ));
  }
}
