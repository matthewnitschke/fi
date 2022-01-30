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
        title: Text(
          transaction.amount.formatCurrency(2),
          style: TextStyle(color: transaction.amount > 0 ? Colors.green : null),
        ),
        tileColor: transaction.amount > 0 ? Colors.green[50] : null,
        subtitle: Text(transaction.merchant ?? transaction.name),
        onTap: onTap,
        trailing: Text(
          '${transaction.date.day}${_getDayOfMonthSuffix(transaction.date.day)}',
          style: const TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      )
    );
  }

  String _getDayOfMonthSuffix(int dayNum) {
    if(!(dayNum >= 1 && dayNum <= 31)) {
      throw Exception('Invalid day of month');
    }

    if(dayNum >= 11 && dayNum <= 13) {
      return 'th';
    }

    switch(dayNum % 10) {
      case 1: return 'st';
      case 2: return 'nd';
      case 3: return 'rd';
      default: return 'th';
    }
}
}