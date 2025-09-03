import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';
import 'package:flutter_visualizador_de_precos/screens/product/product_screen.dart';
import 'package:flutter_visualizador_de_precos/services/keanu_service.dart';
import 'package:flutter_visualizador_de_precos/shared/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/shared/widgets/molecules/app_bar_widget.dart';
//barra superior
//3 barras na esquerda
//meio recarregar
//direita pesquisar

class NewDashBoard extends StatefulWidget {
  const NewDashBoard({super.key});

  @override
  State<NewDashBoard> createState() => _NewDashBoardState();
}

class _NewDashBoardState extends State<NewDashBoard> {
  void fetchData() async {
    try {
      List<Quote> quotes = await KeanuService().fetchQuotes(); 
      print(quotes);
    } catch (e) {
      print("Error: $e");
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Pressione para receber os dados da API (Consulte o DEBUG CONSOLE ou TERMINAL):"),
            ElevatedButton(onPressed: fetchData, child: const Text("Fetch data"),),
          ],
        ),
      ),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'Dashboard',
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              print("Return button pressed!");
            },
            icon: const Icon(Icons.arrow_back),
          ),
          IconButton(
            onPressed: () {
              print("Refresh pressed!");
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              print("Search button pressed!");
            },
            icon: const Icon(Icons.search_off_sharp),
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: 3,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.5,
        ),
        itemBuilder: (context, index) {
          return MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductScreen(),
                  ),
                );
              },
              child: Card(
                color: AppColors.veryLightGrey,
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
