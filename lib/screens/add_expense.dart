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
  var _amount = 0.0;
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
        title: Text(
          _isCashIn ? "Add Cash In Entry" : "Add Cash Out Entry",
          style: TextStyle(
              color: _isCashIn
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.error),
        ),
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
                        backgroundColor: !_isCashIn
                            ? Colors.grey
                            : Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary),
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
                            : Colors.grey,
                        foregroundColor: Theme.of(context).colorScheme.onError),
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
                    icon: const Icon(Icons.access_time),
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
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                        labelText: "Amount",
                        labelStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
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
                        _amount = double.parse(value!);
                      },
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2)),
                        labelText: "Remarks",
                        labelStyle: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer),
                        hintText: "Remarks(Item Name/Quantity)",
                        hintStyle: TextStyle(
                            color:
                                Theme.of(context).colorScheme.surfaceVariant),
                        fillColor: Theme.of(context).colorScheme.onBackground,
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.surfaceVariant),
        child: Row(
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 18),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  _addExpense();
                },
                child: const Text("SAVE & ADD NEW")),
            const SizedBox(width: 14),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
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
