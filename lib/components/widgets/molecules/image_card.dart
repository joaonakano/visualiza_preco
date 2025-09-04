import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_spacings.dart';

class ImageCard extends StatelessWidget {
  final String imagePath;
  final double? imageWidth;
  final double? imageHeight;
  final double? cardHeight;
  final double? cardWidth;

  const ImageCard({
    super.key,
    required this.imagePath,
    this.cardHeight = 300,
    this.cardWidth = 290,
    this.imageHeight,
    this.imageWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.veryLightGrey,
      shadowColor: Colors.black,
      elevation: AppSpacings.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSpacings.borderRadius20),
        side: BorderSide(color: AppColors.veryLightGrey, width: 3),
      ),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        height: cardHeight,
        width: cardWidth,
        child: FittedBox(
          child: Image.network(
            imagePath,
            height: imageHeight ?? cardHeight,
            width: imageWidth ?? cardWidth,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
