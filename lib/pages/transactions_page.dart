import 'package:built_collection/built_collection.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/colors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({
    Key? key
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return storeConnector<BuiltList<MapEntry<String, Transaction>>>(
      converter: (state) => (unallocatedTransactionsSelector(state)
        .map((transactionId) => MapEntry(transactionId, state.transactions[transactionId]!))
        .toList()
        ..sort((a, b) => a.value.date.compareTo(b.value.date)))
        .toBuiltList(),
      builder: (transactions) {
        return Scaffold(
          backgroundColor: background,
          appBar: AppBar(title: const Text('Transactions')),
          body: Container(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                final transaction = transactions[index];

                return TransactionCard(
                  transaction: transaction.value,
                  onTap: () => _showAssignmentView(context, transaction.key),
                );
              }
            )
          )
        );
      },
    );
  }

  void _showAssignmentView(BuildContext context, String transactionId) {
    showModalBottomSheet(
      context: context, 
      builder: (context) => TransactionAssignmentModal(transactionId),
    );
  }
}

final _formKey = GlobalKey<FormBuilderState>();
class TransactionAssignmentModal extends StatefulWidget {
  final String transactionId;
  const TransactionAssignmentModal(this.transactionId, { Key? key }) : super(key: key);

  @override
  TransactionAssignmentModalState createState() => TransactionAssignmentModalState(transactionId);
}

class TransactionAssignmentModalState extends State<TransactionAssignmentModal> {
  final String transactionId;

  TransactionAssignmentModalState(this.transactionId);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return storeConnector<BuiltList<MapEntry<String, Bucket>>>(
        converter: (state) => state.items.entries
          .where((itemEntry) => itemEntry.value is Bucket)
          .map((ent) => MapEntry(ent.key, ent.value as Bucket))
          .toBuiltList(),
        builder: (items) {
          return Container(
            height: 225,
            padding: const EdgeInsets.all(25),
            child: FormBuilder(
              key: _formKey,
              child: Column(children: [
                FormBuilderDropdown<String>(
                  name: 'item',
                  decoration: const InputDecoration(labelText: 'Bucket'),
                  hint: const Text('Select a Bucket'),
                  items: items.map((item) => DropdownMenuItem(
                    value: item.key, 
                    child: Text(item.value.label ?? '<no label set>'),
                  )).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: OutlinedButton(
                    onPressed: () {
                      final itemId = _formKey.currentState?.fields['item']?.value as String;
                      dispatch(AllocateTransactionAction(itemId, transactionId));
                      Navigator.pop(context);
                    },
                    child: const Text('Assign Transaction')
                  )
                )
              ]),
            )
          );
        },
      );
    });
  }
}