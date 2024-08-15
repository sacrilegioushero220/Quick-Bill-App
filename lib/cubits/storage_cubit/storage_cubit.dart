import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/controllers/business_controllers.dart';
import 'package:quick_bill/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit() : super(StorageInitial());

  void updateBusinessDetails(
    BusinessControllers controller,
    BuildContext context,
  ) {
    BusinessDetails business;
    try {
      if (controller.businessNameController.text.trim().isEmpty ||
          controller.businessEmailController.text.trim().isEmpty ||
          controller.businessPhoneController.text.trim().isEmpty ||
          controller.businessAddressController.text.trim().isEmpty) {
        // Show an error message using a dialog or snack bar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please input valid details'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        business = BusinessDetails(
          name: controller.businessNameController.text,
          address: controller.businessAddressController.text,
          phone: controller.businessPhoneController.text,
          email: controller.businessEmailController.text,
          website: controller.businessWebsiteController.text,
          logo: '', // Add logo handling logic
        );
        saveBusinessDetails(business);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveBusinessDetails(BusinessDetails details) async {
    try {
      emit(StorageSaving());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String businessJson = jsonEncode(details.toJson());
      await prefs.setString('business_details', businessJson);
      emit(BusinessDetailsSaved(details: details));
    } catch (e) {
      emit(StorageError(message: "Failed to save business details"));
    }
  }

  Future<void> loadBusinessDetails() async {
    try {
      emit(StorageLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? businessJson = prefs.getString('business_details');
      if (businessJson != null) {
        BusinessDetails details =
            BusinessDetails.fromJson(jsonDecode(businessJson));
        print("Business details: $details");
        emit(BusinessDetailsSaved(details: details));
      } else {
        emit(StorageEmpty());
      }
    } catch (e) {
      emit(StorageError(message: "Failed to load business details"));
    }
  }
}
