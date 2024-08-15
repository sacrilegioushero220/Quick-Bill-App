import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quick_bill/controllers/business_controllers.dart';
import 'package:quick_bill/controllers/customer_controllers.dart';
import 'package:quick_bill/model/models.dart';
part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  createInvoice() {
    final now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final String invoiceId =
        '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}';

    emit(InvoiceData(
      invoiceId: invoiceId,
      date: formattedDate,
    ));
  }

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
        final currentState = state;
        print("currentState: $currentState");
        print("Business details $business");
        if (currentState is InvoiceData) {
          emit(InvoiceData(
            invoiceId: currentState.invoiceId,
            date: currentState.date,
            businessDetails: business,
            payerDetails: currentState.payerDetails,
            items: currentState.items,
            paymentInstructions: currentState.paymentInstructions,
            signature: currentState.signature,
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void updatePayerDetails(
      BuildContext context, CustomerControllers controller) {
    Customer customer;
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
        customer = Customer(
            address: controller.customerAddressInputController.text,
            email: controller.customerEmailInputController.text,
            name: controller.customerNameInputController.text,
            phone: controller.customerPhoneInputController.text);
        final currentState = state;
        print("curren state is : $state");
        print("Customer details $customer");
        if (currentState is InvoiceData) {
          emit(InvoiceData(
            invoiceId: currentState.invoiceId,
            date: currentState.date,
            businessDetails: currentState.businessDetails,
            payerDetails: customer,
            items: currentState.items,
            paymentInstructions: currentState.paymentInstructions,
            signature: currentState.signature,
          ));
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void updateItems(List<Item> items) {
    final currentState = state;
    if (currentState is InvoiceData) {
      emit(InvoiceData(
        invoiceId: currentState.invoiceId,
        date: currentState.date,
        businessDetails: currentState.businessDetails,
        payerDetails: currentState.payerDetails,
        items: items,
        paymentInstructions: currentState.paymentInstructions,
        signature: currentState.signature,
      ));
    }
  }

  void updatePaymentInstructions(String paymentInstructions) {
    final currentState = state;
    if (currentState is InvoiceData) {
      emit(InvoiceData(
        invoiceId: currentState.invoiceId,
        date: currentState.date,
        businessDetails: currentState.businessDetails,
        payerDetails: currentState.payerDetails,
        items: currentState.items,
        paymentInstructions: paymentInstructions,
        signature: currentState.signature,
      ));
    }
  }

  void updateSignature(ByteData signature) {
    final currentState = state;
    if (currentState is InvoiceData) {
      emit(InvoiceData(
        invoiceId: currentState.invoiceId,
        date: currentState.date,
        businessDetails: currentState.businessDetails,
        payerDetails: currentState.payerDetails,
        items: currentState.items,
        paymentInstructions: currentState.paymentInstructions,
        signature: signature,
      ));
    }
  }

  Invoice? getInvoice() {
    final currentState = state;
    if (currentState is InvoiceData) {
      if (currentState.businessDetails != null &&
          currentState.payerDetails != null &&
          currentState.items != null &&
          currentState.paymentInstructions != null &&
          currentState.signature != null) {
        return Invoice(
          id: currentState.invoiceId,
          date: currentState.date,
          from: currentState.businessDetails!,
          to: currentState.payerDetails!,
          items: currentState.items!,
          paymentInstructions: currentState.paymentInstructions!,
          total: currentState.items!
              .fold(0, (sum, item) => sum + item.price * item.qty),
          signature: currentState.signature!,
        );
      }
    }
    return null; // Return null if the invoice is incomplete
  }
}
