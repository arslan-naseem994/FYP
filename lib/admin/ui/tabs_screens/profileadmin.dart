import 'package:flutter/material.dart';

class TabOne3 extends StatefulWidget {
  const TabOne3({super.key});

  @override
  State<TabOne3> createState() => _TabOne3State();
}

class _TabOne3State extends State<TabOne3> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Profile")),
    );
  }
}
