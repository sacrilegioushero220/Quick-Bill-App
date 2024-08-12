import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/custom_app_bar.dart';

class NewInvoiceScreen extends StatelessWidget {
  const NewInvoiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("New Invoice", isHome: false),
    );
  }
}
