import 'package:built_collection/built_collection.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/pages/transactions_page/bucket_selector_page.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/root/root.actions.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/colors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:intl/intl.dart';

final sectionHeaderFormat = DateFormat.MMMd();

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return storeConnector<BuiltList<Transaction>>(
      converter: (state) => (unallocatedTransactionsSelector(state)
        .map((transactionId) => state.transactions[transactionId]!)
        .toList()
        ..sort((a, b) => a.date.compareTo(b.date)))
        .toBuiltList(),
      builder: (transactions) {

        final sections = transactions.fold<Map<String, List<Transaction>>>(
          <String, List<Transaction>>{}, 
          (acc, transaction) {
            final fmtDate = sectionHeaderFormat.format(transaction.date);
            
            acc.putIfAbsent(fmtDate, () => <Transaction>[]);
            acc[fmtDate]!.add(transaction); 

            return acc;
          },
        ).entries.toList();

        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(title: const Text('Transactions')),
          body: dispatchConnector(
            (dispatch) => Container(
              padding: const EdgeInsets.all(10),
              child: GroupListView(
                sectionsCount: sections.length,
                countOfItemInSection: (section) => sections[section].value.length,
                itemBuilder: (ctx, index) {
                  final transaction = sections[index.section].value[index.index];
                  return TransactionCard(
                    transaction: transaction,
                    slidableActions: [
                      SlidableAction(
                        onPressed: (ctx) {
                          dispatch(IgnoreTransactionAction(transaction.id));
                        },
                        label: 'Delete',
                        backgroundColor: Colors.red,
                        icon: Icons.delete
                      )
                    ],
                    onTap: () => _showAssignmentView(
                      context: context, 
                      transaction: transaction,
                      onBucketSelected: (bucketId) {
                        dispatch(AllocateTransactionAction(bucketId, transaction.id));
                        Navigator.pop(context);
                      } 
                    ),
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
              )
            ),
          )
        );
      },
    );
  }

  void _showAssignmentView({
    required BuildContext context, 
    required Transaction transaction, 
    required void Function(String) onBucketSelected,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BucketSelectorPage(
        transaction: transaction,
        onBucketSelected: onBucketSelected,
      )),
    );
    // showModalBottomSheet(
    //   context: context, 
    //   builder: (context) => TransactionAssignmentModal(transactionId),
    // );
  }
}