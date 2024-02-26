import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat.yMd();
final timeFormatter = DateFormat.jm();
var uid = const Uuid();

class Expense {
  Expense({
    required this.date,
    required this.time,
    required this.amount,
    required this.remarks,
    required this.isCashIn,
    String? id,
    required this.bookId,
  }) : id = id ?? uid.v4();
  final String id;
  final String bookId;
  final DateTime date;
  final TimeOfDay time;
  final int amount;
  final String remarks;
  final bool isCashIn;
}
