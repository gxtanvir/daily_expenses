import 'package:daily_expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final formater = DateFormat.yMMMEd();

class Details extends StatelessWidget {
  const Details({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry Details"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide(
                  style: BorderStyle.solid,
                  width: 5,
                  color: expense.isCashIn ? Colors.green : Colors.red,
                ),
              ),
              // borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expense.isCashIn ? "Cash In" : "Cash Out",
                      style: TextStyle(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    Row(
                      children: [
                        Text("On ${formater.format(expense.date)}, "),
                        Text(
                          expense.time.format(context),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
