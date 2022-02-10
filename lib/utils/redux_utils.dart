
import 'package:fi/models/app_state.sg.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';

typedef DispatchFunction = dynamic Function(dynamic);

StoreConnector dispatchConnector(
  Widget Function(DispatchFunction dispatch) builder,
) {
  return StoreConnector<AppState, DispatchFunction>(
    converter: (store) => store.dispatch,
    builder: (_, dispatch) => builder(dispatch)
  );
}

StoreConnector storeConnector<T>({
  required T Function(AppState) converter,
  required Widget Function(T) builder
}) {
  return StoreConnector<AppState, T>(
    converter: (store) => converter(store.state),
    builder: (ctx, val) => builder(val),
  );
}

StoreConnector storeConnectorWithCtx<T>({
  required T Function(AppState) converter,
  required Widget Function(BuildContext, T) builder
}) {
  return StoreConnector<AppState, T>(
    converter: (store) => converter(store.state),
    builder: builder,
  );
}

T useSelector<T>(BuildContext context, T Function(AppState) converter) =>  converter(StoreProvider.of<AppState>(context).state);


DispatchFunction useDispatch<T>(BuildContext context) => StoreProvider.of<AppState>(context).dispatch;