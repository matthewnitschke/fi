
import 'dart:async';

import 'package:badges/badges.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fi/client.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/pages/details_page/details_page.dart';
import 'package:fi/pages/transactions_page/transactions_page.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/root/root.actions.dart';
import 'package:fi/redux/selectors.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/bucket_group_view.dart';
import 'package:fi/widgets/bucket_view.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/widgets/month_selector.dart';
import 'package:fi/widgets/root_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';


class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MonthSelector(),
        leading: storeConnector<int>(
          converter: (state) => unallocatedTransactionsSelector(state).length,
          builder: (unallocatedTransactionsCount) {
            return IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TransactionsPage()),
                );
              }, 
              icon: Badge(
                showBadge: unallocatedTransactionsCount > 0,
                badgeContent: Text(
                  unallocatedTransactionsCount.toString(),
                  style: const TextStyle(color: Colors.white)
                ),
                child: const Icon(Icons.attach_money)
              ),
            );
          }
        )
        ,
      ),
      body: StoreConnector<AppState, DateTime>(
        converter: (store) => store.state.selectedMonth,
        onInit: (store) => _handleInitBudget(store),
        builder: (context, selectedMonth) {
          return const ItemsList();
        },
      ),
      floatingActionButton: const RootAddButton(),
    );
  }

  Future<void> _handleInitBudget(Store<AppState> store) async {
    late BuiltMap<String, Transaction> transactions;
    late AppState appState;
    
    await Future.wait([
      FiClient.getTransactions(
        store.state.selectedMonth,
      ).then((resp) => transactions = resp),
      FiClient.getBudget(
        store.state.selectedMonth,
      ).then((resp) => appState = resp)
    ]);

    // on the off chance that transactionIds get borked, dont add phantom ones within items
    final filteredItems = appState.items.map((itemId, item) {
      if (item is Bucket) {
        return MapEntry(
          itemId, item.rebuild((b) => b
            ..transactions = item.transactions
              .where((transactionId) {
                return transactions.keys.contains(transactionId);
              }).toBuiltList().toBuilder()
          ),
        );
      }
      return MapEntry(itemId, item);
    });

    store.dispatch(LoadStateAction(
      items: filteredItems,
      rootItemIds: appState.rootItemIds,
      borrows: appState.borrows,
      transactions: transactions,
      ignoredTransactions: appState.ignoredTransactions
    ));
  }
}

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return storeConnector<BuiltList<String>>(
        converter: (state) => state.rootItemIds, 
        builder: (rootItemIds) {
          if (rootItemIds.isEmpty) {
            return const Center(child: Text('No Content'));
          }
    
          return ReorderableListView.builder(
            itemCount: rootItemIds.length,
            itemBuilder: (context, index) {
              final itemId = rootItemIds[index];
              return StoreConnector<AppState, Item?>(
                key: Key(itemId),
                converter: (store) => store.state.items[itemId],
                builder: (ctx, item) {
                  if (item is Bucket) {
                    return BucketView(
                      wrapWithCard: true,
                      bucketId: itemId,
                      onTap: () => _handleBucketTap(context)(itemId)
                    );
                  } else {
                    return BucketGroupView(
                      key: Key(itemId),
                      bucketGroupId: itemId,
                      onBucketTap: _handleBucketTap(context)
                    );
                  }
                }
              );
            },
            onReorder: (start, current) {
              var delta = current - start;
              delta = current > start ? delta-1 : delta;
              final itemId = rootItemIds[start];
    
              dispatch(ReorderItemAction(itemId, delta));
            },
          );
        },
      );
    });
  }

  void Function(String) _handleBucketTap(BuildContext context) => (itemId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailsPage(bucketId: itemId)),
    );
  };
}