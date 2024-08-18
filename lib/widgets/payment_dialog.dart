import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';
import 'package:quick_bill/widgets/validated_text_field.dart';

class AddPaymentDialog extends StatefulWidget {
  const AddPaymentDialog({super.key});

  @override
  State<AddPaymentDialog> createState() => _AddPaymentDialogState();
}

class _AddPaymentDialogState extends State<AddPaymentDialog> {
  final TextEditingController notesController = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<StorageCubit>(context).loadPaymentInstructions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isValid = true;
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
            BlocConsumer<StorageCubit, StorageState>(
                listener: (context, state) {
              if (state is PaymentInstructionsLoaded) {
                notesController.text = state.paymentInstructions;
              }
              if (state is InvalidPaymentInstructions) {
                isValid = false;
              }
            }, builder: (context, state) {
              if (state is NoPaymentInstructions) {
                return ValidatedTextField(
                  controller: notesController,
                  hintText: 'Note*',
                  isValid: true,
                  errorMessage: 'Note is required',
                );
              }
              return ValidatedTextField(
                controller: notesController,
                hintText: 'Note*',
                isValid: isValid,
                errorMessage: 'Note is required',
              );
            }),
            const SizedBox(height: 10.0),
            Align(
                alignment: Alignment.bottomRight,
                child: CustomFilledButton(
                  title: "Save",
                  onPressed: () {
                    final notesData = notesController.text.trim();
                    context
                        .read<StorageCubit>()
                        .updatePaymentInstructions(notesData, context);
                    //Navigator.of(context).pop(); // Close the dialog after saving
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
      return const AddPaymentDialog();
    },
  );
}
