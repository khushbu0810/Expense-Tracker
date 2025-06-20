import 'dart:io';
import 'dart:math';

import 'package:app6_expense_tracker/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  //Method-1
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }

  //method-2

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate; //initial it is null
  Category _seleectedCategory = Category.leisure; //initially

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder:
            (ctx) => CupertinoAlertDialog(
              title: Text('Invalid Input'),
              content: Text(
                'Please make sure to enter a valid title, amount, date and category',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    } else {
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text(
                'Please make sure to enter a valid title, amount, date and category',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
    }
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsValid = enteredAmount == null || enteredAmount <= 0;
    if (amountIsValid ||
        _titleController.text.trim().isEmpty ||
        _selectedDate == null) {
      //error
      _showDialog();

      return; //return likhne k baad kuch executed nhi hoga
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _seleectedCategory,
      ),
    );
    Navigator.pop(context); //after save it closes automatically
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final width = constraints.maxWidth;

        return SizedBox(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
              child: Column(
                children: [
                  if (width >= 600)
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              //onChanged: _saveTitleInput,
                              controller: _titleController,
                              maxLength: 50,
                              decoration: InputDecoration(
                                label: Text("Title"), //
                              ),
                            ),
                          ),
                          SizedBox(width: 24),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                prefixText: '\$',
                                label: Text("Amount"), //
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    TextField(
                      //onChanged: _saveTitleInput,
                      controller: _titleController,
                      maxLength: 50,
                      decoration: InputDecoration(
                        label: Text("Title"), //
                      ),
                    ),
                  if (width >= 600)
                    Expanded(
                      child: Row(
                        children: [
                          DropdownButton(
                            value: _seleectedCategory,
                            items:
                                Category.values
                                    .map(
                                      (category) => DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                          category.name.toUpperCase(),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              setState(() {
                                _seleectedCategory = value;
                              });
                            },
                          ),

                          SizedBox(width: 24),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Flexible(
                                  child: Text(
                                    _selectedDate == null
                                        ? 'no date selected'
                                        : formatter.format(
                                          _selectedDate!,
                                        ), //_selecteddate!= this is not null
                                  ),
                                ),
                                IconButton(
                                  onPressed: _presentDatePicker,
                                  icon: Icon(Icons.calendar_month),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _amountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              prefixText: '\$',
                              label: Text("Amount"), //
                            ),
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  _selectedDate == null
                                      ? 'no date selected'
                                      : formatter.format(
                                        _selectedDate!,
                                      ), //_selecteddate!= this is not null
                                ),
                              ),
                              IconButton(
                                onPressed: _presentDatePicker,
                                icon: Icon(Icons.calendar_month),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  SizedBox(height: 16),
                  if (width >= 600)
                    Row(
                      children: [
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CANCEL"), //
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text("SAVE"),
                        ),
                      ],
                    )
                  else
                    Row(
                      children: [
                        DropdownButton(
                          value: _seleectedCategory,
                          items:
                              Category.values
                                  .map(
                                    (category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.name.toUpperCase()),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _seleectedCategory = value;
                            });
                          },
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("CANCEL"), //
                        ),
                        ElevatedButton(
                          onPressed: _submitExpenseData,
                          child: Text("SAVE"),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
