import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/web_clients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatefulWidget {
  final TransactionWebClient _webClient = TransactionWebClient();

  TransactionsList({Key? key}) : super(key: key);

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    // transactions.add(Transaction(100.0, Contact(0, 'Alex', 1000)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Transaction>>(
        future: widget._webClient.findAll(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              final List<Transaction>? transactions = snapshot.data;
              if (snapshot.hasData &&
                  transactions != null &&
                  transactions.isNotEmpty) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      final Transaction? transaction = transactions[index];
                      // em caso de nulo
                      if (transaction != null) {
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const CenteredMessage('Sem Valores');
                      }
                    },
                    itemCount: transactions.length);
              }
              return const CenteredMessage(
                'Not transactions found',
                icon: Icons.warning,
              );
          }
          return const CenteredMessage('Unknow Error');
        },
      ),
    );
  }
}
