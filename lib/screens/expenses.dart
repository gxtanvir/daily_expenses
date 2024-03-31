import 'package:daily_expense/models/book.dart';
import 'package:daily_expense/screens/add_expense.dart';
import 'package:daily_expense/screens/expense_details.dart';
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GestureDetector(
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
          ),
          SliverToBoxAdapter(
            child: Summary(expenses: expenses),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
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
                      Expanded(
                          child: Divider(
                        indent: 10,
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final reversedIndex = expenses.length - index - 1;
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) =>
                            Details(expense: expenses[reversedIndex]),
                      ),
                    );
                  },
                  child: ExpenseCard(
                    expense: expenses[reversedIndex],
                  ),
                );
              },
              childCount: expenses.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 250),
          )
        ],
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
