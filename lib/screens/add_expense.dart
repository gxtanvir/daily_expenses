import 'package:daily_expense/models/book.dart';
import 'package:daily_expense/providers/manage_expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:daily_expense/models/expense.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key, required this.inOrOut, required this.book});
  final String inOrOut;
  final Book book;

  @override
  ConsumerState<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends ConsumerState<AddExpense> {
  bool _isCashIn = true;
  var _amount = 0;
  var _remarks = "";
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.inOrOut == "in") {
      _isCashIn = true;
    }
    if (widget.inOrOut == "out") {
      _isCashIn = false;
    }
  }
  

  // Date Picker
  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final lastDate = DateTime(now.year + 64);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    setState(() {
      _selectedDate = pickedDate!;
    });
  }

  // Time Pciker
  void _openTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    setState(() {
      _selectedTime = pickedTime!;
    });
  }

  // Add Expense Method
  void _addExpense() {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      ref.read(manageExpenseProvider.notifier).addExpense(Expense(
          date: _selectedDate,
          time: _selectedTime,
          amount: _amount,
          remarks: _remarks,
          bookId: widget.book.id,
          isCashIn: _isCashIn ? true : false));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCashIn ? "Add Cash In Entry" : "Add Cash Out Entry"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isCashIn = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: !_isCashIn ? Colors.grey : null),
                    child: const Text('Cash In'),
                  ),
                  const SizedBox(width: 6),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isCashIn = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: !_isCashIn
                            ? Theme.of(context).colorScheme.error
                            : Colors.grey),
                    child: const Text('Cash Out'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: _openDatePicker,
                    icon: const Icon(Icons.calendar_month),
                    label: Text(
                      dateFormatter.format(_selectedDate),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _openTimePicker,
                    icon: const Icon(Icons.history),
                    label: Text(_selectedTime.format(context)),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                        labelText: "Amount",
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            num.tryParse(value) == null) {
                          return "Enter a valid amount";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _amount = int.parse(value!);
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                        hintText: "Remarks(Item Name/Quantity)",
                        labelText: "Remarks",
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length > 20) {
                          return "Remarks must be less than 20";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _remarks = value!;
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(64, 202, 212, 206),
              Color.fromARGB(248, 255, 255, 255),
              Color.fromARGB(255, 255, 255, 255),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Row(
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 18),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  _addExpense();
                },
                child: const Text("SAVE & ADD NEW")),
            const SizedBox(width: 14),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                  textStyle: const TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  _addExpense();
                  if (_formkey.currentState!.validate()) {
                    Navigator.of(context).pop();
                  }
                },
                child: const Text("SAVE"))
          ],
        ),
      ),
    );
  }
}
