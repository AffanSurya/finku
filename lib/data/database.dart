import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:finku/models/category.dart';
import 'package:finku/models/transaction.dart';
import 'package:finku/models/transaction_with_category.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:io';

part 'database.g.dart';

@DriftDatabase(tables: [Categories, Transactions])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Controller
  // crud category
  Future<List<Category>> getAllCategoryRepo(int type) async{
    return await (select(categories)..where((tbl) => 
    tbl.type.equals(type)
    )).get();
  }

  Future updateCategoryRepo(int id, String newName) async {
    return (update(categories)..where((t) => t.id.equals(id))).write(
      CategoriesCompanion(
        name: Value(newName),
      ),
    );
  }

  Future deleteCategoryRepo(int id) async {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }


  // transaction
  Stream<List<TransactionWithCategory>> getTransactionByDateRepo(DateTime date) {
    final query = (select(transactions).join([
      innerJoin((categories), categories.id.equalsExp(transactions.categoryId))
    ])..where(transactions.transactionDate.equals(date))
    );

    return query.watch().map((rows) {
      return rows.map((row) {
        return TransactionWithCategory(
          row.readTable(transactions), 
          row.readTable(categories));
      }).toList();
    });
  }

  Future deleteTransactionByDateRepo(int id) async {
    return (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> getTotalAmountByDateAndCategoryType(DateTime date, int categoryType) async {
    final query = select(transactions).join([
      innerJoin(categories, categories.id.equalsExp(transactions.categoryId))
    ])
      ..where(transactions.transactionDate.equals(date))
      ..where(categories.type.equals(categoryType));

    final result = await query.map((row) {
      return row.readTable(transactions).amount;
    }).get();

    return result.fold<int>(0, (sum, amount) => sum + amount);
  }


  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
      return NativeDatabase(file);
    });
  }
}