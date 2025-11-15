import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../components/constants/app_colors.dart';
import '../../../components/widgets/atoms/app_button.dart';

/// Diálogo para atualizar o preço de venda de um produto
class UpdatePriceDialog extends StatefulWidget {
  final double? currentPrice;
  final Function(double) onConfirm;

  const UpdatePriceDialog({
    super.key,
    required this.currentPrice,
    required this.onConfirm,
  });

  @override
  State<UpdatePriceDialog> createState() => _UpdatePriceDialogState();
}

class _UpdatePriceDialogState extends State<UpdatePriceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.currentPrice != null) {
      _priceController.text = widget.currentPrice!.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPrice = double.parse(_priceController.text.replaceAll(',', '.'));
      widget.onConfirm(newPrice);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Alterar Preço de Venda',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.currentPrice != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  'Preço atual: R\$ ${widget.currentPrice!.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            TextFormField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+[,.]?\d{0,2}')),
              ],
              decoration: InputDecoration(
                labelText: 'Novo Preço (R\$)',
                hintText: '0.00',
                prefixText: 'R\$ ',
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
                  return 'Digite o novo preço';
                }
                final price = double.tryParse(value.replaceAll(',', '.'));
                if (price == null) {
                  return 'Digite um valor válido';
                }
                if (price < 0) {
                  return 'O preço deve ser maior que zero';
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
          child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
        ),
        AppButton(label: 'Confirmar', onPressed: _submit),
      ],
    );
  }
}
