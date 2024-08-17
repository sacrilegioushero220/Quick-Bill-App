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
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
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
          clearItemList: true,
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
                  bool isCompleted1 = false;
                  bool isCompleted2 = false;
                  bool isCompleted3 = false;
                  bool isCompleted4 = false;
                  bool isCompleted5 = false;

                  String invoiceId = 'N/A';
                  String dateNow = 'N/A';
                  print("Current state is : $state");
                  if (state is InvoiceData) {
                    invoiceId = state.invoiceId;
                    dateNow = state.date;
                  }

                  return BlocConsumer<StorageCubit, StorageState>(
                    listener: (context, state) {
                      if (state is BusinessDetailsSaved) {
                        isCompleted1 = true;
                      } else if (state is CustomerDetailsSaved) {
                        isCompleted2 = true;
                      }
                      if (state is ItemLoaded || state is ItemAdded) {
                        isCompleted3 = true;
                      } else if (state is ItemCleared) {
                        isCompleted3 = false;
                      }
                      if (state is ItemListCleared) {
                        isCompleted3 = false;
                      }
                    },
                    builder: (context, state) {
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
                            isCompleted: isCompleted1,
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
                            isCompleted: isCompleted2,
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
                            isCompleted: isCompleted3,
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
                                onPressed: () async {
                                  context
                                      .read<StorageCubit>()
                                      .loadBusinessDetails();
                                },
                              )
                            ],
                          ),
                        ],
                      );
                    },
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
