import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isBigField;
  final TextEditingController controller;
  const CustomTextField(
      {super.key,
      required this.hintText,
      this.isBigField = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: isBigField ? 4 : 1,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFEFEFEF), // Light gray background
        contentPadding: const EdgeInsets.only(top: 20, left: 16, bottom: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // More rounded corners
          borderSide: BorderSide.none, // No border to match the design
        ),
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 125, 123, 123),
          fontSize: 16,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
