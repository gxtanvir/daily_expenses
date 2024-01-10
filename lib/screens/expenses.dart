import 'package:daily_expense/models/book.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book.title),),
      body: Center(child: Text('Hello'),),
    );
  }
}
