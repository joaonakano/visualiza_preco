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
  late Future<List<Quote>> _futureQuotes;

  @override
  void initState() {
    super.initState();
    _futureQuotes = _loadQuotes(); // inicializa o future
  }

  // Adaptação do fetchData para poder utilizar a animação de loading das Quotes
  Future<List<Quote>> _loadQuotes() async {
    try {
      // Aplicação tenta solicitar os dados da API
      return await KeanuService().fetchQuotes(10);
    } catch (e) {
      debugPrint("Error: $e"); // Qualquer erro na solicitação é retornado
      return [];
    }
  }

  void _reloadQuotes() {
    setState(() {
      _futureQuotes = _loadQuotes(); // recarrega os dados
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBarWidget(
        title: 'New Dashboard (Teste de API)',
        actions: [
          IconButton(
            onPressed: _reloadQuotes,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload Quotes',
          ),
          IconButton(
            onPressed: () => debugPrint("Search Button Pressed!!"),
            icon: const Icon(Icons.search),
            tooltip: 'Search',
          ),
        ],
      ),
      body: FutureBuilder<List<Quote>>(
        //"observando" alguma mudança no Future
        future: _futureQuotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  color: AppColors.backgroundLight, // uso dos Atoms
                  strokeWidth: 6,
                ),
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Erro ao carregar dados",
                style: TextStyles.label.copyWith(
                  // uso dos Atoms
                  color: AppColors.error,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            );
          }

          final quotes = snapshot.data ?? [];

          if (quotes.isEmpty) {
            return Center(
              child: Text(
                "Nenhum dado encontrado",
                style: TextStyles.label.copyWith(
                  // uso dos Atoms
                  color: AppColors.backgroundLight,
                  fontSize: 16,
                ),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keanu Reeves - Falas',
                  style: TextStyles.title.copyWith(
                    // uso dos Atoms
                    color: AppColors.backgroundLight,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Whoas do Keanu Reeves.',
                  style: TextStyles.subtitle.copyWith(
                    color: AppColors.backgroundLight.withValues(
                      alpha: 0.7,
                    ), // uso dos Atoms
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: quotes.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 24,
                          crossAxisSpacing: 24,
                          childAspectRatio: 0.75,
                        ),
                    itemBuilder: (context, index) {
                      final quote = quotes[index];
                      return MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            20,
                          ), //MICROINTERAÇÃO
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ProductScreen(quote: quote),
                              ),
                            );
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: AppColors.veryLightGrey, // uso dos Atoms
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: quote.poster.isNotEmpty
                                        ? Image.network(
                                            quote.poster,
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null) {
                                                    return child;
                                                  }
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                            errorBuilder:
                                                (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) => const Icon(
                                                  Icons.broken_image,
                                                  size: 56,
                                                  color: AppColors
                                                      .grey, // uso dos Atoms
                                                ),
                                          )
                                        : const Icon(
                                            Icons.image_not_supported,
                                            size: 56,
                                            color: AppColors.grey,
                                          ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        quote.fullLine,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyles.label.copyWith(
                                          // uso dos Atoms
                                          color: AppColors.borderColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        "- ${quote.character}",
                                        style: TextStyles.label.copyWith(
                                          //".copyWith", permite personalizar um atom já definido + uso dos Atoms
                                          color: AppColors.borderColor
                                              .withValues(alpha: 0.7),
                                          fontStyle: FontStyle.italic,
                                          fontSize: 13,
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
