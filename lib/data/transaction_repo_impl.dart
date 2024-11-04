import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:pesakit/data/models/transaction.dart';
import 'package:pesakit/domain/transaction_repo.dart';

class TransactionRepoImpl implements TransactionRepo {
  static const String apiUrl =
      'https://6728ccaa6d5fa4901b6af807.mockapi.io/transactions';

  @override
  Future<Either<String, List<Transaction>>> getTransactions() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        final transactions =
            data.map((json) => Transaction.fromJson(json)).toList();
        return Right(transactions);
      } else {
        return Left('Failed to load transactions: ${response.statusCode}');
      }
    } catch (e) {
      return Left('An error occurred: $e');
    }
  }
}
