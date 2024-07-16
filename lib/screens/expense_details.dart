import 'package:daily_expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:daily_expense/providers/manage_expense_provider.dart';

final formater = DateFormat.yMMMEd();

class Details extends ConsumerWidget {
  const Details({super.key, required this.expense});
  final Expense expense;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entry Details"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              shape: BoxShape.rectangle,
              border: Border(
                top: BorderSide(
                  style: BorderStyle.solid,
                  width: 5,
                  color: expense.isCashIn
                      ? Colors.green
                      : Theme.of(context).colorScheme.error,
                ),
                bottom: BorderSide(
                  style: BorderStyle.solid,
                  width: 1,
                  color: Theme.of(context).colorScheme.onSurface,
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
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  expense.amount.toString(),
                  style: TextStyle(
                      color: expense.isCashIn
                          ? Colors.green
                          : Theme.of(context).colorScheme.error,
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
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.outlineVariant,
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.create_outlined),
                  label: const Text(
                    "EDIT ENTRY",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.surfaceBright,
                              title: const Text('Delete Entry!'),
                              content: const Text(
                                  'Are you sure you want to delete?'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      ref
                                          .read(manageExpenseProvider.notifier)
                                          .deleteExpense(expense);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Entry Successfully Deleted',
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onInverseSurface,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          backgroundColor: Theme.of(context)
                                              .colorScheme
                                              .inverseSurface,
                                          showCloseIcon: true,
                                          closeIconColor: Theme.of(context)
                                              .colorScheme
                                              .onInverseSurface,
                                          duration: const Duration(seconds: 3),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          behavior: SnackBarBehavior.floating,
                                          margin: const EdgeInsets.only(
                                              bottom: 200, left: 10, right: 10),
                                        ),
                                      );

                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Yes Confirm')),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('No'))
                              ],
                            ));
                    // Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  label: Text(
                    "DELETE ENTRY",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.error),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
