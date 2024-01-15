import 'package:daily_expense/models/book.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key, required this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final _color = Theme.of(context).colorScheme;
    return Scaffold(
        appBar: AppBar(
          title: Text(book.title),
          backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              _color.primaryContainer.withOpacity(.3),
              _color.primaryContainer.withOpacity(.1)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: double.infinity,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceVariant
                            .withOpacity(.4)),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          size: 25,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Search your expenses',
                          style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onBackground
                                  .withOpacity(.3)),
                        )
                      ],
                    )),
              ),
              const Divider(
                height: 6,
                thickness: 2,
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  shape: BoxShape.rectangle,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Net Balance',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '7837',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total In',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '7837',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Out',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '500',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Out',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '500',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
