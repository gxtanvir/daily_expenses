import 'package:daily_expense/models/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'books.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE expense_book(id TEXT PRIMARY KEY, title TEXT, time TEXT)');
    },
    version: 1,
  );
  return db;
}

class AddBookNotifier extends StateNotifier<List<Book>> {
  AddBookNotifier() : super([]);

  // Load Book
  Future<void> loadBook() async {
    final db = await _getDatabase();
    final data = await db.query('expense_book');
    final books = data
        .map((row) => Book(
              id: row['id'] as String,
              title: row['title'] as String,
              dateTime: DateTime.parse(row['time'] as String),
            ))
        .toList();
    state = books;
  }

  // Add New Book
  void addBook(Book book) async {
    final db = await _getDatabase();
    await db.insert('expense_book', {
      'id': book.id,
      'title': book.title,
      'time': book.dateTime.toString(),
    });
    state = [...state, book];
  }

  // Update Book Name
  void updateBook(Book book) async {
    final db = await _getDatabase();
    await db.update('expense_book', {'title': book.title},
        where: 'id = ?', whereArgs: [book.id]);
    print('Book Updated!');
    // state = [...state];
  }

  // Delete Book
  void removeBook(Book book) async {
    final db = await _getDatabase();
    await db.delete('expense_book', where: 'id = ?', whereArgs: [book.id]);
    state = state.where((b) => b.id != book.id).toList();
  }
}

final manageBooksProvider = StateNotifierProvider<AddBookNotifier, List<Book>>(
  (ref) => AddBookNotifier(),
);
