import "package:flutter/material.dart";

class NewTransaction extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: "Title"),
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: TextButton(
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                },
                child: Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 18, color: Colors.purple),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
