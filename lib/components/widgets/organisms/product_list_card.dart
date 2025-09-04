import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import '../molecules/app_card.dart';

class ProductListCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String barcode;
  final String price;

  const ProductListCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.barcode,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          Image.asset(imagePath, fit: BoxFit.cover),
          Text(
            title,
            style: TextStyle(color: AppColors.textDark, fontSize: 20),
          ),
          Text(barcode, style: TextStyle(color: AppColors.grey)),
          Text(price, style: TextStyle(color: AppColors.success, fontSize: 24)),
        ],
      ),
    );
  }
}
