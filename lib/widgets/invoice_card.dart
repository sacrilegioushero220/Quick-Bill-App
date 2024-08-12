import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InvoiceCard extends StatelessWidget {
  const InvoiceCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "INVOICE ID  #103445676775",
              style: GoogleFonts.beVietnamPro(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "Created on 2022-03-11",
              style: GoogleFonts.beVietnamPro(
                  fontSize: 16, color: const Color.fromARGB(145, 0, 0, 0)),
            ),
          ],
        ),
      ),
    );
  }
}
