import "package:flutter/material.dart";

class NewTransaction extends StatefulWidget {
  final Function addFunc;
  final BuildContext modalBottomSheetCtx;

  NewTransaction(this.addFunc, this.modalBottomSheetCtx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final String enteredTitle = titleController.text;
    final double enteredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addFunc(enteredTitle, enteredAmount, widget.modalBottomSheetCtx);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 2)),
                labelText: "Title",
                labelStyle: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline1.fontFamily,
                    fontSize: Theme.of(context).textTheme.headline1.fontSize),
              ),
              controller: titleController,
            ),
            TextField(
              onSubmitted: (value) => submitData(),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                focusColor: Theme.of(context).primaryColor,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 2),
                ),
                labelText: "Amount",
                labelStyle: TextStyle(
                    fontFamily:
                        Theme.of(context).textTheme.headline1.fontFamily,
                    fontSize: Theme.of(context).textTheme.headline1.fontSize),
              ),
              controller: amountController,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: TextButton(
                onPressed: () => submitData(),
                child: Text(
                  "Add Transaction",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .apply(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
