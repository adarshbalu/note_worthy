import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: 50)();
  TextColumn get description => text().withLength(min: 5)();
  TextColumn get category => text().withLength(min: 5)();
  TextColumn get type => text().withLength(min: 5)();
  DateTimeColumn get dateCreated => dateTime()();
  DateTimeColumn get dueDate => dateTime()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
  BoolColumn get important => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 3;

  Future<List<Note>> getAllNotes() => select(notes).get();

  Stream<List<Note>> watchAllNotes() => select(notes).watch();

  Future insertNote(Note note) => into(notes).insert(note);

  Future updateNote(Note note) => update(notes).replace(note);

  Future deleteNote(Note note) => delete(notes).delete(note);
}
