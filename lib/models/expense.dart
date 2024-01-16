import 'package:uuid/uuid.dart';

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
  final DateTime time;
  final num amount;
  final String remarks;
}
