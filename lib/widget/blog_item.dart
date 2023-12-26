import 'package:flutter/material.dart';
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
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => BlogItemDetail(blogId: widget.blog.id)));
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
  }
}
