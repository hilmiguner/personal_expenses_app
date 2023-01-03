import 'package:flutter/material.dart';

class Transaction {
  static String lastID = "t0";
  String id;
  final String title;
  final double amount;
  final DateTime date;

  Transaction(
      {@required this.title, @required this.amount, @required this.date}) {
    this.id =
        "t" + ((int.parse(Transaction.lastID.split("t").last) + 1).toString());
    Transaction.lastID = this.id;
  }
}
