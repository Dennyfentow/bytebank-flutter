import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [], // lista vazia em caso de não haver nada
        future: Future.delayed(const Duration(seconds: 1))
            .then((value) => findAll()),
        builder: (context, snapshot) {
          final List<Contact>? contacts = snapshot.data;
          if (contacts != null) {
            // em caso de nulo
            return ListView.builder(
              itemBuilder: (context, index) {
                final Contact contact = contacts[index];
                return _ContactItem(contact);
              },
              itemCount: contacts.length,
            );
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircularProgressIndicator(),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => const ContactForm()))
              .then((newContact) => debugPrint('$newContact'));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  const _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: Text(contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16)),
    ));
  }
}
