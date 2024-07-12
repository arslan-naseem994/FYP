import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/Animation/topc.dart';
import 'package:sahulatapp/firebase_services/logo_services.dart';

class LogoScreen extends StatefulWidget {
  const LogoScreen({super.key});

  @override
  State<LogoScreen> createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  LogoServices logoScreen = LogoServices();
  @override
  void initState() {
    super.initState();
    logoScreen.isLogin(context);
  }

//'assets/logo/logo.png'
// return area
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Center(
                child: TopCAnimation(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/logo/logo.png'),
              ),
            )),
            SizedBox(
              height: 20,
            ),
            TopAnimation(
              child: Text(
                "Sahulatapp",
                style: TextStyle(
                    fontFamily: 'pacifico',
                    fontStyle: FontStyle.italic,

                    // fontWeight: FontWeight.bold,
                    fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
