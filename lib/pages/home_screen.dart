import 'package:flutter/material.dart';
import 'package:flutter_visualizador_de_precos/models/keanu_quotes_model.dart';
import 'package:flutter_visualizador_de_precos/pages/product/product_screen.dart';
import 'package:flutter_visualizador_de_precos/services/keanu_service.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_colors.dart';
import 'package:flutter_visualizador_de_precos/components/constants/app_text_styles.dart';
import 'package:flutter_visualizador_de_precos/components/widgets/molecules/app_bar_widget.dart';

class NewDashBoard extends StatefulWidget {
  const NewDashBoard({super.key});

  @override
  State<NewDashBoard> createState() => _NewDashBoardState();
}

class _NewDashBoardState extends State<NewDashBoard> {
  List<Quote> _quotes = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadQuotes();
  }

  // Adaptação do fetchData para poder utilizar a animação de loading das Quotes
  Future<void> _loadQuotes() async { 
    setState(() => _loading = true);

    try { // Aplicação tenta solicitar os dados da API
      _quotes = await KeanuService().fetchQuotes(10);
    } catch (e) { // Qualquer erro na solicitação é retornado
      debugPrint("Error: $e");
    } finally { // Se tudo correr bem, descartar a animação de loading
      setState(() => _loading = false);
      print(_quotes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'New Dashboard (Teste de API)',
        actions: [
          IconButton(
            onPressed: _loadQuotes,
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: (){print("Search Button Pressed!!");},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.backgroundLight), // uso do Atom
            )
          : _quotes.isEmpty
              ? const Center(
                  child: Text(
                    "Nenhum dado encontrado",
                    style: TextStyle(color: AppColors.backgroundLight), // uso do Atom
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _quotes.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final quote = _quotes[index];
                    return MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductScreen(quote: quote),
                            ),
                          );
                        },
                        child: Card(
                          color: AppColors.veryLightGrey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: quote.poster.isNotEmpty
                                      ? Image.network(
                                          quote.poster,
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return const Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                            Icons.broken_image,
                                            size: 48,
                                            color: AppColors.grey, // uso do Atom
                                          ),
                                        )
                                      : const Icon(
                                          Icons.image_not_supported,
                                          size: 48,
                                          color: AppColors.grey, // uso do Atom
                                        ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      quote.fullLine,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyles.label.copyWith( // uso dos Atoms
                                        color: AppColors.borderColor,
                                      )
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "- ${quote.character}",
                                      style: TextStyles.label.copyWith( //".copyWith", permite personalizar um atom já definido + uso dos Atoms
                                        color: AppColors.borderColor
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
