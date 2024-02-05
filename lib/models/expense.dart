import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();
final timeFormatter = DateFormat.jm();
var uid = Uuid();

class Expense {
  Expense({
    required this.date,
    required this.time,
    required this.amount,
    required this.remarks,
    String? id,
  }) : id = id ?? uid.v4();
  final String id;
  final DateTime date;
  final TimeOfDay time;
  final num amount;
  final String remarks;
}
