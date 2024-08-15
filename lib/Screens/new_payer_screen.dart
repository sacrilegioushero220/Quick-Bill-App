import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/controllers/customer_controllers.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class NewPayerScreen extends StatelessWidget {
  final CustomerControllers customerController;
  const NewPayerScreen({super.key, required this.customerController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar(
        "New Payer",
        context,
        isHome: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              CustomTextField(
                controller: customerController.customerNameInputController,
                hintText: "Payer Name*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: customerController.customerEmailInputController,
                hintText: "Email Address*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: customerController.customerPhoneInputController,
                hintText: "Phone number*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: customerController.customerAddressInputController,
                hintText: "Address*",
                isBigField: true,
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  CustomFilledButton(
                    title: 'Save',
                    onPressed: () {
                      // Debugging print statements

                      BlocProvider.of<InvoiceCubit>(context).updatePayerDetails(
                        context,
                        customerController,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
