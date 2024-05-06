import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/models/expense.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'expenses.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE expense_details(id TEXT PRIMARY KEY, bookId TEXT, date TEXT, time TEXT, amount REAL, remarks TEXT, isCashIn TEXT)');
    },
    version: 1,
  );
  return db;
}

class ManageExpenseNotifier extends StateNotifier<List<Expense>> {
  ManageExpenseNotifier() : super([]);

  // Load Expense
  Future<void> loadExpense() async {
    final db = await _getDatabase();
    final data = await db.query('expense_details');
    final expenses = data
        .map((row) => Expense(
            id: row['id'] as String,
            date: DateTime.parse(row['date'] as String),
            time: TimeOfDay.fromDateTime(DateTime.parse(row['time'] as String)),
            amount: row['amount'] as num,
            remarks: row['remarks'] as String,
            isCashIn: row['isCashIn'] as String == 'true' ? true : false,
            bookId: row['bookId'] as String))
        .toList();
    state = expenses;
  }

  // Add Expense
  void addExpense(Expense expense) async {
    final db = await _getDatabase();
    await db.insert('expense_details', {
      'id': expense.id,
      'bookId': expense.bookId,
      'date': expense.date.toString(),
      'time': expense.time.toString(),
      'amount': expense.amount,
      'remarks': expense.remarks,
      'isCashIn': expense.isCashIn.toString(),
    });
    state = [...state, expense];
  }
}

final manageExpenseProvider =
    StateNotifierProvider<ManageExpenseNotifier, List<Expense>>(
        (ref) => ManageExpenseNotifier());
