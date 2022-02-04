import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:fi/models/app_state.sg.dart';
import 'package:fi/models/serializers.sg.dart';
import 'package:fi/models/transaction.sg.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final _dateFormat = DateFormat('y-MM-dd');

class FiClient {
  static Uri _getUrl(String suffix) {
    if (Uri.base.toString().contains('localhost')) {
      return Uri.parse('http://localhost:8080$suffix');
    }
    
    return Uri.parse('http://192.168.1.179:8080$suffix');
  }

  static Future<bool> isAuthenticated() async {
    try {
      final resp = await post(_getUrl('/transactions'));
      return resp.statusCode != 401;
    } catch(_) {
      return false;
    }
  }

  static Future<void> authenticate(String email, String password) async {
    final resp = await post(_getUrl('/login/authenticate'), body: {'email': email, 'password': password});

    if (resp.statusCode >= 400) {
      final message = json.decode(resp.body)['message'] as String;
      throw InternalServerException(message);
    }
  }

  static Future<void> updateBudget(DateTime budgetMonth, String serializedStore) async {
    final monthStr = DateFormat.M().format(budgetMonth);
    final yearStr = DateFormat.y().format(budgetMonth);

    await post(_getUrl('/budget/$yearStr/$monthStr'), body: { 'serializedStore': serializedStore });
  }

  static Future<AppState> getBudget(DateTime budgetMonth) async {
    final monthStr = DateFormat.M().format(budgetMonth);
    final yearStr = DateFormat.y().format(budgetMonth);

    final resp = await get(_getUrl('/budget/$yearStr/$monthStr'));

    if (resp.statusCode == 401) throw NotAuthenticatedException();

    if (resp.body.isEmpty) throw Exception('getBudget returned an empty response');

    final serializedStore = json.decode(resp.body);

    final deserializedState = serializers.deserializeWith(AppState.serializer, serializedStore);
    if (deserializedState == null) throw Exception('Deserialized app state is empty');

    return deserializedState;
  }    

  static Future<BuiltMap<String, Transaction>> getTransactions(
    DateTime budgetMonth,
  ) async {
    final from = DateTime(budgetMonth.year, budgetMonth.month, 1);
    final to = DateTime(budgetMonth.year, budgetMonth.month, DateTime(budgetMonth.year, budgetMonth.month+1, 0).day); // 0 gets the last day in the month

    final resp = await get(_getUrl('/transactions?from=${_dateFormat.format(from)}&to=${_dateFormat.format(to)}'));
    
    final encodedTransactions = json.decode(resp.body) as List<dynamic>;

    return BuiltMap<String, Transaction>(
      Map.fromEntries(
        encodedTransactions.map((encodedTransaction) {
          // var name = encodedTransaction['merchant'] as String;
          // name = name.replaceAll(RegExp('\d'), '');

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

 static Map<String, String> headers = {};
  static final http.Client _clientRaw = http.Client();
  static http.Client get _client {
    if (_clientRaw is BrowserClient) {
      (_clientRaw as BrowserClient).withCredentials = true;
    }

    return _clientRaw;
  }

  static Future<http.Response> get(Uri uri) async {
    final response = await _client.get(uri, headers: headers);
    // updateCookie(response);
    return response;
  }

  static Future<http.Response> post(Uri uri, { Map<String, Object> body = const {} }) async {
    final response = await _client.post(uri, body: body, headers: headers);
    // updateCookie(response);
    return response;
  }

  static Future<http.Response> delete(Uri uri) async {
    final response = await _client.delete(uri, headers: headers);
    // updateCookie(response);
    return response;
  }

  // static void updateCookie(http.Response response) {
  //   String? rawCookie = response.headers['set-cookie'];
  //   if (rawCookie != null) {
  //     int index = rawCookie.indexOf(';');
  //     headers['Cookie'] = (index == -1) ? rawCookie : rawCookie.substring(0, index);
  //   }
  // }
}

class InternalServerException implements Exception {
  final String message;
  InternalServerException(this.message);
}

class NotAuthenticatedException implements Exception { }