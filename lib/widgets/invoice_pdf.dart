import 'dart:typed_data';
import 'dart:io'; // For loading the file from a path
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:quick_bill/model/invoice_model.dart';

class InvoicePdf {
  static Future<Uint8List> generate(Invoice invoice) async {
    final pdf = pw.Document();
    final headers = ['Description', 'Quantity', 'Price per item', 'Total'];
    final titles = <String>['Invoice No:', 'Invoice Date:', 'Due Date:'];
    final invoiceData = invoice.items.map((item) => item.toList()).toList();

    final data = <String>[
      invoice.id,
      invoice.date,
      invoice.date,
      "266",
    ];

    // Load the logo from file if the path is not null
    Uint8List? logoBytes;
    if (invoice.from.logo != "Null") {
      final File logoFile = File(invoice.from.logo);
      logoBytes = await logoFile.readAsBytes();
    }

    pdf.addPage(pw.MultiPage(
      header: (context) => pw.Text("INVOICE ID ${invoice.id}",
          style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold)),
      build: (context) => [
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: 1 * PdfPageFormat.cm),
                    (logoBytes != null)
                        ? pw.Image(pw.MemoryImage(logoBytes),
                            height: 80, width: 80)
                        : pw.Text(""),
                    pw.SizedBox(height: 1 * PdfPageFormat.cm),
                    pw.Text(invoice.from.name,
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                    pw.Text(invoice.from.address),
                  ],
                ),
                pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data: invoice.id,
                  height: 80,
                  width: 80,
                ),
              ],
            ),
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
            pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Container(
                    width: 200,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(invoice.to.name,
                              textAlign: TextAlign.left,
                              style:
                                  pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                          pw.Text(
                            invoice.to.address,
                          ),
                        ]),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(titles.length, (index) {
                      final title = titles[index];
                      final value = data[index];

                      return buildText(title: title, value: value, width: 200);
                    }),
                  ),
                ]),
            pw.SizedBox(height: 3 * PdfPageFormat.cm),
            pw.Text('Invoice details', style: const pw.TextStyle(fontSize: 18)),
            pw.SizedBox(height: 1 * PdfPageFormat.cm),
            pw.TableHelper.fromTextArray(
              border: null,
              headers: headers,
              data: invoiceData,
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
            ),
            pw.Divider(),
            pw.Container(
              alignment: pw.Alignment.centerRight,
              child: pw.Row(
                children: [
                  pw.Spacer(flex: 6),
                  pw.Expanded(
                    flex: 4,
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        buildText(
                          title: 'Total amount',
                          titleStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          value: "Rs:${invoice.total} /-",
                          unite: true,
                        ),
                        SizedBox(height: 2 * PdfPageFormat.mm),
                        Container(height: 1, color: PdfColors.grey400),
                        SizedBox(height: 0.5 * PdfPageFormat.mm),
                        Container(height: 1, color: PdfColors.grey400),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 3 * PdfPageFormat.mm),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.start,
                  children: [
                    pw.Text("Payment Instructions",
                        style: const pw.TextStyle(fontSize: 18)),
                    pw.SizedBox(height: 10),
                    pw.Text(
                      invoice.paymentInstructions,
                    ),
                  ],
                ),
                pw.Image(
                    pw.MemoryImage(invoice.signature.buffer.asUint8List(
                        invoice.signature.offsetInBytes,
                        invoice.signature.lengthInBytes)),
                    height: 80),
              ],
            ),
          ],
        ),
      ],
      footer: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.center,
        children: [
          pw.Divider(),
          pw.Text(invoice.from.address),
          pw.Text("email: ${invoice.from.email} / tel: ${invoice.from.phone}"),
        ],
      ),
    ));
    return await pdf.save();
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
