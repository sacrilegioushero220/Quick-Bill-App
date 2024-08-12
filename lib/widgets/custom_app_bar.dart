import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/constants/string_constants.dart';

PreferredSizeWidget customAppBar() {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.99, -0.15),
          end: Alignment(-0.99, 0.15),
          colors: [
            Color.fromARGB(255, 28, 65, 146),
            Color(0xff00aeef),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
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
        "JEEVANS DIABETES & ENDOCRINOLOGY",
        textAlign: TextAlign.center,
        style: GoogleFonts.koulen(
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 21,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    ),
  );
}
