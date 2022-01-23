
import 'package:badges/badges.dart';
import 'package:built_collection/built_collection.dart';
import 'package:fi/pages/transactions_page.dart';
import 'package:fi/redux/items/items.actions.dart';
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
import 'package:fi/utils/colors.dart';


class MainPage extends StatelessWidget {
  const MainPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
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
      body: const ItemsList(),
      floatingActionButton: const RootAddButton(),
    );
  }
}

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return dispatchConnector((dispatch) {
      return storeConnector<AppStatus>(
        converter: (state) => state.status,
        builder: (status) {
          return storeConnector<BuiltList<String>>(
            converter: (state) => state.rootItemIds, 
            builder: (rootItemIds) {
              if (status == AppStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (status == AppStatus.errored) {
                return const Center(child: Text('There was a failure'));
              }

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
                        );
                      } else {
                        return BucketGroupView(
                          key: Key(itemId),
                          bucketGroupId: itemId,
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
        },
      );
    });
  }
}