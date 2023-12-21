import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Book {
   Book({required this.title}) : id = uuid.v4();
  final String title;
  final id;
}

