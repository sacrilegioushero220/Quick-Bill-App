import 'package:flutter/material.dart';
import 'package:quick_bill/model/customer_model.dart';

class CustomerControllers {
  Customer? customer;
  TextEditingController customerNameInputController = TextEditingController();
  TextEditingController customerEmailInputController = TextEditingController();
  TextEditingController customerPhoneInputController = TextEditingController();
  TextEditingController customerAddressInputController =
      TextEditingController();
  // validate input

  void onClose() {
    if (customer != null) {
      customerAddressInputController.clear();
      customerEmailInputController.clear();
      customerNameInputController.clear();
      customerPhoneInputController.clear();
    }
    onClose();
  }
}
