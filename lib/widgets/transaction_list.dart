import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this._userTransactions);

  final List<Transaction> _userTransactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: _userTransactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Transactions",
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Image.asset("assets/images/waiting.png"),
                  height: 70,
                )
              ],
            )
          : ListView.builder(
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text("\$${_userTransactions[index].amount}"),
                        ),
                      ),
                    ),
                    title: Text(
                      "${_userTransactions[index].title}",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      "${DateFormat("dd.MM.yyyy").format(_userTransactions[index].date)}",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    trailing: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 30,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).secondaryHeaderColor,
                        ),
                      ),
                    ),
                  ),
                );
              }),
              itemCount: _userTransactions.length,
            ),
    );
  }
}
