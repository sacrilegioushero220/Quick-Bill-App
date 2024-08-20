import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quick_bill/constants/string_constants.dart';
import 'package:quick_bill/cubits/invoice_cubit/invoice_cubit.dart';

class InvoiceListCard extends StatelessWidget {
  final String invoiceID;
  final String clientName;
  final String date;
  final void Function()? onTap;

  const InvoiceListCard({
    super.key,
    required this.invoiceID,
    required this.clientName,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
            color: const Color.fromARGB(255, 27, 50, 140),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 30,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Invoice ID: $invoiceID",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        clientName,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      download,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
