import 'dart:async';
import 'dart:convert';

import 'package:fi/client/client_interface.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/serializers.sg.dart';
import 'package:fi/redux/items/items.actions.dart';
import 'package:fi/redux/root/root.actions.dart';

import 'package:redux/redux.dart';

Timer? debouncer;

Middleware<AppState> settingsSaveMiddleware(FiClientInterface client) => (
  Store<AppState> store, 
  dynamic action, 
  NextDispatcher next,
) {

  if (action is IgnoreTransactionAction) {
    unawaited(client.ignoreTransaction(action.transactionId));
    next(action);
    return;
  }

  if (action is AllocateTransactionAction) {
    unawaited(client.assignTransactionToBudget(
      transactionId: action.transactionId,
      budgetId: store.state.budgetId!,
    ));
  }

  final before = store.state;

  next(action);

  final after = store.state;

  if (_haveSettingsChanged(before, after)) {
    debouncer?.cancel();
    debouncer = Timer(const Duration(seconds: 2), () {
      final serializedStore = json.encode(serializers.serialize(store.state));
      client.updateBudget(store.state.selectedMonth, serializedStore);
    });
  }
  

};

bool _haveSettingsChanged(AppState a, AppState b) {
  if (a.items != b.items) return true;
  if (a.transactions != b.transactions) return true;
  if (a.borrows != b.borrows) return true;
  if (a.rootItemIds != b.rootItemIds) return true;

  return false;
}