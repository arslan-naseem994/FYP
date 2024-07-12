import 'package:flutter/material.dart';
import 'package:sahulatapp/ui/splashscreens/splashscreen3.dart';

class SplashScreen2 extends StatefulWidget {
  const SplashScreen2({super.key});

  @override
  State<SplashScreen2> createState() => _SplashScreen2State();
}

class _SplashScreen2State extends State<SplashScreen2> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
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

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return SplashScreen3();
            },
          ),
        );

        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const SplashScreen3()));
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
                  'assets/images/result.png',
                  width: size.width * 0.8,
                ),
                SizedBox(height: 20),
                const Text(
                  'The best result and your \n satisfaction is our \ntop priority',
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
    ));
  }
}
