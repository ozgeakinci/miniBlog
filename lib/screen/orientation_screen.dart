import 'package:flutter/material.dart';
import 'package:miniblog/screen/homepage.dart';

class OrientationScreen extends StatelessWidget {
  const OrientationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return Container(
          child: const Center(
            child: Homepage(),
          ),
        );
      },
    );
  }
}
