import 'package:flutter/material.dart';
import 'custom_text_field.dart'; // Import the original CustomTextField

class ValidatedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool isValid;
  final String? errorMessage;

  const ValidatedTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    required this.isValid,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: isValid ? Colors.grey : Colors.red,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomTextField(
            controller: controller,
            hintText: hintText,
            keyboardType: keyboardType,
          ),
        ),
        if (!isValid && errorMessage != null)
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 10.0),
            child: Text(
              errorMessage!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12.0,
              ),
            ),
          ),
      ],
    );
  }
}
