import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTrans;

  NewTransaction(this.newTrans);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _selectedDate;

  void submitData() {
    if(amountController.text.isEmpty)
      return;


    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0||_selectedDate==null) {
      return;
    }

    widget.newTrans(
      enteredTitle,
      enteredAmount,
      _selectedDate,

    );
    Navigator.of(context).pop();
  }

  void _presentDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
      
    });
  }

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title '),
              //onChanged: (//value) {
              //titleInput=value;

              //},
              controller: titleController,
              onSubmitted: (_) => submitData,
              //onsubmitted is used to make use of keyboard enter button
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData,
              //   onChanged: (value) =>amountInput=value,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                Expanded(
                  
                                      child: Text(
                      _selectedDate == null
                          ? 'no Date choosen'
                          :  'pickedDate${DateFormat.yMd().format(_selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDate,
                    child: Text(
                      'choose date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              child: Text('Add Transaction'),
            ),
          ],
        ),
      ),
    );
  }
}
