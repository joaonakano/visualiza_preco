import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/shared/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/shared/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/shared/widgets/molecules/app_bar_widget.dart';
import 'package:flutter_visualizador_de_precos/shared/widgets/molecules/image_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'Product Details',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              print("Return button pressed!");
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          IconButton(
            onPressed: () {
              print("Search button pressed!");
            },
            icon: const Icon(Icons.search_off_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageCard(imagePath: "assets/images/product_1_lemon.png"),
                const SizedBox(height: 40),
                Text(
                  "Combo Algébrico",
                  style: TextStyle(color: AppColors.lightGrey, fontSize: 40),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: 400,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1.5),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      "Não peça pelo lanche, não peça pelo número, peça pela equação: 2x = burger",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(
                        color: AppColors.lightGrey,
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w200,
                        fontFamily: "JetBrainsMono",
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "Código de Barras: ",
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Text(
                        "AB0000128CS1500",
                        style: TextStyle(
                          color: AppColors.lightGrey,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Unidades Disponíveis (UN):",
                      style: TextStyles.subtitle,
                    ),
                    Text(
                      "2",
                      style: TextStyle(
                        color: AppColors.error,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "R\$ 149,23",
                  style: TextStyle(color: AppColors.success, fontSize: 50),
                ),
                const SizedBox(height: 20),
                AspectRatio(
                  aspectRatio: 2.5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: LineChart(
                      LineChartData(
                        lineBarsData: [
                          LineChartBarData(
                            spots: [
                              FlSpot(0, 5),
                              FlSpot(1, 4),
                              FlSpot(2, 6),
                              FlSpot(3, 4.5),
                              FlSpot(4, 5),
                              FlSpot(5, 4.5),
                              FlSpot(6, 7),
                              FlSpot(7, 4.5),
                              FlSpot(8, 5),
                            ],
                            gradient: LinearGradient(
                              colors: [
                                AppColors.accentBlue,
                                AppColors.primaryBlue,
                              ],
                              begin: Alignment.topCenter,
                            ),
                            isCurved: true,
                            belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.blueGradientAlpha1,
                                  AppColors.blueGradientAlpha2,
                                ],
                              ),
                            ),
                            curveSmoothness: 0.3,
                          ),
                        ],
                        titlesData: FlTitlesData(show: false),
                        extraLinesData: ExtraLinesData(
                          horizontalLines: [HorizontalLine(y: 5)],
                        ),
                        lineTouchData: LineTouchData(
                          touchTooltipData: LineTouchTooltipData(
                            getTooltipItems: (touchedSpots) => touchedSpots.map((
                              LineBarSpot touchedSpot,
                            ) {
                              final textStyle = TextStyle(
                                color:
                                    touchedSpot.bar.gradient?.colors.first ??
                                    AppColors.textDark,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              );
                              return LineTooltipItem(
                                "R\$ ${touchedSpot.y.truncate()},${((touchedSpot.y - touchedSpot.y.truncate()) * 100).round()}",
                                textStyle,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
