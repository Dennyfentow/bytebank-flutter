import 'package:flutter/widgets.dart';
import 'package:http/http.dart';

void findAll() async {
  final Response response =
      await get(Uri.parse('http://192.168.8.179:8080/transactions'));
  debugPrint(response.body);
}
