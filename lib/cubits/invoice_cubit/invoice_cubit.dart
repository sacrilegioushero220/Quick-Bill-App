import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  InvoiceCubit() : super(InvoiceInitial());

  Map<String, String> createInvoice() {
    final now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);

    final String invoiceId =
        '${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.millisecond}';

    // Use this invoiceId for the new invoi
    print("Invoice Id: $invoiceId");
    return {
      "invoiceId": invoiceId,
      "date": formattedDate,
    };
  }
}
