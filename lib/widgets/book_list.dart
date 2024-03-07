import 'package:daily_expense/models/book.dart';
import 'package:daily_expense/screens/expenses.dart';
import 'package:daily_expense/screens/search_book.dart';
import 'package:flutter/material.dart';
import 'package:daily_expense/providers/manage_book_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/widgets/datetime.dart';

class BookList extends ConsumerWidget {
  const BookList({super.key, required this.books});
  final List<Book> books;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Books',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.sort,
                        size: 35,
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const SearchBook()));
                      },
                      icon: Icon(
                        Icons.search,
                        size: 35,
                        color: Theme.of(context).colorScheme.onSurface,
                      )),
                ],
              )
            ],
          ),
        ),
        if (books.isEmpty)
          const Center(
            child: Text('Try adding new Books'),
          ),
        if (books.isNotEmpty)
          Expanded(
            child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (ctx, index) {
                  return Dismissible(
                    background: Card(
                      color: Theme.of(context).colorScheme.errorContainer,
                    ),
                    key: ValueKey(books[index]),
                    onDismissed: (direction) {
                      ref
                          .read(manageBooksProvider.notifier)
                          .removeBook(books[index]);
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: const Duration(seconds: 3),
                          action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                ref.read(manageBooksProvider.notifier).addBook(
                                      books[index],
                                    );
                              }),
                          content: const Text('Book removed!'),
                        ),
                      );
                    },
                    child: Card(
                      child: ListTile(
                        leading: Icon(
                          Icons.book_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        title: Text(books[index].title),
                        subtitle: Time(dtime: books[index].dateTime),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {},
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) =>
                                  ExpensesScreen(book: books[index]),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ),
      ],
    );
  }
}
