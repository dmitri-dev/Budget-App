import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 02 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
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
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: 'Title:'),
            controller: _titleController,
            onSubmitted: (_) => _submitData(),
            /*onChanged: (val) {
                    titleInput = val;
                  },*/
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Amount:'),
            controller: _amountController,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onSubmitted: (_) => _submitData(),
            /*onChanged: (val) {
                    titleInput = val;
                  },*/
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'no date chosen'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                ),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: _presentDatePicker,
                child: Text(
                  'choose date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          RaisedButton(
            color: Theme.of(context).primaryColor,
            onPressed: _submitData,
            textColor: Theme.of(context).textTheme.button.color,
            child: Text(
              'Add Transaction',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
