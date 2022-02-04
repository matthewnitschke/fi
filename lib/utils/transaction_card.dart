import 'package:fi/models/transaction.sg.dart';
import 'package:fi/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

final fmt = DateFormat('d');

class TransactionCard extends StatelessWidget {
  final Transaction transaction;
  final Function()? onTap;

  final bool wrapWithCard;

  final Color? textColor;

  final List<SlidableAction> slidableActions;

  const TransactionCard({ 
    Key? key,
    required this.transaction,
    this.onTap,
    this.wrapWithCard = true,
    this.textColor,
    this.slidableActions = const [],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (wrapWithCard) {
      return Card(
        color: transaction.amount > 0 ? Colors.green[900] : null,
        child: slidableActions.isNotEmpty 
          ? Slidable(
            endActionPane: ActionPane(
              motion: const BehindMotion(),
              children: slidableActions,
            ),
            child: _renderContent(context)
          )
          : _renderContent(context)
      );
    }

    return _renderContent(context);
  }

  Widget _renderContent(BuildContext context) {
    return ListTile(
      textColor: textColor,
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
      subtitle: Text(transaction.merchant ?? transaction.name),
      onTap: onTap,
    );
  }
}