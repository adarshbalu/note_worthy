import 'package:moor/moor.dart';
import 'package:moor_flutter/moor_flutter.dart';

part 'database.g.dart';

class Notes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 0, max: 50)();
  TextColumn get description => text().withLength(min: 5)();
  TextColumn get category => text().withLength(min: 5)();
  DateTimeColumn get dateCreated => dateTime()();
  BoolColumn get completed => boolean().withDefault(Constant(false))();
}

@UseMoor(tables: [Notes])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super((FlutterQueryExecutor.inDatabaseFolder(
          path: 'db.sqlite',
          logStatements: true,
        )));

  @override
  int get schemaVersion => 2;

  Future<List<Note>> getAllTasks() => select(notes).get();

  Stream<List<Note>> watchAllTasks() => select(notes).watch();

  Future insertTask(Note note) => into(notes).insert(note);

  Future updateTask(Note note) => update(notes).replace(note);

  Future deleteTask(Note note) => delete(notes).delete(note);
}
