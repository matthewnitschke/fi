import 'package:fi/redux/borrows/borrows.actions.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:flutter/material.dart';

class BorrowsList extends StatelessWidget {
  final String bucketId;

  const BorrowsList({
    Key? key,
    required this.bucketId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borrows = useSelector(context, (state) => state.borrows);
    final items = useSelector(context, (state) => state.items);
    final dispatch = useDispatch(context);

    final bucketBorrows = borrows.entries
      .where((ent) => ent.value.toId == bucketId || ent.value.fromId == bucketId);

    if (bucketBorrows.isEmpty) return const Center(child: Text('No Content'));

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Current Borrows',
              style: Theme.of(context).textTheme.headline6,
            ),
            DataTable(
              columns: const [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  numeric: true,
                  label: Text(
                    'Amount',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    '',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
              rows: bucketBorrows.map((entry) {
                final isOutgoingMoney = entry.value.fromId == bucketId;
                return DataRow(
                  cells: [
                    DataCell(Text(items[entry.value.fromId]!.label ?? 'label')),

                    DataCell(Text(
                      '${isOutgoingMoney ? '-' : ''}\$${entry.value.amount.toStringAsFixed(2)}',
                      style: TextStyle(color: isOutgoingMoney ? Colors.red : Colors.green),
                    )),

                    DataCell(
                      IconButton(
                        onPressed: () => dispatch(DeleteBorrowAction(entry.key)),
                        icon: const Icon(
                          Icons.delete,
                          size: 17
                        )
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        ),
      )
    ); 
  }
}
