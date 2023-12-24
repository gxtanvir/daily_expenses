import 'package:daily_expense/widgets/new_book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/providers/manage_book_provider.dart';

final _firebaseAuth = FirebaseAuth.instance;

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final books = ref.watch(manageBooksProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        leading: Icon(
          Icons.account_balance_wallet_outlined,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        title: Text(
          'Khoroch Shomogro',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _firebaseAuth.signOut();
            },
            icon: Icon(
              Icons.logout_outlined,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (ctx) {
              return const NewExpense();
            },
            backgroundColor: Theme.of(context).colorScheme.surface,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            useSafeArea: true,
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add New Book'),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Books',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.sort,
                          size: 35,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.search,
                          size: 35,
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
                                  ref
                                      .read(manageBooksProvider.notifier)
                                      .addBook(
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
                          subtitle: const Text('Created 1 day ago'),
                          trailing: const Text(
                            '478',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    );
                  }),
            )
        ],
      ),
    );
  }
}
