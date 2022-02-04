import 'package:built_collection/built_collection.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/pages/transactions_page/bucket_selector_page.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/root/root.actions.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/colors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

final sectionHeaderFormat = DateFormat.MMMd();

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return storeConnector<BuiltList<String>>(
      converter: (state) => unallocatedTransactionsSelector(state).toBuiltList(),
      builder: (transactionIds) {
        return Scaffold(
          appBar: AppBar(title: const Text('Transactions')),
          body: dispatchConnector(
            (dispatch) => Container(
              padding: const EdgeInsets.all(10),
              child: TransactionListView(
                transactionIds: transactionIds,
                getSlideActions: (transactionId) => [
                  SlidableAction(
                    onPressed: (ctx) {
                      dispatch(IgnoreTransactionAction(transactionId));
                    },
                    label: 'Hide',
                    backgroundColor: Colors.yellow[600]!,
                    icon: Icons.not_interested_outlined
                  )
                ],
                onTransactionTap: (transaction) => _showAssignmentView(
                  context: context, 
                  transaction: transaction,
                  onBucketSelected: (bucketId) {
                    dispatch(AllocateTransactionAction(bucketId, transaction.id));
                    Navigator.pop(context);
                  } 
                ),
              ),
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
  }
}