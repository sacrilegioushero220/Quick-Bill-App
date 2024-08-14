import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class NewPayerScreen extends StatelessWidget {
  const NewPayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
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
                controller: controller,
                hintText: "Payer Name*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controller,
                hintText: "Phone number*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: controller,
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
                    onPressed: () {},
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
