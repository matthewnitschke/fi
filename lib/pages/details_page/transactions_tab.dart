
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/transaction_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TransactionsTab extends StatelessWidget {
  final Bucket bucket;
  final String bucketId;

  const TransactionsTab(this.bucket, this.bucketId, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch(context);

    return TransactionListView(
      transactionIds: bucket.transactions,
      getSlideActions: (transactionId) => [
        SlidableAction(
          onPressed: (ctx) {
            dispatch(UnallocateTransactionAction(transactionId));
          },
          label: 'Unallocate',
          backgroundColor: Colors.yellow[300]!,
          icon: Icons.assignment_return_outlined
        )
      ],
    );
  }
}