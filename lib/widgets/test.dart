import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

// class TestClass {
//   final List<Transaction> recentTransactions;

//   TestClass(this.recentTransactions);

//   List<Map<String, Object>> get groupedTransactionValues {
//     return List.generate(7, (index) {
//       final weekDay = DateTime.now().subtract(Duration(days: index));

//       double totalAmount = 0;

//       for (var transaction in recentTransactions) {
//         if (DateFormat.E(weekDay) == DateFormat.E(transaction.date)) {
//           totalAmount += transaction.amount;
//         }
//       }

//       return {"day": DateFormat.E(weekDay), "amount": totalAmount};
//     });
//   }
// }

void main(List<String> args) {
  final List<Transaction> _userTransactions = [
    Transaction(title: "New Shoes", amount: 69.99, date: DateTime.now()),
    Transaction(title: "Weekly Groceries", amount: 16.53, date: DateTime.now())
  ];
  var obj = DateFormat.E();
  print(obj.toString());
}
