import 'dart:convert';

import 'package:bytebank/http/web_client.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response = await client
        .get(Uri.parse(baseUrl))
        .timeout(const Duration(seconds: 5));

    if (response.statusCode == 200) {
      List<Transaction> transactions = _toTransactions(response);
      return transactions;
    } else {
      return [];
    }
  }

  List<Transaction> _toTransactions(Response response) {
    List<Transaction> transactions = Transaction.fromListJSON(response.body);
    debugPrint(transactions.toString());
    return transactions;
  }

  Future<Transaction?> saveTransaction(Transaction transaction) async {
    String transactionJSON = toMap(transaction);

    final Response response = await client.post(Uri.parse(baseUrl),
        headers: {
          'Content-type': 'application/json',
          'password': '1000',
        },
        body: transactionJSON);

    return toTransaction(response);
  }

  Transaction? toTransaction(Response response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);

      final contactJSON = json['contact'];
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
}
