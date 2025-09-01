import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/screens/product/product_screen.dart';
import 'package:flutter_visualizador_de_precos/widgets/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

//barra superior
//3 barras na esquerda
//meio recarregar
//direita pesquisar

//abaixo grid com 3 produtos de exemplo
//>profit

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
                Icons.arrow_back,
                color: Colors.white54,
                size: 35,
              )
            ),
            IconButton(
              onPressed: () {
                print("Refresh pressed!");
              },
              icon: Icon(
                Icons.refresh,
                color: Colors.white54,
                size: 35,
              ),
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
      body: GridView.builder(
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:   1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.5,
        ),
        itemBuilder:  (context, index) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProductScreen()),
                );
              },
              child: Card(
                color: Colors.black26,
                child: Center(
                  child: Image.asset(
                    "assets/images/product_1_lemon.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}