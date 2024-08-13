import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class AddNewItemDialog extends StatelessWidget {
  const AddNewItemDialog({super.key});

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
      content: const SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextField(hintText: 'Item name'),
            SizedBox(height: 10.0),
            CustomTextField(hintText: 'Item cost'),
            SizedBox(height: 10.0),
            CustomTextField(hintText: "Quantity"),
            SizedBox(height: 20.0),
            Align(
                alignment: Alignment.bottomRight,
                child: CustomFilledButton(title: "Add")),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(
          255, 221, 220, 220), // Background color of the dialog
    );
  }
}

void showAddNewItemDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddNewItemDialog();
    },
  );
}
