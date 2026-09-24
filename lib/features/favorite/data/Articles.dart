import 'package:drift/drift.dart';

class Articles extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get title => text()();

  TextColumn get time => text()();

  TextColumn get author => text()();

  TextColumn get image => text()();

  TextColumn get description => text()();

  TextColumn get url => text()();

  TextColumn get content => text()();

  TextColumn get source => text()();
}
