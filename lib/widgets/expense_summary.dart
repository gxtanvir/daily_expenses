import 'package:daily_expense/models/expense.dart';
import 'package:flutter/material.dart';

class Summary extends StatefulWidget {
  const Summary({super.key, required this.expenses});
  final List<Expense> expenses;

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  var netBalance = 0;
  var totalIn = 0;
  var totalOut = 0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      totalIn = 0;
    });
    final inExpenses =
        widget.expenses.where((expense) => expense.isCashIn).toList();

    for (final i in inExpenses) {
      totalIn += i.amount;
    }

    setState(() {
      totalOut = 0;
    });
    final outExpenses =
        widget.expenses.where((expense) => !expense.isCashIn).toList();

    for (final o in outExpenses) {
      totalOut += o.amount;
    }

    setState(() {
      netBalance = totalIn - totalOut;
    });

    void onBalance(int b) {
      b = netBalance;
    }

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.outlineVariant,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Net Balance',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                netBalance.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total In (+)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                totalIn.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total Out (-)',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                totalOut.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
          Divider(
            height: 20,
            thickness: 2,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          Text(
            'Expense Summary',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
