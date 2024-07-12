import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahulatapp/Animation/bottom.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/user/auth/signup_screen.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';

class LoginRegScreen extends StatefulWidget {
  const LoginRegScreen({Key? key});

  @override
  State<LoginRegScreen> createState() => _LoginRegScreenState();
}

class _LoginRegScreenState extends State<LoginRegScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> left_slideAnimation;
  late Animation<Offset> right_slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Create the slide animation
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, -9.0), // Start off-screen at the top
      end: const Offset(0.0, 0.0), // End at the original position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    left_slideAnimation = Tween<Offset>(
      begin: const Offset(-9.0, 0.0), // Start off-screen at the top
      end: const Offset(0.0, 0.0), // End at the original position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    right_slideAnimation = Tween<Offset>(
      begin: const Offset(9.0, 0.0), // Start off-screen at the top
      end: const Offset(0.0, 0.0), // End at the original position
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.ease,
      ),
    );

    // Start the animation when the widget is built
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

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
                                color: Color.fromARGB(255, 219, 99, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          SizedBox(height: size.height * 0.05),
                          BottomAnimation(
                            child: SvgPicture.asset(
                              'assets/icons/chat.svg',
                              height: size.height * 0.29,
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
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                              child: Text("Login"),
                            ),
                          ),
                          const SizedBox(height: 20),
                          RightAnimation(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                elevation: 10,
                                minimumSize: Size(270, 50),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
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
        ),
      ),
    );
  }
}
