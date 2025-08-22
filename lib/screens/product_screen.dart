import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/widgets/appbar.dart';
import 'package:flutter_visualizador_de_precos/widgets/image_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBarWidget(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                print("Return button pressed!");
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white54,
                size: 35,
              )
            ),
            IconButton(
              onPressed: () {
                print("Search button pressed!");
              },
              icon: Icon(
                Icons.search_off_sharp,
                color: Colors.white54,
                size: 35,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageCard(imagePath: "assets/images/product_1_lemon.png"),
              const SizedBox(height: 20,),
              Text(
                "Combo Algébrico",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
        
                ),
              ),
              const SizedBox(height: 40,),
              SizedBox(
                width: 400,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1.5)
                  ),
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "\tNão peça pelo lanche, não peça pelo número, peça pela equação: 2x = burger",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w200,
                      fontFamily: "JetBrainsMono"
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Código de Barras: ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  const Text(
                    "AB0000128CS1500",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Unidades Disponíveis (UN):",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "2",
                    style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              const Text(
                "R\$ 149,23",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 50
                ),
              ),
              const SizedBox(height: 20,),
              AspectRatio(
                aspectRatio: 3.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
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
                          gradient: LinearGradient(colors: [
                            Colors.lightBlueAccent,
                            Colors.blue.shade600
                          ], begin: Alignment.topCenter),
                          isCurved: true,
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(colors: [
                              Colors.lightBlueAccent.withAlpha(90),
                              Colors.blue.shade800.withAlpha(60),
                            ])
                          ),
                          curveSmoothness: 0.3
                        ),
                      ],
                      titlesData: FlTitlesData(
                        show: false
                      ),
                      extraLinesData: ExtraLinesData(
                        horizontalLines: [HorizontalLine(y: 5)]
                      ),
                      lineTouchData: LineTouchData(
                        touchTooltipData: LineTouchTooltipData(getTooltipItems: (touchedSpots) =>
                          touchedSpots.map((LineBarSpot touchedSpot) {
                            final textStyle = TextStyle(
                              color: touchedSpot.bar.gradient?.colors.first ??
                                  touchedSpot.bar.color ??
                                  Colors.blueGrey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            );
                            // Heavy Black Magic to convert DOUBLE to REAL
                            return LineTooltipItem("R\$ ${touchedSpot.y.truncate()},${((touchedSpot.y - touchedSpot.y.truncate()) * 100).round()}", textStyle);
                          }).toList()
                        )
                      )
                    ),
                  ),
                )
              )       
            ],
          ),
        ),
      ),
    );
  }
}


