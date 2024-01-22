import 'package:flutter/material.dart';

class summary extends StatelessWidget {
  const summary({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(5)),
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
                'Total In (+)',
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
                'Total Out (-)',
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
    );
  }
}
