import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quick_bill/Screens/pdf_preview_screen.dart';
import 'package:quick_bill/cubits/invoice_cubit/invoice_state.dart';
import 'package:quick_bill/model/models.dart';
import 'package:quick_bill/widgets/invoice_pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());
  List<Invoice> invoiceList = [];

  void createInvoice() async {
    final now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final String invoiceId =
        '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}';

    await prefs.setString("invoiceID", invoiceId);
    await prefs.setString("Date", formattedDate);
    emit(InvoiceData(
      invoiceId: invoiceId,
      date: formattedDate,
    ));
  }

  Future<Invoice?> createInvoiceData() async {
    final prefs = await SharedPreferences.getInstance();

//Fetch InvoiceID and Date
    final date = prefs.getString("Date");
    final invoiceId = prefs.getString("invoiceID");
    // Fetch Business Details
    final businessJson = prefs.getString('business_details');
    BusinessDetails? businessDetails;
    if (businessJson != null) {
      businessDetails = BusinessDetails.fromJson(jsonDecode(businessJson));
    }

    // Fetch Customer Details
    final customerJson = prefs.getString('customer_details');
    Customer? customerDetails;
    if (customerJson != null) {
      customerDetails = Customer.fromJson(jsonDecode(customerJson));
    }

    // Fetch Items Details
    List<String>? jsonStringList = prefs.getStringList('itemList');
    List<Item>? itemDetailsList;
    if (jsonStringList != null && jsonStringList.isNotEmpty) {
      itemDetailsList = jsonStringList
          .map((jsonString) => Item.fromJson(json.decode(jsonString)))
          .toList();
    }
    double calculateGrandTotal(List<Item> items) {
      return items.fold(0.0, (sum, item) => sum + (item.price * item.qty));
    }

    final total = calculateGrandTotal(itemDetailsList!);
    // Fetch Payment Details
    final paymentDetails = prefs.getString("payment_instructions");

    // Fetch Signature
    final String? base64String = prefs.getString('signature_image');
    Uint8List? signature;
    if (base64String != null) {
      signature = base64Decode(base64String);
    }

    // Check if all required data is fetched
    if (businessDetails != null &&
        customerDetails != null &&
        paymentDetails != null &&
        signature != null) {
      // Create and return an Invoice object
      return Invoice(
          id: invoiceId ?? "", // Replace with actual ID or generate one
          from: businessDetails,
          to: customerDetails,
          items: itemDetailsList,
          total: total, // Implement a method to calculate total
          paymentInstructions: paymentDetails,
          signature: signature,
          date: date ?? "");
    } else {
      return null; // Return null if any required data is missing
    }
  }

  void previewInvoice({
    required BuildContext context,
    required Invoice invoice,
  }) async {
    // final invoice = await
    print("Final Invoice:$invoice");
    File pdfFile = File('${(await getTemporaryDirectory()).path}/invoice.pdf');
    pdfFile.writeAsBytes(await InvoicePdf.generate(invoice));

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(path: pdfFile.path),
      ),
    );
  }

  void saveInvoiceDetails(BuildContext context) async {
    // Assuming `createInvoiceData()` is a method that creates the invoice data
    final invoice = await createInvoiceData();

    invoiceList.add(invoice!);
    // Save the updated list to SharedPreferences
    await _saveInvoiceListToPreferences();
    emit(InvoiceAdded(invoiceList: List.from(invoiceList)));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invoice Details are saved'),
        duration: Duration(seconds: 1),
      ),
    );
    Navigator.pop(context);
  }

  Future<void> _saveInvoiceListToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    // Convert the list of items to a list of JSON strings
    List<String> jsonStringList =
        invoiceList.map((invoice) => json.encode(invoice.toJson())).toList();
    // Save the JSON string list to SharedPreferences
    await prefs.setStringList('invoiceList', jsonStringList);
  }

  Future<void> loadInvoiceList() async {
    final prefs = await SharedPreferences.getInstance();
    //Retrieve the list of JSON strings from SharedPreferences
    List<String>? jsonStringList = prefs.getStringList('invoiceList');
    if (jsonStringList != null) {
      invoiceList = jsonStringList
          .map((jsonString) => Invoice.fromJson(json.decode(jsonString)))
          .toList();

      if (List.from(invoiceList).isEmpty) {
        emit(NoInvoiceGenerated());
      } else {
        print("invoiceList loaded: ${List.from(invoiceList)}");
        emit(InvoiceLoaded(invoiceList: List.from(invoiceList)));
      } // Emit the loaded list
    }
  }
}
