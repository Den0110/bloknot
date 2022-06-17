import 'package:drift/drift.dart';

// part 'notes.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get note => text()();
}