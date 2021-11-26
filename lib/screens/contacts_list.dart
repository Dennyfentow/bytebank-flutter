import 'package:bytebank/components/progress.dart';
import 'package:bytebank/database/DAO/contact_dao.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  ContactsList({Key? key}) : super(key: key);
  final ContactDao _contactDao = ContactDao();

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: const [], // lista vazia em caso de não haver nada
        future: widget._contactDao.findAll(),
        builder: (context, snapshot) {
          final List<Contact>? contacts = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              return const Progress();
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              return ListView.builder(
                itemBuilder: (context, index) {
                  // em caso de nulo
                  final Contact? contact =
                      contacts != null ? contacts[index] : null;
                  if (contact != null) {
                    return _ContactItem(
                      contact,
                      onClick: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => TransactionForm(contact)));
                      },
                    );
                  } else {
                    return const Text('Sem valores');
                  }
                },
                itemCount: contacts != null ? contacts.length : 0,
              );
          }

          return const Text('Unknown Error');
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => const ContactForm()))
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem(
    this.contact, {
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      onTap: () => onClick(),
      title: Text(
        contact.name,
        style: const TextStyle(fontSize: 24),
      ),
      subtitle: Text(contact.accountNumber.toString(),
          style: const TextStyle(fontSize: 16)),
    ));
  }
}
