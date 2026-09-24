import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../features/favorite/data/Articles.dart';

part 'app_database.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() {
    return driftDatabase(name: 'my_database');
  });
}

@DriftDatabase(tables: [Articles])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}
