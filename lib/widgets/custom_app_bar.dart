import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';

PreferredSizeWidget customAppBar(
  String title,
  BuildContext context, {
  bool isHome = true,
  bool clearItemList = false,
}) {
  return AppBar(
    flexibleSpace: Container(
      decoration: const BoxDecoration(),
    ),
    backgroundColor: const Color.fromARGB(255, 27, 50, 140),
    toolbarHeight: 70,
    centerTitle: true,
    leading: Padding(
      padding: isHome ? const EdgeInsets.all(17) : const EdgeInsets.all(0),
      child: isHome
          ? SvgPicture.asset(squareLogo)
          : IconButton(
              onPressed: () {
                clearItemList
                    ? BlocProvider.of<StorageCubit>(context).clearStorage()
                    : const SizedBox();
                Navigator.pop(context);
              },
              icon: Image.asset(rightArrow),
            ),
    ),
    title: FittedBox(
      fit:
          BoxFit.scaleDown, // Scale down the text to fit within available space
      child: Text(
        title,
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
