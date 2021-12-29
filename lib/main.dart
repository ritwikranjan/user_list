import 'package:flutter/material.dart';
import 'package:user_list/database/database_provider.dart';
import 'package:user_list/screens/user_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseProvider().database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UserScreen(),
    );
  }
}
