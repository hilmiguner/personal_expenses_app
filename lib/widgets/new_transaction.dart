import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addFunc;

  NewTransaction(this.addFunc);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final String enteredTitle = _titleController.text;
    final double enteredAmount = double.parse(_amountController.text);
    final DateTime enteredDate = _selectedDate;
    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredDate == null) {
      return;
    }
    widget.addFunc(enteredTitle, enteredAmount, enteredDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(DateTime.now().year),
            lastDate: DateTime(DateTime.now().year, 12, 31))
        .then((selectedDate) {
      if (selectedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = selectedDate;
      });
    });

    /* if (!Platform.isIOS) {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(DateTime.now().year),
              lastDate: DateTime(DateTime.now().year, 12, 31))
          .then((selectedDate) {
        if (selectedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = selectedDate;
        });
      });
    } else {
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return CupertinoDatePicker(
            onDateTimeChanged: (selectedDate) {
              setState(() {
                _selectedDate = selectedDate;
              });
            },
            mode: CupertinoDatePickerMode.date,
            initialDateTime: DateTime.now(),
            minimumDate: DateTime(DateTime.now().year),
            maximumDate: DateTime(DateTime.now().year, 12, 31),
          );
        },
      );
    } */
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
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
                controller: _titleController,
              ),
              TextField(
                onSubmitted: (_) => _presentDatePicker(),
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
                controller: _amountController,
              ),
              Container(
                padding: EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No Date Choosen!"
                            : "Picked Date: ${DateFormat("dd.MM.yyyy").format(_selectedDate)}",
                        style: TextStyle(
                          fontFamily:
                              Theme.of(context).textTheme.headline1.fontFamily,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    AdaptiveTextButton(
                      text: "Choose Date",
                      onPressed: _presentDatePicker,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Theme.of(context).primaryColor),
                ),
                onPressed: () => _submitData(),
                child: Text(
                  "Add Transaction",
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .apply(color: Theme.of(context).textTheme.button.color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
