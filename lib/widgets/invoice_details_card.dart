import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/Screens/new_invoice_screen.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';

class InvoiceDetailsCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final bool isCompleted;
  final Widget? screen;
  final bool isScreenNull;
  final bool isDialog;
  const InvoiceDetailsCard({
    super.key,
    required this.iconPath,
    required this.title,
    required this.subtitle,
    this.isCompleted = false,
    this.screen,
    this.isScreenNull = true,
    this.isDialog = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isDialog
            ? showPaymentDialog(context)
            : isScreenNull
                ? null
                : Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => screen ?? const NewInvoiceScreen()));
      },
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              width: 1,
              color: Color(0xFFEBE0E2),
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 30.0,
            left: 30,
            right: 15,
            bottom: 30,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                    right: 20,
                  ),
                  child: Image.asset(iconPath)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.beVietnamPro(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.beVietnamPro(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(145, 0, 0, 0)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(),
                child: isCompleted
                    ? Image.asset(greenTick)
                    : Image.asset(leftArrow),
              )
            ],
          ),
        ),
      ),
    );
  }
}
