// lib/fuck-ddd/presentation/product/pages/product_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../controllers/product_controller.dart';
import 'product_detail_page.dart';
import '../../../domain/product/entities/product.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // optional: local cache of products for faster search UI (keeps UI responsive)
  List<Product> _filtered = [];

  @override
  void initState() {
    super.initState();
    // request initial load from controller
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<ProductController>();
      // only fetch if empty (avoids re-fetch on hot-reload)
      if (controller.products.isEmpty && !controller.isLoading) {
        controller.getProducts();
      } else {
        // initialize filtered list from existing products
        _updateFiltered(controller.products, _query);
      }
    });

    _searchController.addListener(() {
      final q = _searchController.text.trim();
      if (q == _query) return;
      setState(() => _query = q);
      final controller = context.read<ProductController>();
      _updateFiltered(controller.products, q);
    });
  }

  void _updateFiltered(List<Product> products, String q) {
    if (q.isEmpty) {
      setState(() => _filtered = List<Product>.from(products));
      return;
    }
    final lower = q.toLowerCase();
    setState(() {
      _filtered = products.where((p) {
        final name = p.name.toLowerCase();
        final brand = (p.brand ?? '').toLowerCase();
        final barcode = p.barcode.value.toLowerCase();
        return name.contains(lower) || brand.contains(lower) || barcode.contains(lower);
      }).toList();
    });
  }

  Future<void> _refresh() async {
    final controller = context.read<ProductController>();
    await controller.getProducts();
    _updateFiltered(controller.products, _query);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildBody(ProductController controller) {
    if (controller.isLoading && controller.products.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.error != null && controller.products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(controller.error!, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: controller.getProducts,
                child: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    final items = _query.isEmpty ? controller.products : _filtered;

    if (items.isEmpty) {
      return const Center(child: Text('Nenhum produto encontrado.'));
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final p = items[index];
          return ListTile(
            leading: p.imageUrl != null
                ? Image.network(p.imageUrl!, width: 56, height: 56, fit: BoxFit.cover)
                : const SizedBox(width: 56, height: 56),
            title: Text(p.name),
            subtitle: Text(p.brand ?? ''),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(barcode: p.barcode.value),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use Consumer to rebuild only the body when controller changes
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText: 'Pesquisar produtos (nome, marca, código)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _query.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                // filtered reset will happen by listener
                              },
                            )
                          : null,
                    ),
                    onSubmitted: (_) {
                      // optional: trigger a server-side search if you implement it in controller
                      // final controller = context.read<ProductController>();
                      // controller.searchProducts(_query);
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Recarregar',
                  icon: const Icon(Icons.refresh),
                  onPressed: () async {
                    await _refresh();
                  },
                )
              ],
            ),
          ),
        ),
      ),
      body: Consumer<ProductController>(
        builder: (context, controller, _) {
          // adiar a atualização do filtro pro próximo frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _updateFiltered(controller.products, _query);
          });

          return _buildBody(controller);
        },
      ),
      // simple FAB to jump to first product or clear filter as UX nicety
      floatingActionButton: _query.isNotEmpty
          ? FloatingActionButton(
              tooltip: 'Limpar pesquisa',
              child: const Icon(Icons.close),
              onPressed: () {
                _searchController.clear();
              },
            )
          : null,
    );
  }
}
