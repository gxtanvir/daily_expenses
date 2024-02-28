import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Book {
  Book({required this.title, DateTime? dateTime, String? id})
      : dateTime = dateTime ?? DateTime.now(),
        id = id ?? uuid.v4();
  final String title;
  final DateTime dateTime;
  final String id;
}
