import 'package:finku/data/database.dart';

class TransactionWithCategory {
  final Transaction transaction;
  final Category category;

  TransactionWithCategory(this.transaction, this.category);
}