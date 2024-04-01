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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      expense.isCashIn ? "Cash In" : "Cash Out",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                          fontSize:
                              Theme.of(context).textTheme.bodyLarge!.fontSize),
                    ),
                    Text(
                      "On ${formater.format(expense.date)}, ${expense.time.format(context)}",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  expense.amount.toString(),
                  style: TextStyle(
                      color: expense.isCashIn ? Colors.green : Colors.red,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge!.fontSize,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                const SizedBox(height: 10),
                Text(
                  expense.remarks,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onBackground,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize),
                ),
                const SizedBox(height: 10),
                Divider(
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                TextButton.icon(onPressed: (){}, icon: Icon(Icons.update), label: Text("Edit Entrys"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
