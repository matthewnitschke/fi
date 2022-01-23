import 'package:built_collection/built_collection.dart';
import 'package:fi/models/borrow.sg.dart';
import 'package:fi/redux/borrows/borrows.actions.dart';
import 'package:redux/redux.dart';

Reducer<BuiltMap<String, Borrow>> get borrowsReducer => combineReducers([
  TypedReducer<BuiltMap<String, Borrow>, AddBorrowAction>(_onAddBorrow),
  TypedReducer<BuiltMap<String, Borrow>, DeleteBorrowAction>(_onDeleteBorrow),
]);

BuiltMap<String, Borrow> _onAddBorrow(BuiltMap<String, Borrow> state, AddBorrowAction action) {
  return state.rebuild((b) => b
    ..[action.borrowId] = Borrow((bb) => bb
      ..fromId = action.fromId
      ..toId = action.toId
      ..amount = action.amount
    )
  );
}

BuiltMap<String, Borrow> _onDeleteBorrow(BuiltMap<String, Borrow> state, DeleteBorrowAction action) {
  return state.rebuild((b) => b
    ..removeWhere((borrowId, _) => borrowId == action.borrowId)
  );
}