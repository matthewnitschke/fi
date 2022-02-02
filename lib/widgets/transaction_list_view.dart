import 'package:built_collection/src/list.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';

final sectionHeaderFormat = DateFormat.MMMd();

class TransactionListView extends StatelessWidget {
  BuiltList<String> transactionIds;

  List<SlidableAction> Function(String)? getSlideActions;
  void Function(Transaction)? onTransactionTap;

  TransactionListView({ 
    Key? key,
    required this.transactionIds,
    this.getSlideActions,
    this.onTransactionTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return storeConnector<BuiltList<Transaction>>(
      converter: (state) => (transactionIds
        .map((id) => state.transactions[id]!)
        .toList()
        ..sort((a, b) => a.date.compareTo(b.date)))
        .toBuiltList(),
      builder: (transactions) {
        if (transactions.isEmpty) {
          return const Center(child: Text('No Transactions'));
        }

        final sections = transactions.fold<Map<String, List<Transaction>>>(
          <String, List<Transaction>>{}, 
          (acc, transaction) {
            final fmtDate = sectionHeaderFormat.format(transaction.date);
            
            acc.putIfAbsent(fmtDate, () => <Transaction>[]);
            acc[fmtDate]!.add(transaction); 

            return acc;
          },
        ).entries.toList();

        return GroupListView(
          sectionsCount: sections.length,
          countOfItemInSection: (section) => sections[section].value.length,
          itemBuilder: (ctx, index) {
            final transaction = sections[index.section].value[index.index];
            return TransactionCard(
              transaction: transaction,
              slidableActions: getSlideActions?.call(transaction.id) ?? [],
              onTap: () => onTransactionTap?.call(transaction),
            );
          },
          groupHeaderBuilder: (ctx, section) {
            return Padding(
              padding: const EdgeInsets.only(left: 7, bottom: 8.0),
              child: Text(
                sections[section].key,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17
                ),
              ),
            );
          },
          sectionSeparatorBuilder: (context, section) => const SizedBox(height: 10),
        );
      } 
    );
  }
}