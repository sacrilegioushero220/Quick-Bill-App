import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

import '../model/models.dart';

class AddNewItemDialog extends StatelessWidget {
  AddNewItemDialog({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController qtyController = TextEditingController();

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
            CustomTextField(
              controller: priceController,
              hintText: 'Item cost',
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10.0),
            CustomTextField(
              controller: qtyController,
              hintText: "Quantity",
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      priceController.text.isNotEmpty &&
                      qtyController.text.isNotEmpty) {
                    final newItem = Item(
                      name: nameController.text,
                      qty: int.parse(qtyController.text),
                      price: double.parse(priceController.text),
                    );
                    Navigator.of(context).pop(newItem);
                  } else {
                    // Show an error message or handle invalid input
                  }
                },
                child: const Text("Add"),
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
      return AddNewItemDialog();
    },
  );
}
