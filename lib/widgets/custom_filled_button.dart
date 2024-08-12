import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const CustomFilledButton({super.key, required this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
            const Color.fromARGB(255, 27, 50, 140)),
      ),
      onPressed: onPressed,
      child: Text(title),
    );
  }
}
