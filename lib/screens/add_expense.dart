import 'package:flutter/material.dart';
import 'package:daily_expense/models/expense.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() {
    return _AddExpense();
  }
}

class _AddExpense extends State<AddExpense> {
  var _amount = "";
  DateTime? _selectedDate = DateTime.now();
  DateTime? _selectedTime = DateTime.now();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Cash Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cash In'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
                const SizedBox(width: 6),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('Cash Out'),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    dateFormatter.format(_selectedDate!),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.history),
                  label: Text(
                    timeFormatter.format(_selectedTime!),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    autocorrect: false,
                    // keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Enter a valid amount";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _amount = value!;
                    },
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    print(_amount.runtimeType);
                  }
                },
                child: Text("Sava Data")),
          ],
        ),
      ),
    );
  }
}
