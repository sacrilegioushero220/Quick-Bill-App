import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick_bill/Cubits/invoice_cubit/invoice_cubit.dart';
import 'package:quick_bill/Screens/home_screen.dart';
import 'package:quick_bill/cubits/storage_cubit/storage_cubit.dart';
import 'package:quick_bill/widgets/custom_widgets.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

class SignatureScreen extends StatelessWidget {
  const SignatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 220, 220),
      appBar: customAppBar(
        "Add your signature",
        context,
        isHome: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 400,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: SfSignaturePad(
                  key: _signaturePadKey,
                  minimumStrokeWidth: 2,
                  maximumStrokeWidth: 4,
                  strokeColor: Colors.black,
                  backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomFilledButton(
                    title: "clear",
                    onPressed: () {
                      _signaturePadKey.currentState!.clear();
                    },
                  ),
                  CustomFilledButton(
                    title: "Save",
                    onPressed: () async {
                      ui.Image image =
                          await _signaturePadKey.currentState!.toImage();
                      final pngBytes = await image.toByteData(
                          format: ui.ImageByteFormat.png);
                      context.read<StorageCubit>().updateSignature(
                            pngBytes!,
                            context,
                          );
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
