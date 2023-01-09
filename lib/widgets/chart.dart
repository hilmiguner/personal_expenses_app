import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalAmount = 0;

      for (var transaction in recentTransactions) {
        if (DateFormat.E().format(transaction.date) ==
            DateFormat.E().format(weekDay)) {
          totalAmount += transaction.amount;
        }
      }

      return {"day": DateFormat.E().format(weekDay), "amount": totalAmount};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: groupedTransactionValues.map((transaction) {
          return Column(
            children: [
              Text(transaction["day"].toString()),
              Text(transaction["amount"].toString()),
            ],
          );
        }).toList(),
      ),
    );
  }
}
