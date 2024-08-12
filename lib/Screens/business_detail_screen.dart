import 'package:flutter/material.dart';
import 'package:quick_bill/widgets/custom_app_bar.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class BusinessDetailScreen extends StatelessWidget {
  const BusinessDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar(
        "New Business ",
        context,
        isHome: false,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Business Name*",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Email Address*",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Phone number*",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Website",
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                hintText: "Address*",
                isBigField: true,
              ),
              SizedBox(
                height: 50,
              ),
              AddLogoWidget(),
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CustomFilledButton(title: 'Save')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AddLogoWidget extends StatelessWidget {
  const AddLogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 27, 50, 140),
          width: 2.0,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 24.0,
            color: Colors.black,
          ),
          SizedBox(height: 8.0),
          Text(
            'Add your logo',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
