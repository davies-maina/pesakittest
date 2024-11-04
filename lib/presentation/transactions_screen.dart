import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pesakit/data/transaction_repo_impl.dart';

import '../data/models/transaction.dart';

class TransactionsScreen extends StatelessWidget {
  final TransactionRepoImpl _transactionRepoImpl = TransactionRepoImpl();
  String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'sw_KE', symbol: 'KSh');
    return format.format(amount);
  }

  String formatDate(DateTime date) {
    final format = DateFormat('yyyy-MM-dd HH:mm');
    return format.format(date);
  }

  TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Either<String, List<Transaction>>>(
      future: _transactionRepoImpl.getTransactions(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('An unexpected error occurred.'));
        } else if (snapshot.hasData) {
          return snapshot.data!.fold(
            // Error case
            (error) => Center(child: Text(error)),
            // Success case
            (transactions) => transactions.isEmpty
                ? const Center(child: Text('No transactions found.'))
                : ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        leading: Icon(
                          transaction.type == 'Income'
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          color: transaction.type == 'Income'
                              ? Colors.green
                              : Colors.red,
                        ),
                        title: Text(transaction.description),
                        subtitle: Text(formatDate(transaction.date)),
                        trailing: Text(
                          formatCurrency(transaction.amount),
                          style: TextStyle(
                            color: transaction.type == 'Income'
                                ? Colors.green
                                : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
          );
        } else {
          return const Center(child: Text('No data available.'));
        }
      },
    );
  }
}
