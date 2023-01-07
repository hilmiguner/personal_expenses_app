import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/models/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: "Quicksand",
        textTheme: TextTheme(
          headline6: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          headline1: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
          ),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(title: "New Shoes", amount: 69.99, date: DateTime.now()),
    // Transaction(title: "Weekly Groceries", amount: 16.53, date: DateTime.now())
  ];

  void _addNewTransaction(String title, double amount, BuildContext bCtx) {
    List<String> splittedList = amount.toString().split(".");
    String startPart = splittedList[0];
    if (splittedList[1].length > 2) {
      String endPart = splittedList[1].substring(0, 2);
      amount = double.parse(startPart + "." + endPart);
    }
    final newTx =
        Transaction(title: title, amount: amount, date: DateTime.now());
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _showNewTransactionInputs(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: ((bCtx) {
        return NewTransaction(_addNewTransaction, bCtx);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => _showNewTransactionInputs(context),
            icon: Icon(Icons.add),
          ),
        ],
        title: Text('Personal Expenses'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Text("CHART!"),
            ),
            TransactionList(_userTransactions),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showNewTransactionInputs(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
