import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/constants/string_constants.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(),
    ),
    backgroundColor: const Color.fromARGB(255, 27, 50, 140),
    toolbarHeight: 70,
    centerTitle: true,
    leading: Padding(
      padding: const EdgeInsets.all(17),
      child: SvgPicture.asset(squareLogo),
    ),
    title: FittedBox(
      fit:
          BoxFit.scaleDown, // Scale down the text to fit within available space
      child: Text(
        "My Invoices",
        textAlign: TextAlign.center,
        style: GoogleFonts.beVietnamPro(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),
  );
}
