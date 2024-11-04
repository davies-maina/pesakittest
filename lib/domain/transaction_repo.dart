import 'package:dartz/dartz.dart';
import 'package:pesakit/data/models/transaction.dart';

abstract class TransactionRepo {
  Future<Either<String, List<Transaction>>> getTransactions();
}
