import 'package:fi/client/client.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/pages/login_page.dart';
import 'package:fi/redux/borrows/borrows.reducer.dart';
import 'package:fi/redux/items/items.reducer.dart';
import 'package:fi/redux/root/root.reducer.dart';
import 'package:fi/redux/settings_save.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:redux/redux.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() {
  final client = getClient();

  final store = Store<AppState>(
    (state, action) {
      final rootState = rootReducer(state, action);
      return rootState.rebuild((b) => b
        ..items = itemsReducer(rootState.items, action).toBuilder()
        ..borrows = borrowsReducer(rootState.borrows, action).toBuilder());
    },
    initialState: AppState(),
    middleware: [settingsSaveMiddleware(client)]
  );

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
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: GoogleFonts.latoTextTheme(
            ThemeData(
              brightness: Brightness.dark,
              textTheme: TextTheme(
                bodyText2: const TextStyle(fontSize: 15),
                headline5: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemeData(brightness: Brightness.dark).colorScheme.secondary
                )
              )
            ).textTheme
          ),
        ),
        themeMode: ThemeMode.dark,
        home: const LoginPage(),
        navigatorKey: navigatorKey,
      )
    );
  }
}

