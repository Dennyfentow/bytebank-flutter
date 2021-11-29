import 'dart:convert';

import 'package:bytebank/http/web_client.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(baseUrl))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      final List<dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson
          .map((dynamic jsonObject) => Transaction.fromJson(jsonObject))
          .toList();
    } else {
      return [];
    }
  }

  Future<Transaction?> saveTransaction(
      Transaction transaction, String password) async {
    String transactionJSON = jsonEncode(transaction.toJson());

    final Response response = await client.post(Uri.parse(baseUrl),
        headers: {
          'Content-type': 'application/json',
          'password': password,
        },
        body: transactionJSON);

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw throwHttpError(response.statusCode);
  }

  Exception throwHttpError(int statusCode) =>
      Exception(_statusCodeResponses[statusCode]);

  String toMap(Transaction transaction) {
    final Map<String, dynamic> transactionMap = {
      'value': transaction.value,
      'contact': {
        'name': transaction.contact.name,
        'accountNumber': transaction.contact.accountNumber,
      }
    };

    final String transactionJSON = jsonEncode(transactionMap);
    return transactionJSON;
  }

  static final Map<int, String> _statusCodeResponses = {
    400: 'there was an error submitting transaction',
    401: 'authentication failed'
  };
}
