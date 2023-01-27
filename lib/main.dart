import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:personal_expenses_app/widgets/new_transaction.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:personal_expenses_app/widgets/chart.dart';

void main() {
  /* -------NO LANDSCAPE MODE-------
  WidgetsFlutterBinding.ensureInitialized();

  final List<DeviceOrientation> prefferedOrientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ];
  SystemChrome.setPreferredOrientations(prefferedOrientations); */

  runApp(MyApp());
}

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
          button: TextStyle(
            color: Colors.white,
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
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where(
      (transaction) {
        return transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7)));
      },
    ).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(String title, double amount, DateTime date) {
    List<String> splittedList = amount.toString().split(".");
    String startPart = splittedList[0];
    if (splittedList[1].length > 2) {
      String endPart = splittedList[1].substring(0, 2);
      amount = double.parse(startPart + "." + endPart);
    }
    final newTx = Transaction(title: title, amount: amount, date: date);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _showNewTransactionInputs(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: ((bCtx) {
        return NewTransaction(_addNewTransaction);
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: GestureDetector(
              onTap: () => _showNewTransactionInputs(context),
              child: Icon(CupertinoIcons.add),
            ),
          )
        : AppBar(
            actions: [
              IconButton(
                onPressed: () => _showNewTransactionInputs(context),
                icon: Icon(Icons.add),
              ),
            ],
            title: Text('Personal Expenses'),
          );
    final chartWidgetLandscape = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: Chart(_recentTransactions),
    );
    final chartWidgetPortrait = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom) *
          0.3,
      child: Chart(_recentTransactions),
    );
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top -
              mediaQuery.padding.bottom) *
          0.7,
      child: TransactionList(_userTransactions, _deleteTransaction),
    );
    final scaffoldBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Show Chart",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Switch.adaptive(
                    activeColor: Theme.of(context).primaryColor,
                    value: _showChart,
                    onChanged: (value) {
                      setState(() {
                        _showChart = value;
                      });
                    },
                  )
                ],
              ),
            if (isLandscape) _showChart ? chartWidgetLandscape : txListWidget,
            if (!isLandscape) chartWidgetPortrait,
            if (!isLandscape) txListWidget,
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: scaffoldBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: scaffoldBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? null
                : FloatingActionButton(
                    onPressed: () => _showNewTransactionInputs(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
