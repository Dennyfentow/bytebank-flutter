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

Future<List<Transaction>> findAll() async {
  Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

  final Response response = await client
      .get(Uri.parse('https://f293-170-82-181-76.ngrok.io/transactions'))
      .timeout(const Duration(seconds: 5));

  if (response.statusCode == 200) {
    List<Transaction> transactions = Transaction.fromListJSON(response.body);
    debugPrint(transactions.toString());
    return transactions;
  } else {
    return [];
  }
}
