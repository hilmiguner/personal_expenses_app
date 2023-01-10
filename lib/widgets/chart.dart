import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart_bar.dart';

import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  double get getTotalAmountOfWeek {
    return groupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + element["amount"];
    });
  }

  List<Map<String, Object>> get groupedTransactionValues {
    List tempList = List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalAmount = 0;

      for (var transaction in recentTransactions) {
        if (DateFormat.E().format(transaction.date) ==
            DateFormat.E().format(weekDay)) {
          totalAmount += transaction.amount;
        }
      }

      return {
        "day": DateFormat.E().format(weekDay),
        "amount": totalAmount == 0 ? 0.0 : totalAmount
      };
    }).reversed.toList();
    var lastItem = tempList.last;
    tempList = tempList.getRange(0, tempList.length - 1).toList();
    tempList.insert(0, lastItem);
    return tempList;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((transaction) {
            String day = transaction["day"];
            double amount = transaction["amount"] as double;
            double percentage = getTotalAmountOfWeek == 0
                ? 0.0
                : (amount / getTotalAmountOfWeek);
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(day, amount, percentage),
            );
          }).toList(),
        ),
      ),
    );
  }
}
