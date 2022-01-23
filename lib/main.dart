import 'package:built_collection/built_collection.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/models/item.sg.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:fi/pages/main_page.dart';
import 'package:fi/redux/borrows/borrows.reducer.dart';
import 'package:fi/redux/items/items.reducer.dart';
import 'package:fi/redux/root/root.actions.dart';
import 'package:fi/redux/root/root.reducer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

void main() {
  final store = Store<AppState>(
    (state, action) {
      final rootState = rootReducer(state, action);
      return rootState.rebuild((b) => b
        ..items = itemsReducer(rootState.items, action).toBuilder()
        ..borrows = borrowsReducer(rootState.borrows, action).toBuilder());
    },
    initialState: AppState((b) => b
      ..status = AppStatus.loading
    )
  );

  Future.delayed(const Duration(seconds: 2)).then((_) {
    store.dispatch(LoadStateAction(
      items: BuiltMap<String, Item>(),
      rootItemIds: BuiltList<String>(),
      borrows: BuiltMap<String, Borrow>(),
      transactions: BuiltMap<String, Transaction>({
        'a': Transaction((b) => b
          ..merchant = 'Apple'
          ..name = 'Apple - Store'
          ..amount = 50
          ..date = DateTime.now(),
        ),
        'b': Transaction((b) => b
          ..merchant = 'Wallmart'
          ..name = 'Walmart - Literal Poop'
          ..amount = 200
          ..date = DateTime.now(),
        )
      }),
      ignoredTransactions: BuiltSet<String>(),
    ));
  });
  
  // debugPaintSizeEnabled=true;
  runApp(MyApp(
    store: store
  ));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Fi',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      )
    );
  }
}

