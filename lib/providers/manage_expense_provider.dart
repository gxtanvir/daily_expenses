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

// Function to convert String to TimeOfDay
TimeOfDay stringToTimeOfDay(String timeString) {
  // Extracting the hour and minute parts from the string
  List<String> parts = timeString
      .substring(timeString.indexOf('(') + 1, timeString.indexOf(')'))
      .split(':');

  int hour = int.parse(parts[0]);
  int minute = int.parse(parts[1]);

  return TimeOfDay(hour: hour, minute: minute);
}

class ManageExpenseNotifier extends StateNotifier<List<Expense>> {
  ManageExpenseNotifier() : super([]);

  // Load Expense
  Future<void> loadExpense() async {
    final db = await _getDatabase();
    final data = await db.query('expense_details');
    final expenses = data.map((row) {
      var timeString = row['time'] as String;
      TimeOfDay time = stringToTimeOfDay(timeString);
      return Expense(
          id: row['id'] as String,
          date: DateTime.parse(row['date'] as String),
          time: time, // Need to solve
          amount: row['amount'] as num,
          remarks: row['remarks'] as String,
          isCashIn: row['isCashIn'] as String == 'true' ? true : false,
          bookId: row['bookId'] as String);
    }).toList();
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
