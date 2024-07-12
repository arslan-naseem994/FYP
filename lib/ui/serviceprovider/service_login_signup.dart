import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/first_signup.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';
import 'auth/service_login_screen.dart';

class ServiceLoginReg extends StatefulWidget {
  const ServiceLoginReg({super.key});

  @override
  State<ServiceLoginReg> createState() => _ServiceLoginRegState();
}

class _ServiceLoginRegState extends State<ServiceLoginReg> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserService()));
        return true;
      },
      child: Scaffold(
          body: SafeArea(
        child: Container(
          color: Colors.white,
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: LeftAnimation(
                  child: Image.asset(
                    'assets/images/main_top.png',
                    width: size.width * 0.35,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TopAnimation(
                          child: const Text(
                            "WELCOME TO SAHULAT",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color.fromARGB(255, 219, 99, 255)),
                          ),
                        ),
                        SizedBox(height: size.height * 0.04),
                        LeftAnimation(
                          child: Image.asset(
                            'assets/images/serviceproviderloginsignup.jpg',
                            height: size.height * 0.30,
                          ),
                        ),
                        SizedBox(height: size.height * 0.06),
                        LeftAnimation(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff9749ff),
                                  elevation: 12,
                                  minimumSize: Size(270, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const ServiceLoginScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text("Login")),
                        ),
                        const SizedBox(height: 20),
                        RightAnimation(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  minimumSize: Size(270, 50),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return const FirstServiceSignUpScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(color: Colors.black),
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: LeftAnimation(
                  child: Image.asset(
                    'assets/images/main_bottom.png',
                    width: size.width * 0.2,
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

/*SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "WELCOME TO MY APP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.05),
            SvgPicture.asset(
              'assets/icons/chat.svg',
              height: size.height * 0.5,
            ),
            SizedBox(height: size.height * 0.05),
            RoundButton(
              title: 'Login',
              ontap: () {},
            ),
            RoundButton(
              title: 'Login',
              ontap: () {},
            ),
          ],
        ),
      ), */
