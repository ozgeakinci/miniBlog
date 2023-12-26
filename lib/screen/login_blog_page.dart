import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miniblog/screen/homepage.dart';

class LoginBlogPage extends StatefulWidget {
  const LoginBlogPage({Key? key}) : super(key: key);

  @override
  State<LoginBlogPage> createState() => _LoginBlogPageState();
}

class _LoginBlogPageState extends State<LoginBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff005FEE),
      body: InkWell(
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const Homepage())),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Column(
              children: [
                Text('Blog',
                    style: GoogleFonts.comfortaa(
                        color: Colors.white, fontSize: 96)),
                Text('App',
                    style: GoogleFonts.comfortaa(
                        color: Colors.white, fontSize: 96)),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
