import 'package:fi/models/app_state.sg.dart';
import 'package:fi/pages/main_page.dart';
import 'package:fi/redux/borrows/borrows.reducer.dart';
import 'package:fi/redux/items/items.reducer.dart';
import 'package:fi/redux/root/root.reducer.dart';
import 'package:fi/redux/settings_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:redux/redux.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  final store = Store<AppState>(
    (state, action) {
      final rootState = rootReducer(state, action);
      return rootState.rebuild((b) => b
        ..items = itemsReducer(rootState.items, action).toBuilder()
        ..borrows = borrowsReducer(rootState.borrows, action).toBuilder());
    },
    initialState: AppState(),
    middleware: [settingsSaveMiddleware()]
  );

  // FiClient.getBudget(store.state.selectedMonth)
  //     .then((appState) {
  //       store.dispatch(LoadStateAction(
  //         items: appState.items,
  //         rootItemIds: appState.rootItemIds, 
  //         borrows: appState.borrows, 
  //         transactions: appState.transactions, 
  //         ignoredTransactions: appState.ignoredTransactions,
  //       ));
  //     })
  //     .catchError((err) {
  //       if (err is NotAuthenticatedException) {
  //         navigatorKey.currentState?.pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
  //       }
  //     });

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
        navigatorKey: navigatorKey,
      )
    );
  }
}

