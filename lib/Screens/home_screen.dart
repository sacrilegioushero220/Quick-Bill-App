import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Screens/custom_screens.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/cubits/invoice_cubit/invoice_state.dart';
import 'package:quick_bill/model/invoice_model.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<InvoiceCubit>(context).loadInvoiceList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Invoice> invoiceList;
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const NewInvoiceScreen()));
        },
        backgroundColor: const Color.fromARGB(255, 27, 50, 140),
        child: Image.asset(
          addPageIcon,
        ),
      ),
      appBar: customAppBar(
        "My Invoices",
        context,
      ),
      body: BlocConsumer<InvoiceCubit, InvoiceState>(
        listener: (context, state) {
          if (state is InvoiceLoaded) {
            invoiceList = state.invoiceList;
          }
        },
        builder: (context, state) {
          if (state is InvoiceLoaded) {
            invoiceList = state.invoiceList;

            return SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 20,
                ),
                child: ListView.builder(
                  itemCount: invoiceList.length,
                  itemBuilder: (context, index) {
                    final invoice = invoiceList[index];
                    return InvoiceListCard(
                      invoiceID: invoice.id,
                      clientName: invoice.to.name,
                      date: invoice.date,
                      onTap: () async {
                        context.read<InvoiceCubit>().previewInvoice(
                              context: context,
                              invoice: invoice,
                            );
                      },
                    );
                  },
                ),
              ),
            );
          }

          return const Center(
            child: Text("No Invoice generated"),
          );
        },
      ),
    );
  }
}
