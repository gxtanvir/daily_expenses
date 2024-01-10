import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  const Time({super.key, required this.dtime});
  final DateTime dtime;

  @override
  Widget build(BuildContext context) {
    final nowTime = DateTime.now();
    final diff = nowTime.difference(dtime);
    if (diff.inSeconds <= 60) {
      return Text('Created ${diff.inSeconds + 1} seconds ago.');
    }
    if (diff.inSeconds <= 3600) {
      return Text('Created ${diff.inMinutes} minutes ago.');
    }
    if (diff.inHours <= 24) {
      return Text('Created ${diff.inHours} hours ago');
    }
    return Text('Created on $dtime');
  }
}
