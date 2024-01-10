import 'package:daily_expense/widgets/book_list.dart';

import 'package:daily_expense/widgets/new_book.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/providers/manage_book_provider.dart';

final _firebaseAuth = FirebaseAuth.instance;

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> _bookFuture;
  // bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _bookFuture = ref.read(manageBooksProvider.notifier).loadBook();
  }

  @override
  Widget build(BuildContext context) {
    // // On Search
    // void onSearch() {
    //   setState(() {
    //     isSearching = true;
    //   });
    // }

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
      body: FutureBuilder(
        future: _bookFuture,
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : BookList(books: books),
      ),
    );
  }
}
