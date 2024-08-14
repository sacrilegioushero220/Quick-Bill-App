import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class AddPaymentDialog extends StatelessWidget {
  const AddPaymentDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      title: const Center(
        child: Text(
          'Payment Instructions',
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
              controller: controller,
              hintText: 'Note*',
              isBigField: true,
            ),
            const SizedBox(height: 10.0),
            const Align(
                alignment: Alignment.bottomRight,
                child: CustomFilledButton(title: "Save")),
          ],
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 221, 220, 220), //
    );
  }
}

void showPaymentDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddPaymentDialog();
    },
  );
}
