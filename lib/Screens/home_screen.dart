import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/widgets/custom_app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.large(
        onPressed: () {},
        backgroundColor: const Color.fromARGB(255, 27, 50, 140),
        child: Image.asset(
          addPageIcon,
        ),
      ),
      appBar: customAppBar(),
      body: const Center(
        child: Text("No Invoice generated"),
      ),
    );
  }
}
