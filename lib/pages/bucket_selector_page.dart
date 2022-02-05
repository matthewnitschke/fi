

import 'package:built_collection/built_collection.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/utils/redux_utils.dart';
import 'package:fi/widgets/bucket_group_view.dart';
import 'package:fi/widgets/bucket_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class BucketSelectorPage extends StatelessWidget {
  final Function(String) onBucketSelected;

  final Widget? title;
  
  const BucketSelectorPage({ 
    Key? key,
    required this.onBucketSelected,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF48220),
        title: title,
      ),
      body: storeConnector<BuiltList<String>>(
        converter: (state) => state.rootItemIds, 
        builder: (rootItemIds) {
          if (rootItemIds.isEmpty) {
            return const Center(child: Text('No Content'));
          }
    
          return ListView.builder(
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
                      onTap: () => onBucketSelected(itemId)
                    );
                  } else {
                    return BucketGroupView(
                      key: Key(itemId),
                      bucketGroupId: itemId,
                      onBucketTap: onBucketSelected
                    );
                  }
                }
              );
            },
          );
        },
      )
    );
  }
}