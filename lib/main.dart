import 'package:flutter/material.dart';

import 'package:bytebank/screens/dashboard.dart';

void main() {
  runApp(const MyApp());
  // Contact daniel = Contact(1, 'Daniel', 4000);
  // debugPrint('$daniel');
  // save(daniel).then((value) => findAll()).then((lista) => debugPrint('$lista'));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.green[900],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.blueAccent[700])),
      home: const Dashboard(),
    );
  }
}
