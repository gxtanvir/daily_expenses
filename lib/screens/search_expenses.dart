import 'package:daily_expense/models/book.dart';
import 'package:daily_expense/models/expense.dart';
import 'package:daily_expense/providers/manage_expense_provider.dart';
import 'package:daily_expense/screens/expense_details.dart';
import 'package:daily_expense/widgets/expense_card.dart';
import 'package:daily_expense/widgets/expense_summary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class SearchExpense extends ConsumerStatefulWidget {
  const SearchExpense({super.key, required this.book});
  final Book book;

  @override
  ConsumerState<SearchExpense> createState() {
    return _SearchExpenseState();
  }
}

class _SearchExpenseState extends ConsumerState<SearchExpense> {
  late List<Expense> _expenses;

  @override
  void initState() {
    super.initState();
    _expenses = ref
        .read(manageExpenseProvider)
        .where((element) => element.bookId == widget.book.id)
        .toList();
  }

  // Search Expense
  void searchExpense(String query) {
    final expenses = ref
        .watch(manageExpenseProvider)
        .where((element) => element.bookId == widget.book.id)
        .toList();
    final searchedExpenses = expenses
        .where((expense) =>
            expense.remarks.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _expenses = searchedExpenses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Search By Remarks',
                hintStyle: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(.3)),
                border: InputBorder.none),
            autofocus: true,
            onChanged: searchExpense,
          ),
        ),
      ),
      body: _expenses.isEmpty
          ? const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Center(
                child: Text("Sorry no expense found with this name"),
              ),
            )
          : CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Summary(expenses: _expenses),
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
                              'Showing ${_expenses.length} entries',
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
                      final reversedIndex = _expenses.length - index - 1;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  Details(expense: _expenses[reversedIndex]),
                            ),
                          );
                        },
                        child: ExpenseCard(
                          expense: _expenses[reversedIndex],
                        ),
                      );
                    },
                    childCount: _expenses.length,
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 250),
                )
              ],
            ),
    );
  }
}
