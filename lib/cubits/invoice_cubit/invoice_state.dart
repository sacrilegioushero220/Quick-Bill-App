part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState {}

class InvoiceInitial extends InvoiceState {}

class InvoiceData extends InvoiceState {
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
