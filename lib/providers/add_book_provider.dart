import 'package:daily_expense/models/book.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddBookNotifier extends StateNotifier<List<Book>> {
  AddBookNotifier() : super([]);

  void addBook(Book book) {
    state = [...state, book];
  }
}

final newBooksProvider = StateNotifierProvider<AddBookNotifier, List<Book>>(
  (ref) => AddBookNotifier(),
);
