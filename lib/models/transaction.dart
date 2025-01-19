import 'package:drift/drift.dart';

// part 'database.g.dart';

class Transactions extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text().withLength(max: 250)();
  IntColumn get categoryId => integer()();
  DateTimeColumn get transactionDate => dateTime()();
  IntColumn get amount => integer()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

// @DriftDatabase(tables: [Categories])
// class AppDatabase extends _$AppDatabase {
// }