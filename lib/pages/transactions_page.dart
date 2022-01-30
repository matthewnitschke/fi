import 'package:built_collection/built_collection.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/root/root.actions.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/colors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/utils/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
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
          body: Container(
            padding: const EdgeInsets.all(10),
            child: GroupListView(
              sectionsCount: sections.length,
              countOfItemInSection: (section) => sections[section].value.length,
              itemBuilder: (ctx, index) {
                final transaction = sections[index.section].value[index.index];
                return TransactionCard(
                  transaction: transaction,
                  onTap: () => _showAssignmentView(context, transaction.id),
                );
              },
              groupHeaderBuilder: (ctx, section) {
                return Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 8.0),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          final itemId = _formKey.currentState?.fields['item']?.value as String;
                          dispatch(AllocateTransactionAction(itemId, transactionId));
                          Navigator.pop(context);
                        },
                        child: const Text('Assign')
                      ),
                      const SizedBox(width: 5),
                      OutlinedButton(
                        onPressed: () {
                          dispatch(IgnoreTransactionAction(transactionId));
                          Navigator.pop(context);
                        },
                        child: const Text('Ignore')
                      )
                    ],
                  )
                ),
              ]),
            )
          );
        },
      );
    });
  }
}