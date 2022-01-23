import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/bucket_group.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/root/root.actions.dart';
import 'package:fi/utils/extensions.dart';
import 'package:redux/redux.dart';

Reducer<AppState> get rootReducer => combineReducers([
  TypedReducer<AppState, LoadStateAction>(_onLoadState),
  TypedReducer<AppState, AddBucketGroupAction>(_onAddBucketGroup),
  TypedReducer<AppState, AddBucketAction>(_onAddBucket),
  TypedReducer<AppState, DeleteItemAction>(_onDeleteItem),
  TypedReducer<AppState, SelectItemAction>(_onSelectItem),
  TypedReducer<AppState, SetIsDraggingTransactionAction>(_onSetIsDraggingTransaction),
  TypedReducer<AppState, IgnoreTransactionAction>(_onIgnoreTransaction),
  TypedReducer<AppState, ReorderItemAction>(_onReorderItem),
]);

AppState _onLoadState(AppState state, LoadStateAction action) {
  return state.rebuild((b) => b
    ..items = action.items.toBuilder()
    ..rootItemIds = action.rootItemIds.toBuilder()
    ..borrows = action.borrows.toBuilder()
    ..transactions = action.transactions.toBuilder()
    ..ignoredTransactions = action.ignoredTransactions.toBuilder()
  );
}

AppState _onAddBucketGroup(AppState state, AddBucketGroupAction action) {
  return state.rebuild((b) => b
    ..rootItemIds.add(action.itemId)
  );
}

AppState _onAddBucket(AppState state, AddBucketAction action) {
  if (action.parentId == null) {
    return state.rebuild((b) => b
      ..rootItemIds.add(action.itemId)
    );
  }

  return state;
}

AppState _onDeleteItem(AppState state, DeleteItemAction action) {
  final stateBuilder = state.toBuilder();

  stateBuilder.items.remove(action.itemId);

  if (state.rootItemIds.contains(action.itemId)) {
    stateBuilder.rootItemIds.remove(action.itemId);
  }

  if (state.selectedItemId == action.itemId) {
    stateBuilder.selectedItemId = null;
  }
  
  stateBuilder.items = state.items.map((itemId, item) {
    if (item is BucketGroup && item.itemIds.contains(action.itemId)) {
      return MapEntry(
        itemId,
        item.rebuild((b) => b
          ..itemIds = item.itemIds
            .where((id) => id != action.itemId)
            .toListBuilder()
        )
      );
    }
    return MapEntry(itemId, item);
  }).toBuilder();

  return stateBuilder.build();
}

AppState _onSelectItem(AppState state, SelectItemAction action) {
  String? itemId = action.itemId;

  // if we are trying to select the same item, toggle it off
  if (state.selectedItemId == itemId) {
    itemId = null;
  }

  return state.rebuild((b) => b
    ..selectedItemId = itemId
  );
}

AppState _onSetIsDraggingTransaction(AppState state, SetIsDraggingTransactionAction action) {
  return state.rebuild((b) => b
    ..isDraggingTransaction = action.isDragging
  );
}

AppState _onIgnoreTransaction(AppState state, IgnoreTransactionAction action) {
  return state.rebuild((b) => b
    ..ignoredTransactions.add(action.transactionId)
  );
}

AppState _onReorderItem(AppState state, ReorderItemAction action) {
  if (state.rootItemIds.contains(action.itemId)) {

    final index = state.rootItemIds.indexOf(action.itemId);

    final newRootItemIds = state.rootItemIds.toBuilder();
    newRootItemIds.reorder(index, action.delta);

    return state.rebuild((b) => b
      ..rootItemIds = newRootItemIds
    );
  }

  return state;
}