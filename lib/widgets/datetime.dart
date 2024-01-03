import 'package:flutter/material.dart';

class Time extends StatelessWidget {
  const Time({super.key, required this.dtime});
  final DateTime dtime;

  @override
  Widget build(BuildContext context) {
    final nowTime = DateTime.now();
    final diff = nowTime.difference(dtime);
    if (diff.inSeconds < 60) {
      return Text('Created ${diff.inSeconds} seconds ago.');
    } else if (diff.inSeconds < 3600) {
      return Text('Created ${diff.inMinutes} minutes ago.');
    } else if (diff.inHours < 86400) {
      return Text('Created ${diff.inHours} hours ago');
    } else {
      return Text('Created on $dtime');
    }
  }
}
