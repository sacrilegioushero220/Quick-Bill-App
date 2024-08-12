import 'package:flutter/material.dart';
import 'package:quick_bill/Screens/home_screen.dart';
import 'package:quick_bill/constants/string_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0x0019318a),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(splashBg),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            height: 300,
            width: 300,
            logoMain,
          ),
        ),
      ),
    );
  }
}
