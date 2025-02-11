import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key, required this.tab}) : super(key: key);

  final int tab;

  @override
  State<FavoriteScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("FAVORITE SCREEN"),
    );
  }
}
