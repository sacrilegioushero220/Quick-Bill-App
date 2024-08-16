import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/controllers/customer_controllers.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class NewPayerScreen extends StatefulWidget {
  final CustomerControllers customerController;
  const NewPayerScreen({super.key, required this.customerController});

  @override
  State<NewPayerScreen> createState() => _NewPayerScreenState();
}

class _NewPayerScreenState extends State<NewPayerScreen> {
  @override
  void initState() {
    BlocProvider.of<StorageCubit>(context).loadCustomerDetails();
    super.initState();
  }

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
          child: BlocBuilder<StorageCubit, StorageState>(
            builder: (context, state) {
              if (state is StorageLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is CustomerDetailsSaved) {
                final customerDetails = state.details;
                final controller = widget.customerController;
                controller.customerNameInputController.text =
                    customerDetails.name;
                controller.customerEmailInputController.text =
                    customerDetails.email;
                controller.customerPhoneInputController.text =
                    customerDetails.phone;
                controller.customerAddressInputController.text =
                    customerDetails.address;

                // The text controllers are already updated in the cubit
              }
              return Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  CustomTextField(
                    controller:
                        widget.customerController.customerNameInputController,
                    hintText: "Payer Name*",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller:
                        widget.customerController.customerEmailInputController,
                    hintText: "Email Address*",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller:
                        widget.customerController.customerPhoneInputController,
                    hintText: "Phone number*",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                    controller: widget
                        .customerController.customerAddressInputController,
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

                          context.read<StorageCubit>().updateCustomerDetails(
                                widget.customerController,
                                context,
                              );
                        },
                      )
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
