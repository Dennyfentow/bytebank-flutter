import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDao {
  static const String tableSql = 'create table $_tableName('
      '$_id INTEGER PRYMARY KEY, ' // a questão do autoincrement não funciona automaticamente
      '$_name TEXT, '
      '$_accountNumber INTEGER)';

  static const String _tableName = 'contacts';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _accountNumber = 'account_number';

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = toMap(contact);
    return db.insert(_tableName, contactMap);
  }

  Map<String, dynamic> toMap(Contact contact) {
    final Map<String, dynamic> contactMap = {};
    // Assim, o SQLite fica responsável por incrementar colunas do tipo Int
    // contactMap['id'] = contact.id;
    contactMap[_name] = contact.name;
    contactMap[_accountNumber] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> findAll() async {
    Database db = await getDatabase();
    final List<Map<String, Object?>> result = await db.query(_tableName);
    List<Contact> contacts = toList(result);
    return contacts;
  }

  List<Contact> toList(List<Map<String, Object?>> result) {
    final List<Contact> contacts = [];

    for (Map<String, dynamic> row in result) {
      final Contact contact = Contact(
        row[_id] ?? -1,
        row[_name],
        row[_accountNumber],
      );
      contacts.add(contact);
    }
    return contacts;
  }
}