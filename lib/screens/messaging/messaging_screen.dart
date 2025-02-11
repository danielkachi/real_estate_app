import 'package:flutter/material.dart';

class MessagingScreen extends StatefulWidget {
  const MessagingScreen({Key? key, required this.tab}) : super(key: key);

  final int tab;

  @override
  State<MessagingScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<MessagingScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("MESSAGING SCREEN"),
    );
  }
}
