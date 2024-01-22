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
  DateTime? _selectedDate = DateTime.now();
  DateTime? _selectedTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Cash Entry'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_today),
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
            )
          ],
        ),
      ),
    );
  }
}
