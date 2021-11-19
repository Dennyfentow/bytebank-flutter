import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: const [
          Card(
              child: ListTile(
            title: Text(
              'Alex',
              style: TextStyle(fontSize: 24),
            ),
            subtitle: Text('1000', style: TextStyle(fontSize: 16)),
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
