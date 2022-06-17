import 'dart:io';
import 'package:bloknot/db/notes.dart';
import 'package:drift/drift.dart';
import 'package:moor/moor.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<List<Note>> get allNotes => select(notes).get();

  Future updateNote(Note entry) async {
    final all = await allNotes;
    if (all.isNotEmpty) {
      return update(notes).replace(entry);
    } else {
      return into(notes).insert(entry);
    }
  }

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
