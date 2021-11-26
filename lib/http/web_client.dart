import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
// import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    debugPrint('Request');
    debugPrint('url: ${data.url}');
    debugPrint('headers: ${data.headers}');
    // debugPrint('body: ${data.body}');
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    debugPrint('Response');
    debugPrint('status code: ${data.statusCode}');
    debugPrint('headers: ${data.headers}');
    debugPrint('body: ${data.body}');
    debugPrint('');
    return data;
  }
}

Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'https://f293-170-82-181-76.ngrok.io/transactions';

Future<List<Transaction>> findAll() async {
  final Response response =
      await client.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 5));

  if (response.statusCode == 200) {
    List<Transaction> transactions = Transaction.fromListJSON(response.body);
    debugPrint(transactions.toString());
    return transactions;
  } else {
    return [];
  }
}

Future<Transaction?> saveTransaction(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    'value': transaction.value,
    'contact': {
      'name': transaction.contact.name,
      'accountNumber': transaction.contact.accountNumber,
    }
  };

  final String transactionJSON = jsonEncode(transactionMap);

  final Response response = await client.post(Uri.parse(baseUrl),
      headers: {
        'Content-type': 'application/json',
        'password': '1000',
      },
      body: transactionJSON);

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);

    var contactJSON = json['contact'];
    final Transaction transaction = Transaction(
      json['value'],
      Contact(
        0,
        contactJSON['name'],
        contactJSON['accountNumber'],
      ),
    );
    return transaction;
  } else {
    return null;
  }
}
