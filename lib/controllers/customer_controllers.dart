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
  bool validate() {
    if (customerNameInputController.text.isEmpty ||
        customerEmailInputController.text.isEmpty ||
        customerPhoneInputController.text.isEmpty ||
        customerAddressInputController.text.isEmpty) {
      return false;
    } else {
      customer = Customer(
          address: customerAddressInputController.text,
          email: customerEmailInputController.text,
          name: customerNameInputController.text,
          phone: customerPhoneInputController.text);
      return true;
    }
  }

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
