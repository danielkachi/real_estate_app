import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.tab}) : super(key: key);

  final int tab;

  @override
  State<ProfileScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("PROFILE SCREEN"),
    );
  }
}
