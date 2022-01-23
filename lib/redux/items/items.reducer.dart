import 'package:built_collection/built_collection.dart';
import 'package:fi/models/bucket.sg.dart';
import 'package:fi/models/bucket_group.sg.dart';
import 'package:fi/models/bucket_value.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/utils/extensions.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, Item>> get itemsReducer => combineReducers([
  TypedReducer<BuiltMap<String, Item>, AddBucketAction>(_onAddBucket),
  TypedReducer<BuiltMap<String, Item>, AddBucketGroupAction>(_onAddBucketGroup),
  TypedReducer<BuiltMap<String, Item>, SetItemLabelAction>(_onSetItemLabel),
  TypedReducer<BuiltMap<String, Item>, SetBucketValueAction>(_onSetBucketValue),
  TypedReducer<BuiltMap<String, Item>, AllocateTransactionAction>(_onAllocateTransaction),
  TypedReducer<BuiltMap<String, Item>, UnallocateTransactionAction>(_onUnallocateTransaction),
  TypedReducer<BuiltMap<String, Item>, ReorderItemAction>(_onReorderItem),
]);

BuiltMap<String, Item> _onAddBucket(BuiltMap<String, Item> state, AddBucketAction action) {
  final stateBuilder = state.toBuilder();

  stateBuilder[action.itemId] = Bucket((b) => b
    ..label = action.label
    ..value = StaticBucketValue((bv) => bv
      ..amount = 0
    )
  );

  final parentId = action.parentId;
  if (parentId != null) {
    if (state.containsKey(parentId) && state[parentId] is BucketGroup) {
      final group = stateBuilder[action.parentId] as BucketGroup;
      stateBuilder[parentId] = group.rebuild((b) => b
        ..itemIds.add(action.itemId)
      );
    } else {
      throw Exception("Provided parentId is not found, or is not a BucketGroup item");
    }
  }

  return stateBuilder.build();
}

BuiltMap<String, Item> _onAddBucketGroup(BuiltMap<String, Item> state, AddBucketGroupAction action) {
  return state.rebuild((b) => b
    ..[action.itemId] = BucketGroup((bg) => bg
      ..label = action.label
    )
  );
}

BuiltMap<String, Item> _onSetItemLabel(BuiltMap<String, Item> state, SetItemLabelAction action) {
  final item = state[action.itemId];
  if (item == null) throw Exception('Unable to set label on null item with id of ${action.itemId}');

  return state.rebuild((b) => b
    ..[action.itemId] = item.rebuild((ib) => ib
      ..label = action.label
    )
  );
}

BuiltMap<String, Item> _onSetBucketValue(BuiltMap<String, Item> state, SetBucketValueAction action) {
  final item = state[action.itemId];

  if (item == null) throw Exception('Unable to set label on null item with id of ${action.itemId}');
  if (item is! Bucket) throw Exception('Attempted to run setBucketValue on a nonBucket item');

  return state.rebuild((b) => b
    ..[action.itemId] = item.rebuild((ib) {
      return ib..value = action.value;
    })
  );
}

BuiltMap<String, Item> _onAllocateTransaction(BuiltMap<String, Item> state, AllocateTransactionAction action) {
  final item = state[action.itemId];
  if (item == null) throw Exception('Unable to set label on null item with id of ${action.itemId}');
  if (item is! Bucket) throw Exception('Attempted to run setBucketValue on a nonBucket item');

  return state.rebuild((b) => b
    ..[action.itemId] = item.rebuild((ib) {
      return ib..transactions.add(action.transactionId);
    })
  );
}

BuiltMap<String, Item> _onUnallocateTransaction(BuiltMap<String, Item> state, UnallocateTransactionAction action) {
  final stateBuilder = state.toBuilder();

  stateBuilder.updateAllValues((itemId, item) {
    if (item is Bucket && item.transactions.contains(action.transactionId)) {
      return item.rebuild((ib) => ib
        ..transactions.remove(action.transactionId)
      );
    }
    return item;
  });

  return stateBuilder.build();
}

BuiltMap<String, Item> _onReorderItem(BuiltMap<String, Item> state, ReorderItemAction action) {
  final parentItemId = state.keys.firstWhere((itemId) {
    final item = state[itemId];

    if (item is BucketGroup) {
      return item.itemIds.contains(action.itemId);
    }
    
    return false;
  }, orElse: () => '');

  if (parentItemId.isEmpty) return state;

  final parentBucket = state[parentItemId] as BucketGroup;
  final parentBucketBuilder = parentBucket.toBuilder();

  final index = parentBucket.itemIds.indexOf(action.itemId);
  parentBucketBuilder.itemIds.reorder(index, action.delta);

  return state.rebuild((b) => b
    ..[parentItemId] = parentBucketBuilder.build()
  ); 
}