import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Screens/add_item_screen.dart';
import 'package:quick_bill/Screens/business_detail_screen.dart';
import 'package:quick_bill/Screens/new_payer_screen.dart';
import 'package:quick_bill/Screens/signature_screen.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/controllers/business_controllers.dart';
import 'package:quick_bill/controllers/customer_controllers.dart';
import 'package:quick_bill/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/model/models.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class NewInvoiceScreen extends StatelessWidget {
  const NewInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => InvoiceCubit()..createInvoice(),
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 221, 220, 220),
        appBar: customAppBar(
          "New Invoice",
          context,
          isHome: false,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
              ),
              child: BlocBuilder<InvoiceCubit, InvoiceState>(
                builder: (context, state) {
                  String invoiceId = 'N/A';
                  String dateNow = 'N/A';
                  print("Current state is : $state");
                  if (state is InvoiceData) {
                    invoiceId = state.invoiceId;
                    dateNow = state.date;
                  }

                  return Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      InvoiceCard(
                        invoiceId: invoiceId,
                        dateNow: dateNow,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InvoiceDetailsCard(
                        iconPath: org,
                        title: "Your Details",
                        subtitle: 'Add your business details',
                        isCompleted: false,
                        isScreenNull: false,
                        screen: BusinessDetailScreen(
                          businessControllers: BusinessControllers(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InvoiceDetailsCard(
                        iconPath: addAccount,
                        title: "Invoice to",
                        subtitle: 'add payer',
                        isCompleted: false,
                        isScreenNull: false,
                        screen: NewPayerScreen(
                          customerController: CustomerControllers(),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InvoiceDetailsCard(
                        iconPath: addToCart,
                        title: "Items",
                        subtitle: 'add items to your invoice',
                        isCompleted: false,
                        isScreenNull: false,
                        screen: const AddItemScreen(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InvoiceDetailsCard(
                        iconPath: payment,
                        title: "Payment",
                        subtitle: 'add payment instructions',
                        isCompleted: false,
                        isDialog: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InvoiceDetailsCard(
                        iconPath: signature,
                        title: "Signature",
                        subtitle: 'add your Signature',
                        isCompleted: false,
                        isScreenNull: false,
                        screen: const SignatureScreen(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const CustomFilledButton(title: "Preview"),
                          CustomFilledButton(
                            title: "Save",
                            onPressed: () {
                              Invoice? invoice =
                                  context.read<InvoiceCubit>().getInvoice();
                              print("Invoice: $invoice");
                            },
                          )
                        ],
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
