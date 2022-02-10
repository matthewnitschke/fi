import 'package:built_collection/built_collection.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/transaction.sg.dart';

abstract class FiClientInterface {
  Future<bool> isAuthenticated();
  
  Future<void> authenticate(String email, String password);

  Future<void> updateBudget(DateTime budgetMonth, String serializedStore);

  Future<AppState> getBudget(DateTime budgetMonth);

  Future<BuiltMap<String, Transaction>> getTransactions(String budgetId);

  Future<void> ignoreTransaction(String transactionId);

  Future<void> assignTransactionToBudget({
    required String transactionId, 
    required String budgetId,
  });
}

class InternalServerException implements Exception {
  final String message;
  InternalServerException(this.message);
}

class NotAuthenticatedException implements Exception { }