// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import, unused_local_variable

import 'package:expense_manager/models/helpers.dart';
import 'package:expense_manager/pages/HomePage.dart';
import 'package:expense_manager/pages/add_transaction.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Starting of new application which is money manager.
void main() async {
  /// Starts materialApp here beacuse of localization bugs and issues.
  await Hive.initFlutter();
  await Hive.openBox<Map>("money");

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

/// creating myApp stateful class, this is our root.
class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// its refers our homepage of app.
      body: HomePage(),
    );
  }
}
