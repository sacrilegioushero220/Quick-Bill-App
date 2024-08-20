import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:quick_bill/widgets/custom_app_bar.dart';

class PdfPreviewScreen extends StatelessWidget {
  final String path;

  const PdfPreviewScreen({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        "Invoice Preview",
        context,
        isHome: false,
      ),
      body: PDFView(
        filePath: path,
      ),
    );
  }
}
