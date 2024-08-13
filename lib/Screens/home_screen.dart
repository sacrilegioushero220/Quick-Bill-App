import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/Screens/custom_screens.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: const Center(
        child: Text("No Invoice generated"),
      ),
    );
  }
}
