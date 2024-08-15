import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/Screens/home_screen.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class AddPaymentDialog extends StatelessWidget {
  final TextEditingController notesController = TextEditingController();
  AddPaymentDialog({super.key});

  @override
  Widget build(BuildContext context) {
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
              controller: notesController,
              hintText: 'Note*',
              isBigField: true,
            ),
            const SizedBox(height: 10.0),
            Align(
                alignment: Alignment.bottomRight,
                child: CustomFilledButton(
                  title: "Save",
                  onPressed: () {
                    final notesData = notesController.text.trim();
                    context
                        .read<InvoiceCubit>()
                        .updatePaymentInstructions(notesData);
                  },
                )),
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
      return AddPaymentDialog();
    },
  );
}
