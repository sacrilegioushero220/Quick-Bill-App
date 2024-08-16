import 'package:flutter/material.dart';

import 'package:quick_bill/model/business_details.dart';

class BusinessControllers {
  final TextEditingController businessNameController = TextEditingController();
  final TextEditingController businessEmailController = TextEditingController();
  final TextEditingController businessPhoneController = TextEditingController();
  final TextEditingController businessAddressController =
      TextEditingController();
  final TextEditingController businessWebsiteController =
      TextEditingController();
  BusinessDetails? business;

  // Clear controllers when done
  void clearControllers() {
    businessNameController.clear();
    businessEmailController.clear();
    businessPhoneController.clear();
    businessAddressController.clear();
    businessWebsiteController.clear();
  }

  Future<void> dispose() {
    businessNameController.dispose();
    businessEmailController.dispose();
    businessPhoneController.dispose();
    businessAddressController.dispose();
    businessWebsiteController.dispose();
    return dispose();
  }
}
