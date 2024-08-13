import 'package:flutter/material.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class AddItemScreen extends StatelessWidget {
  const AddItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {
          showAddNewItemDialog(context);
        },
        backgroundColor: const Color.fromARGB(255, 27, 50, 140),
        child: Image.asset(
          addToCart,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar(
        "Add Items",
        context,
        isHome: false,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
