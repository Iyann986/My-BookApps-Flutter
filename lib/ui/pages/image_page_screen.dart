import 'package:flutter/material.dart';

class ImagePageScreen extends StatelessWidget {
  const ImagePageScreen({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Stack(
        children: [
          Center(
            child: Image.network(imageUrl),
          ),
          const BackButton(),
        ],
      )),
    );
  }
}
