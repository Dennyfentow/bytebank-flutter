import 'package:bytebank/http/interceptors/logging_interceptors.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

Client client = InterceptedClient.build(interceptors: [LoggingInterceptor()]);

const String baseUrl = 'https://09dc-170-82-181-76.ngrok.io/transactions';
