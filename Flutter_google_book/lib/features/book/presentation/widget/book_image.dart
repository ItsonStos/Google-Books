import 'package:flutter/material.dart';

class BookImage extends StatelessWidget {
  final String imageLink;
  final double widthImage;
  final double? heigthImage;
  final BoxFit fitImage;
  const BookImage({
    super.key,
    required this.imageLink,
    this.widthImage = 60,
    this.heigthImage,
    this.fitImage = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageLink,
      width: widthImage,
      height: heigthImage,
      fit: BoxFit.cover,
      errorBuilder: (context, _, __) {
        return Image.asset(
          'assets/placeholder.jpg',
          width: widthImage,
          height: heigthImage,
          fit: fitImage,
        );
      },
    );
  }
}