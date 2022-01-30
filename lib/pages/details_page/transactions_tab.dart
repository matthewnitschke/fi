
import 'package:built_collection/built_collection.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/transaction_card.dart';
import 'package:flutter/material.dart';

class TransactionsTab extends StatelessWidget {
  final Bucket bucket;
  final String bucketId;

  const TransactionsTab(this.bucket, this.bucketId, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return storeConnector<BuiltList<Transaction>>(
        converter: (state) => (bucket.transactions
          .map((transactionId) => state.transactions[transactionId]!)
          .toList()
          ..sort((a, b) => a.date.compareTo(b.date)))
          .toBuiltList(), 
        builder: (transactions) {
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final transaction = transactions[index];
              return TransactionCard(
                transaction: transaction,
              );
            },
          );
        },
      );
    });

  }
}