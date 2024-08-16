import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';
import 'package:quick_bill/widgets/validated_text_field.dart';

import '../model/models.dart';

class AddNewItemDialog extends StatefulWidget {
  const AddNewItemDialog({super.key});

  @override
  _AddNewItemDialogState createState() => _AddNewItemDialogState();
}

class _AddNewItemDialogState extends State<AddNewItemDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();
  bool _isPriceValid = true;
  bool _isQtyValid = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Center(
        child: Text(
          'Add new item',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(
              controller: nameController,
              hintText: 'Item name',
            ),
            const SizedBox(height: 10.0),
            ValidatedTextField(
              controller: priceController,
              hintText: 'Item cost',
              keyboardType: TextInputType.number,
              isValid: _isPriceValid,
              errorMessage: 'Please enter a valid number',
            ),
            const SizedBox(height: 10.0),
            ValidatedTextField(
              controller: qtyController,
              hintText: 'Quantity',
              keyboardType: TextInputType.number,
              isValid: _isQtyValid,
              errorMessage: 'Please enter a valid number',
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.bottomRight,
              child: CustomFilledButton(
                title: "Add",
                onPressed: () {
                  setState(() {
                    _isPriceValid =
                        double.tryParse(priceController.text) != null;
                    _isQtyValid = int.tryParse(qtyController.text) != null;
                  });

                  if (nameController.text.isNotEmpty &&
                      _isPriceValid &&
                      _isQtyValid) {
                    final newItem = Item(
                      name: nameController.text,
                      qty: int.parse(qtyController.text),
                      price: double.parse(priceController.text),
                    );

                    context.read<StorageCubit>().addItem(newItem);

                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
    );
  }
}

Future<Item?> showAddNewItemDialog(BuildContext context) {
  return showDialog<Item?>(
    context: context,
    builder: (BuildContext context) {
      return const AddNewItemDialog();
    },
  );
}
