import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/widgets/custom_app_bar.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class NewInvoiceScreen extends StatelessWidget {
  const NewInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar("New Invoice", isHome: false),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const InvoiceCard(),
                const SizedBox(
                  height: 15,
                ),
                InvoiceDetailsCard(
                  iconPath: org,
                  title: "Your Details",
                  subtitle: 'Add your business details',
                  isCompleted: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
