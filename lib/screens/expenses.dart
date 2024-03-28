import 'package:daily_expense/models/book.dart';
import 'package:daily_expense/screens/add_expense.dart';
import 'package:daily_expense/widgets/expense_card.dart';
import 'package:daily_expense/widgets/expense_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/providers/manage_expense_provider.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref
        .watch(manageExpenseProvider)
        .where((element) => element.bookId == book.id)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: SingleChildScrollView(
            child: Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Theme.of(context).colorScheme.outlineVariant),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            size: 25,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Search your expenses',
                            style: TextStyle(
                                fontSize: 16,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onBackground
                                    .withOpacity(.3)),
                          )
                        ],
                      ),
                    ),
                  ),
                  Summary(expenses: expenses),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                          endIndent: 10,
                          color: Theme.of(context).colorScheme.onSurface,
                        )),
                        Text(
                          'Showing ${expenses.length} entries',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Expanded(
                            child: Divider(
                          indent: 10,
                        )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: expenses.length,
                      reverse: true,
                      itemBuilder: (context, index) =>
                          ExpenseCard(expense: expenses[index]),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Theme.of(context).colorScheme.surfaceVariant),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddExpense(
                          inOrOut: "in",
                          book: book,
                        )));
              },
              icon: const Icon(Icons.add),
              label: const Text('Cash In'),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => AddExpense(
                          inOrOut: "out",
                          book: book,
                        )));
              },
              icon: const Icon(Icons.delete),
              label: const Text('Cash Out'),
            ),
          ],
        ),
      ),
    );
  }
}
