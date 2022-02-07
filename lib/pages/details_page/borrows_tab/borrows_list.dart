import 'package:built_collection/built_collection.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/redux/borrows/borrows.actions.dart';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BorrowsList extends StatelessWidget {
  final String bucketId;

  const BorrowsList({
    Key? key,
    required this.bucketId
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {

        // Gross, consider "flutter hooks": https://pub.dev/packages/flutter_hooks
        // potentially "async redux": https://pub.dev/packages/async_redux (with https://pub.dev/packages/provider_for_redux)

        final bucketBorrows = vm.borrows.entries
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
                        DataCell(Text(vm.items[entry.value.fromId]!.label ?? 'label')),

                        DataCell(Text(
                          '${isOutgoingMoney ? '-' : ''}\$${entry.value.amount.toStringAsFixed(2)}',
                          style: TextStyle(color: isOutgoingMoney ? Colors.red : Colors.green),
                        )),

                        DataCell(
                          IconButton(
                            onPressed: () => vm.onDeleteBorrow(entry.key),
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
      },
    );
  }


}

class _ViewModel {
  BuiltMap<String, Item> items;
  BuiltMap<String, Borrow> borrows;

  void Function(String) onDeleteBorrow;

  _ViewModel({
    required this.items,
    required this.borrows,
    required this.onDeleteBorrow,
  });

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      items: store.state.items,
      borrows: store.state.borrows,
      onDeleteBorrow: (borrowId) => store.dispatch(DeleteBorrowAction(borrowId))
    );
  }
}