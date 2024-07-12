import 'package:flutter/material.dart';

import 'splashscreen2.dart';

class SplashScreen1 extends StatefulWidget {
  const SplashScreen1({super.key});

  @override
  State<SplashScreen1> createState() => _SplashScreen1State();
}

class _SplashScreen1State extends State<SplashScreen1> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      // child: GestureDetector(
      //   onPanUpdate: (details) {
      //     // Swiping in right direction.
      //     if (details.delta.dx > 0) {
      //       Navigator.push(
      //         context,
      //         PageRouteBuilder(
      //           transitionDuration: Duration(milliseconds: 1000),
      //           transitionsBuilder:
      //               (context, animation, secondaryAnimation, child) {
      //             var begin = Offset(1.0, 0.0);
      //             var end = Offset.zero;
      //             var curve = Curves.ease;

      //             var tween = Tween(begin: begin, end: end)
      //                 .chain(CurveTween(curve: curve));
      //             return SlideTransition(
      //               position: animation.drive(tween),
      //               child: child,
      //             );
      //           },
      //           pageBuilder: (context, animation, secondaryAnimation) {
      //             return SplashScreen2();
      //           },
      //         ),
      //       );
      //     }

      //     // Swiping in left direction.
      //     if (details.delta.dx < 0) {
      //       Navigator.push(
      //         context,
      //         PageRouteBuilder(
      //           transitionDuration: Duration(milliseconds: 1500),
      //           transitionsBuilder:
      //               (context, animation, secondaryAnimation, child) {
      //             var begin = Offset(1.0, 0.0);
      //             var end = Offset.zero;
      //             var curve = Curves.ease;

      //             var tween = Tween(begin: begin, end: end)
      //                 .chain(CurveTween(curve: curve));
      //             return SlideTransition(
      //               position: animation.drive(tween),
      //               child: child,
      //             );
      //           },
      //           pageBuilder: (context, animation, secondaryAnimation) {
      //             return SplashScreen2();
      //           },
      //         ),
      //       );
      //     }
      //   },
      child: Scaffold(
          body: InkWell(
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
                return SplashScreen2();
              },
            ),
          );
        },
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
                child: Image.asset(
                  'assets/images/main_top.png',
                  width: size.width * 0.5,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/friend.jpg',
                    width: size.width * 0.8,
                  ),
                  SizedBox(height: 20),
                  const Text(
                    'We provide \n professional service \n at a friendly price',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        // fontFamily: 'Ananda',
                        height: 1.8),
                    textAlign: TextAlign.center,
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
        ),
      )),
    );
  }
}
