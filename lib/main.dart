import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/ui/logoscreen/Logo_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor:
            Colors.white // Change this color to your desired status bar color
        ));
    return MaterialApp(
      title: 'FYP Project',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const LogoScreen(),
    );
  }
}
