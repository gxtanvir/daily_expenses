import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/models/expense.dart';

class ManageExpenseNotifier extends StateNotifier<List<Expense>> {
  ManageExpenseNotifier() : super([]);

  // Add Expense
  void addExpense(Expense expense) {
    state = [...state, expense];
  }
}

final manageExpenseProvider =
    StateNotifierProvider<ManageExpenseNotifier, List<Expense>>(
        (ref) => ManageExpenseNotifier());
