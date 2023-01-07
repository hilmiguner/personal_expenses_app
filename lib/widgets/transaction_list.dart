import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  TransactionList(this._userTransactions);

  final List<Transaction> _userTransactions;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 775,
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
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                      padding: EdgeInsets.symmetric(vertical: 10),
                      constraints: BoxConstraints(maxWidth: 150),
                      alignment: Alignment.center,
                      child: Text(
                        "\$${_userTransactions[index].amount}",
                        style: Theme.of(context).textTheme.headline6.apply(
                            color: Theme.of(context).primaryColor,
                            fontSizeDelta: 5),
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userTransactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat.yMMMMd()
                                .format(_userTransactions[index].date),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .apply(color: Colors.grey),
                          )
                        ],
                      ),
                    ),
                  ],
                ));
              }),
              itemCount: _userTransactions.length,
            ),
    );
  }
}
