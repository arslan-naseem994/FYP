import 'package:flutter/material.dart';

import 'package:sahulatapp/ui/posts/user_login_signup.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';

class SplashScreen3 extends StatefulWidget {
  const SplashScreen3({super.key});

  @override
  State<SplashScreen3> createState() => _SplashScreen3State();
}

class _SplashScreen3State extends State<SplashScreen3> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: Colors.white,
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_top.png',
              width: size.width * 0.5,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/change.png',
                    width: size.width * 0.7,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'Let’s make\nAwesome changes',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Ananda',
                        height: 1.8),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 1000),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        var begin = Offset(1.0, 0.0);
                        var end = Offset.zero;
                        var curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return UserService();
                      },
                    ),
                  );

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const LoginRegScreen()));
                },
                child: Container(
                  width: 200,
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                      child: Text(
                    'GET STARTED',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              'assets/images/main_bottom.png',
              width: size.width * 0.3,
            ),
          ),
        ],
      ),
    ));
  }
}
