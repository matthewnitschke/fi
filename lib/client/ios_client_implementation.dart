import 'package:built_collection/built_collection.dart';
import 'package:fi/client/client_interface.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/transaction.sg.dart';

class FiClient extends FiClientInterface {
  @override
  Future<void> assignTransactionToBudget({required String transactionId, required String budgetId}) {
    throw UnimplementedError();
  }

  @override
  Future<void> authenticate(String email, String password) async { }

  @override
  Future<AppState> getBudget(DateTime budgetMonth) async => AppState();

  @override
  Future<BuiltMap<String, Transaction>> getTransactions(String budgetId) async {
    return BuiltMap<String,Transaction>();
  }

  @override
  Future<void> ignoreTransaction(String transactionId) async { }

  @override
  Future<bool> isAuthenticated() async => true;

  @override
  Future<void> updateBudget(DateTime budgetMonth, String serializedStore) async { }

}