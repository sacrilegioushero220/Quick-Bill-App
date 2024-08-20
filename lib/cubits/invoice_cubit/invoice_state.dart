import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quick_bill/model/models.dart';

@immutable
sealed class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

final class InvoiceData extends InvoiceState {
  final String invoiceId;
  final String date;
  final BusinessDetails? businessDetails;
  final Customer? payerDetails;
  final List<Item>? items;
  final String? paymentInstructions;
  final ByteData? signature;

  InvoiceData({
    required this.invoiceId,
    required this.date,
    this.businessDetails,
    this.payerDetails,
    this.items,
    this.paymentInstructions,
    this.signature,
  });
  @override
  String toString() {
    return 'InvoiceData(invoiceId: $invoiceId, date: $date, businessDetails: $businessDetails, payerDetails: $payerDetails, items: $items, paymentInstructions: $paymentInstructions, signature: $signature,)';
  }
}

final class InvoiceLoaded extends InvoiceState {
  final List<Invoice> invoiceList;

  InvoiceLoaded({required this.invoiceList});
}

final class NoInvoiceGenerated extends InvoiceState {}

final class InvoiceAdded extends InvoiceState {
  final List<Invoice> invoiceList;

  InvoiceAdded({required this.invoiceList});
}
