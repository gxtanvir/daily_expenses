import 'package:daily_expense/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:daily_expense/providers/manage_book_provider.dart';

class NewExpense extends ConsumerStatefulWidget {
  const NewExpense({super.key});

  @override
  ConsumerState<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends ConsumerState<NewExpense> {
  final _bookController = TextEditingController();

  @override
  void dispose() {
    _bookController.dispose();
    super.dispose();
  }

  // Add New Book
  void _addBook() {
    final _enteredBookName = _bookController.text;

    if (_enteredBookName.trim().isEmpty) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Data'),
          content: const Text('Please enter a valid Book Name.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay')),
          ],
        ),
      );
      return;
    }
    ref.read(manageBooksProvider.notifier).addBook(
          Book(title: _enteredBookName),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.cancel_rounded,
                    size: 25,
                  )),
              const SizedBox(width: 10),
              const Text(
                'Add New Book',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Column(
              children: [
                TextField(
                  autofocus: true,
                  controller: _bookController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'Enter Book Name',
                    labelStyle: const TextStyle(fontSize: 20),
                  ),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 50),
                const Divider(
                  height: 50,
                ),
                Container(
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton.icon(
                    icon: const Icon(
                      Icons.add,
                      size: 25,
                    ),
                    onPressed: _addBook,
                    label: const Text(
                      'ADD NEW BOOK',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
