import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../components/constants/app_colors.dart';
import '../../../components/widgets/atoms/app_button.dart';

/// Diálogo para atualizar a quantidade em estoque de um produto
class UpdateStockDialog extends StatefulWidget {
  final int? currentStock;
  final Function(int) onConfirm;

  const UpdateStockDialog({
    super.key,
    required this.currentStock,
    required this.onConfirm,
  });

  @override
  State<UpdateStockDialog> createState() => _UpdateStockDialogState();
}

class _UpdateStockDialogState extends State<UpdateStockDialog> {
  final _formKey = GlobalKey<FormState>();
  final _stockController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.currentStock != null) {
      _stockController.text = widget.currentStock.toString();
    }
  }

  @override
  void dispose() {
    _stockController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newStock = int.parse(_stockController.text);
      widget.onConfirm(newStock);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alterar Quantidade em Estoque',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.currentStock != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Quantidade atual: ${widget.currentStock} unidades',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ),
            TextFormField(
              controller: _stockController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                labelText: 'Nova Quantidade',
                hintText: '0',
                suffixText: 'unidades',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: AppColors.primaryBlue),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Digite a nova quantidade';
                }
                final quantity = int.tryParse(value);
                if (quantity == null) {
                  return 'Digite um número válido';
                }
                if (quantity < 0) {
                  return 'A quantidade não pode ser negativa';
                }
                return null;
              },
              autofocus: true,
              onFieldSubmitted: (_) => _submit(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            'Cancelar',
            style: TextStyle(color: Colors.grey),
          ),
        ),
        AppButton(
          label: 'Confirmar',
          onPressed: _submit,
        ),
      ],
    );
  }
}
