import 'dart:ui';

import 'package:fi/models/transaction.sg.dart';
import 'package:fi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final fmt = DateFormat('d');

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function()? onTap;

  const TransactionCard({ 
    Key? key,
    required this.transaction,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 4.0),
          child: Text(
            transaction.amount.formatCurrency(2),
            style: TextStyle(
              color: transaction.amount > 0 ? Colors.green : null,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        tileColor: transaction.amount > 0 ? Colors.green[50] : null,
        subtitle: Text(transaction.merchant ?? transaction.name),
        onTap: onTap,
      )
    );
  }
}