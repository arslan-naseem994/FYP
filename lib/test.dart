import 'package:flutter/material.dart';

class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("title"),
        ),
        body: Row(
          children: [
            Text("hihihih"),
            SizedBox(
              width: 12,
            ),
            Text("hihihih")
          ],
        ));
  }
}
