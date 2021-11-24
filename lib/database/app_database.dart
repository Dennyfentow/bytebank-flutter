import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('create table contacts('
          'id INTEGER PRYMARY KEY, ' // a questão do autoincrement não funciona automaticamente
          'name TEXT, '
          'account_number INTEGER)');
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
    // onUpgrade: (db, oldVersion, newVersion) {
    //   // run sql code for upgrade
    // }
  );

  // return getDatabasesPath().then((dbPath) {
  //   final String path = join(dbPath, 'bytebank.db');
  //   return openDatabase(
  //     path,
  //     onCreate: (db, version) {
  //       db.execute('create table contacts('
  //           'id INTEGER PRYMARY KEY, '
  //           'name TEXT, '
  //           'account_number INTEGER)');
  //     },
  //     version: 1,
  //     // onDowngrade: onDatabaseDowngradeDelete,
  //     // onUpgrade: (db, oldVersion, newVersion) {
  //     //   // run sql code for upgrade
  //     // }
  //   );
  // });
}

Future<int> save(Contact contact) async {
  final Database db = await getDatabase();
  final Map<String, dynamic> contactMap = {};
  // Assim, o SQLite fica responsável por incrementar colunas do tipo Int
  // contactMap['id'] = contact.id;
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountNumber;
  return db.insert('contacts', contactMap);

  // return getDatabase().then((db) {
  //   final Map<String, dynamic> contactMap = {};
  //   // Assim, o SQLite fica responsável por incrementar colunas do tipo Int
  //   // contactMap['id'] = contact.id;
  //   contactMap['name'] = contact.name;
  //   contactMap['account_number'] = contact.accountNumber;
  //   return db.insert('contacts', contactMap);
  // });
}

Future<List<Contact>> findAll() async {
  Database db = await getDatabase();
  final List<Map<String, Object?>> result = await db.query('contacts');
  final List<Contact> contacts = [];

  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'] ?? -1,
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }
  return contacts;

  // return getDatabase().then((db) {
  //   return db.query('contacts').then((maps) {
  //     final List<Contact> contacts = [];
  //     for (Map<String, dynamic> map in maps) {
  //       final Contact contact = Contact(
  //         map['id'] ?? -1,
  //         map['name'],
  //         map['account_number'],
  //       );

  //       contacts.add(contact);
  //     }

  //     return contacts;
  //   });
  // });
}
