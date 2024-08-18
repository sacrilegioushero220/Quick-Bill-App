import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/controllers/business_controllers.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
import 'package:quick_bill/model/models.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class BusinessDetailScreen extends StatefulWidget {
  const BusinessDetailScreen({
    super.key,
    required this.businessControllers,
  });

  final BusinessControllers businessControllers;

  @override
  State<BusinessDetailScreen> createState() => _BusinessDetailScreenState();
}

class _BusinessDetailScreenState extends State<BusinessDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<StorageCubit>(context).loadBusinessDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar(
        "New Business ",
        context,
        isHome: false,
      ),
      body: BlocListener<StorageCubit, StorageState>(
        listener: (context, state) {
          print("Current state in business detail scren:$state");
          if (state is StorageError) {
            // Handle errors here if needed
          }
          if (state is BusinessDetailsSaved) {}
        },
        child: BlocBuilder<StorageCubit, StorageState>(
          builder: (context, state) {
            if (state is StorageLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BusinessDetailsSaved) {
              final businessDetails = state.details;
              final controller = widget.businessControllers;
              controller.businessNameController.text = businessDetails.name;
              controller.businessEmailController.text = businessDetails.email;
              controller.businessPhoneController.text = businessDetails.phone;
              controller.businessWebsiteController.text =
                  businessDetails.website ?? "null is returned";
              controller.businessAddressController.text =
                  businessDetails.address;

              // The text controllers are already updated in the cubit
            }

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller:
                          widget.businessControllers.businessNameController,
                      hintText: "Business Name*",
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller:
                          widget.businessControllers.businessEmailController,
                      hintText: "Email Address*",
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller:
                          widget.businessControllers.businessPhoneController,
                      hintText: "Phone number*",
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller:
                          widget.businessControllers.businessWebsiteController,
                      hintText: "Website",
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      controller:
                          widget.businessControllers.businessAddressController,
                      hintText: "Address*",
                      isBigField: true,
                    ),
                    const SizedBox(height: 50),
                    BlocBuilder<StorageCubit, StorageState>(
                      builder: (context, state) {
                        if (state is ImagePicked) {
                          return GestureDetector(
                            onTap: () {
                              context.read<StorageCubit>().pickAndSaveImage();
                            },
                            child: Container(
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
                              child: Image.file(File(state.logoPath)),
                            ),
                          );
                        }
                        if (state is BusinessDetailsSaved) {
                          final logoPath = state.details.logo;
                          return GestureDetector(
                            onTap: () {
                              context.read<StorageCubit>().pickAndSaveImage();
                            },
                            child: Container(
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
                              child: Image.file(File(logoPath)),
                            ),
                          );
                        }
                        return AddLogoWidget(
                          onTap: () {
                            context.read<StorageCubit>().pickAndSaveImage();
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(width: 20),
                        CustomFilledButton(
                          title: 'Save',
                          onPressed: () {
                            context.read<StorageCubit>().updateBusinessDetails(
                                  widget.businessControllers,
                                  context,
                                );
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
