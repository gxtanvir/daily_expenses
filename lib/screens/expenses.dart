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
      backgroundColor: const Color.fromARGB(255, 236, 236, 235),
      appBar: AppBar(
        title: Text(
          book.title,
        ),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
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
                decoration: const BoxDecoration(
                    shape: BoxShape.rectangle, color: Colors.white),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      size: 25,
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
                  const Expanded(
                      child: Divider(
                    endIndent: 10,
                  )),
                  Text(
                    'Showing ${expenses.length} entries',
                    style: const TextStyle(fontWeight: FontWeight.bold),
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
                itemCount: expenses.length,
                reverse: true,
                itemBuilder: (context, index) =>
                    ExpenseCard(expense: expenses[index]),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                backgroundColor: Theme.of(context).colorScheme.error,
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
