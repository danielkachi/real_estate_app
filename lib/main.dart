import 'package:flutter/material.dart';
import 'package:real_estate_app/main_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Real Estate App',
      home: MainView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
