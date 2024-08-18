import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/controllers/business_controllers.dart';
import 'package:quick_bill/controllers/customer_controllers.dart';
import 'package:quick_bill/model/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  StorageCubit() : super(StorageInitial());
  List<Item> itemList = [];
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

  void updateCustomerDetails(
    CustomerControllers controller,
    BuildContext context,
  ) {
    BusinessDetails business;
    try {
      if (controller.customerNameInputController.text.trim().isEmpty ||
          controller.customerEmailInputController.text.trim().isEmpty ||
          controller.customerPhoneInputController.text.trim().isEmpty ||
          controller.customerAddressInputController.text.trim().isEmpty) {
        // Show an error message using a dialog or snack bar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please input valid details'),
            duration: Duration(seconds: 1),
          ),
        );
      } else {
        final customer = Customer(
            address: controller.customerAddressInputController.text,
            email: controller.customerEmailInputController.text,
            name: controller.customerNameInputController.text,
            phone: controller.customerPhoneInputController.text);
        saveCustomerDetails(customer);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveCustomerDetails(Customer details) async {
    try {
      emit(StorageSaving());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String businessJson = jsonEncode(details.toJson());
      await prefs.setString('customer_details', businessJson);
      emit(CustomerDetailsSaved(details: details));
    } catch (e) {
      emit(StorageError(message: "Failed to save customer details"));
    }
  }

  Future<void> loadCustomerDetails() async {
    try {
      emit(StorageLoading());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? customerJson = prefs.getString('customer_details');
      if (customerJson != null) {
        Customer details = Customer.fromJson(jsonDecode(customerJson));
        print("Customer details: $details");
        emit(CustomerDetailsSaved(details: details));
      } else {
        emit(StorageEmpty());
      }
    } catch (e) {
      emit(StorageError(message: "Failed to load business details"));
    }
  }

  void addItem(Item item) async {
    itemList.add(item);
    // Save the updated list to SharedPreferences
    await _saveItemListToPreferences();
    emit(ItemAdded(item: List.from(itemList))); // Emit the updated list
  }

  void removeItem(Item item) async {
    itemList.remove(item);
    // Save the updated list to SharedPreferences
    await _saveItemListToPreferences();

    if (List.from(itemList).isEmpty) {
      emit(ItemListCleared());
    } else {
      emit(ItemRemoved(item: List.from(itemList)));
    } // Emit the updated list
  }

  Future<void> _saveItemListToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the list of items to a list of JSON strings
    List<String> jsonStringList =
        itemList.map((item) => json.encode(item.toJson())).toList();
    // Save the JSON string list to SharedPreferences
    await prefs.setStringList('itemList', jsonStringList);
  }

  Future<void> loadItemListFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // Retrieve the list of JSON strings from SharedPreferences
    List<String>? jsonStringList = prefs.getStringList('itemList');
    if (jsonStringList != null) {
      itemList = jsonStringList
          .map((jsonString) => Item.fromJson(json.decode(jsonString)))
          .toList();
      print("ItemClearedList loaded:${List.from(itemList)}");
      if (List.from(itemList).isEmpty) {
        emit(ItemListCleared());
      } else {
        emit(ItemLoaded(item: List.from(itemList)));
      } // Emit the loaded list
    }
  }

  Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('itemList');
    await prefs
        .remove('business_details'); // Remove the list from SharedPreferences
    itemList.clear(); // Clear the local list
    await prefs.remove('customer_details');
    await prefs.remove('payment_instructions');
    emit(StorageEmpty());
  }

  Future<void> clearItemList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('itemList'); // Remove the list from SharedPreferences
    itemList.clear(); // Clear the local list
    emit(ItemCleared());
  }

  void updatePaymentInstructions(
      String paymentInstructions, BuildContext context) async {
    if (paymentInstructions.isEmpty) {
      emit(InvalidPaymentInstructions(
        isValid: false,
      ));
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("payment_instructions", paymentInstructions);
      emit(PaymentInstructionsUpdated());
      Navigator.pop(context);
    }
  }

  void loadPaymentInstructions() async {
    final prefs = await SharedPreferences.getInstance();
    final payment = prefs.getString("payment_instructions");
    if (payment != null) {
      emit(PaymentInstructionsLoaded(
        paymentInstructions: payment,
      ));
    } else {
      emit(NoPaymentInstructions());
    }
  }
}
