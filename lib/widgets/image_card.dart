import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final double? imageWidth;
  final double? imageHeight;
  final double? cardHeight;
  final double? cardWidth;
  
  const ImageCard({
    required this.imagePath,
    this.cardHeight = 300,
    this.cardWidth = 290, 
    this.imageHeight,
    this.imageWidth,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      shadowColor: Colors.black,
      elevation: 30,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.white12,
          width: 3,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: FittedBox(
          child: Image.asset(
            imagePath,
            height: imageHeight ?? cardHeight,
            width: imageWidth ?? cardWidth,
            fit: BoxFit.cover,
          ),
        ),
      )
    );
  }
}