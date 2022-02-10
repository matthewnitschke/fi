import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:fi/client/client_interface.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/serializers.sg.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:http/browser_client.dart';

class FiClient extends FiClientInterface {
  Uri _getUrl(String suffix) {
    if (Uri.base.toString().contains('localhost')) {
      return Uri.parse('http://localhost:8080$suffix');
    }
    
    return Uri.parse('http://192.168.1.179:8080$suffix');
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      final resp = await post(_getUrl('/transactions'));
      return resp.statusCode != 401;
    } catch(_) {
      return false;
    }
  }

  @override
  Future<void> authenticate(String email, String password) async {
    if (!kIsWeb) return;
    
    final resp = await post(_getUrl('/login/authenticate'), body: {'email': email, 'password': password});

    if (resp.statusCode >= 400) {
      final message = json.decode(resp.body)['message'] as String;
      throw InternalServerException(message);
    }
  }

  @override
  Future<void> updateBudget(DateTime budgetMonth, String serializedStore) async {
    final monthStr = DateFormat.M().format(budgetMonth);
    final yearStr = DateFormat.y().format(budgetMonth);

    await post(_getUrl('/budget/$yearStr/$monthStr'), body: { 'serializedStore': serializedStore });
  }

  @override
  Future<AppState> getBudget(DateTime budgetMonth) async {
    final monthStr = DateFormat.M().format(budgetMonth);
    final yearStr = DateFormat.y().format(budgetMonth);

    final resp = await get(_getUrl('/budget/$yearStr/$monthStr'));

    if (resp.statusCode == 401) throw NotAuthenticatedException();

    if (resp.body.isEmpty) throw Exception('getBudget returned an empty response');

    final serializedStore = json.decode(resp.body);

    final deserializedState = serializers.deserializeWith(AppState.serializer, serializedStore['storeData']);
    if (deserializedState == null) throw Exception('Deserialized app state is empty');

    return deserializedState.rebuild((b) => b
      ..budgetId = serializedStore['budgetId']
    );
  }    

  @override
  Future<BuiltMap<String, Transaction>> getTransactions(
    String budgetId,
  ) async {
    final resp = await get(_getUrl('/transactions/$budgetId'));
    
    final encodedTransactions = json.decode(resp.body) as List<dynamic>;

    return BuiltMap<String, Transaction>(
      Map.fromEntries(
        encodedTransactions.map((encodedTransaction) {
          return MapEntry(
            encodedTransaction['_id'] as String,
            Transaction((b) => b
              ..id = encodedTransaction['_id'] as String
              ..amount = (encodedTransaction['amount'] as num).toDouble() * -1
              ..merchant = encodedTransaction['merchantName'] ?? encodedTransaction['name'] as String
              ..name = encodedTransaction['name']
              ..date = DateTime.parse(encodedTransaction['date'] as String)
            ),
          );
        })
      )
    );
  }

  @override
  Future<void> ignoreTransaction(String transactionId) async {
    await post(_getUrl('/transactions/$transactionId/ignore'));
  }

  @override
  Future<void> assignTransactionToBudget({
    required String transactionId, 
    required String budgetId,
  }) async {
    await post(_getUrl('/transactions/$transactionId/assign/$budgetId'));
  }

  Map<String, String> headers = {};
  final http.Client _clientRaw = http.Client();
  http.Client get _client {
    if (_clientRaw is BrowserClient) {
      (_clientRaw as BrowserClient).withCredentials = true;
    }

    return _clientRaw;
  }

  Future<http.Response> get(Uri uri) async {
    return await _client.get(uri, headers: headers);
  }

  Future<http.Response> post(Uri uri, { Map<String, Object> body = const {} }) async {
    return await _client.post(uri, body: body, headers: headers);
  }

  Future<http.Response> delete(Uri uri) async {
    return await _client.delete(uri, headers: headers);
  }
}

