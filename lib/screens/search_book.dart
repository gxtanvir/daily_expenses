import 'package:daily_expense/models/book.dart';
import 'package:daily_expense/screens/expenses.dart';
import 'package:daily_expense/widgets/datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/providers/manage_book_provider.dart';

class SearchBook extends ConsumerStatefulWidget {
  const SearchBook({super.key});

  @override
  ConsumerState<SearchBook> createState() {
    return _SearchBookState();
  }
}

class _SearchBookState extends ConsumerState<SearchBook> {
  late List<Book> _booksList;

  @override
  void initState() {
    super.initState();
    _booksList = ref.read(manageBooksProvider);
  }

  // Search Book
  void searchBook(String query) {
    final books = ref.watch(manageBooksProvider);
    final searchedBooks = books
        .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _booksList = searchedBooks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          title: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  hintText: 'Search By Book Name',
                  hintStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  border: InputBorder.none),
              autofocus: true,
              onChanged: searchBook,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_booksList.isEmpty)
                const Center(
                  child: Text(
                    'No book found with this name! \nTry again with correct spelling.',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
              if (_booksList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                      itemCount: _booksList.length,
                      itemBuilder: (ctx, index) {
                        return Dismissible(
                          background: Card(
                            color: Theme.of(context).colorScheme.errorContainer,
                          ),
                          key: ValueKey(_booksList[index]),
                          onDismissed: (direction) {
                            ref
                                .read(manageBooksProvider.notifier)
                                .removeBook(_booksList[index]);
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(seconds: 3),
                                action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      ref
                                          .read(manageBooksProvider.notifier)
                                          .addBook(
                                            _booksList[index],
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
                              title: Text(_booksList[index].title),
                              subtitle: Time(dtime: _booksList[index].dateTime),
                              trailing: const Text(
                                'Balance',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) =>
                                        ExpensesScreen(book: _booksList[index]),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }),
                ),
            ],
          ),
        ));
  }
}
