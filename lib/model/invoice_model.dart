import 'package:flutter/services.dart';

import 'models.dart';
import 'package:flutter/services.dart';

class Invoice {
  String id;
  String date;
  BusinessDetails from;
  Customer to;
  List<Item> items;
  String paymentInstructions;
  double total;
  ByteData signature;

  Invoice({
    required this.id,
    required this.date,
    required this.from,
    required this.to,
    required this.items,
    required this.paymentInstructions,
    required this.total,
    required this.signature,
  });

  // JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'from': from.toJson(),
      'to': to.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
      'paymentInstructions': paymentInstructions,
      'total': total,
      'signature': signature.buffer.asUint8List(),
    };
  }

  // JSON deserialization
  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      id: json['id'],
      date: json['date'],
      from: BusinessDetails.fromJson(json['from']),
      to: Customer.fromJson(json['to']),
      items: (json['items'] as List<dynamic>)
          .map((item) => Item.fromJson(item))
          .toList(),
      paymentInstructions: json['paymentInstructions'],
      total: json['total'],
      signature: ByteData.sublistView(Uint8List.fromList(json['signature'])),
    );
  }
}
