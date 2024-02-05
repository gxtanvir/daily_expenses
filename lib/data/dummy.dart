import 'package:daily_expense/models/expense.dart';
import 'package:flutter/material.dart';

final dummyExpenses = [
  Expense(
      date: DateTime.now(),
      time: TimeOfDay.now(),
      amount: 45.55,
      remarks: 'Egg'),
  Expense(
      date: DateTime.now(),
      time: TimeOfDay.now(),
      amount: 20,
      remarks: 'Shampoo'),
  Expense(
      date: DateTime.now(),
      time: TimeOfDay.now(),
      amount: 35.23,
      remarks: 'Tissue'),
];
