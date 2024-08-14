import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/controllers/business_controllers.dart';
import 'package:quick_bill/model/models.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class BusinessDetailScreen extends StatelessWidget {
  const BusinessDetailScreen({
    super.key,
    required this.businessControllers,
  });

  final BusinessControllers businessControllers;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar(
        "New Business ",
        context,
        isHome: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: businessControllers.businessNameController,
                hintText: "Business Name*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: businessControllers.businessEmailController,
                hintText: "Email Address*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: businessControllers.businessPhoneController,
                hintText: "Phone number*",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: businessControllers.businessWebsiteController,
                hintText: "Website",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextField(
                controller: businessControllers.businessAddressController,
                hintText: "Address*",
                isBigField: true,
              ),
              const SizedBox(
                height: 50,
              ),
              const AddLogoWidget(),
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
                      BlocProvider.of<InvoiceCubit>(context)
                          .updateBusinessDetails(
                        businessControllers,
                        context,
                      );
                    },
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
