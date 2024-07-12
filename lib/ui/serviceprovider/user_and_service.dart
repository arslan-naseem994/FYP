import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/Animation/topc.dart';
import 'package:sahulatapp/admin/auth/login.dart';
import 'package:sahulatapp/admin/ui/home_Screen.dart';

import 'package:sahulatapp/ui/posts/user_login_signup.dart';
import 'package:sahulatapp/ui/serviceprovider/service_login_signup.dart';

class UserService extends StatefulWidget {
  const UserService({super.key});

  @override
  State<UserService> createState() => _UserServiceState();
}

class _UserServiceState extends State<UserService> {
  final dataBaseRef = FirebaseDatabase.instance.ref('ConfirmTable');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('CancelTable');
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final ref2 = FirebaseDatabase.instance.ref('AllNotification');
  final ref5 = FirebaseDatabase.instance.ref('OrderTable');
  final ref6 = FirebaseDatabase.instance.ref('favorite');
  final ref7 = FirebaseDatabase.instance.ref('OrderHistory');
  final ref8 = FirebaseDatabase.instance.ref('Allsupport');
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        // SystemNavigator.pop();
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => const UserService()));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            body: Container(
          color: Colors.white,
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 10,
                right: 4,
                child: RightAnimation(
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry>[
                        PopupMenuItem(
                          // Disable the menu item
                          child: ListTile(
                            //leading: Icon(Icons.person, color: Colors.grey),
                            title: Text(
                              "ADMIN",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 219, 99, 255),
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              //AdminDashboardScreen
                              //AdminLoginScreen() place after making changes
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AdminLoginScreen()));
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             const AdminDashboardScreen()));
                            },
                          ),
                        ),
                        //delete all data
                        // PopupMenuItem(
                        //   // Disable the menu item
                        //   child: ListTile(
                        //     //leading: Icon(Icons.person, color: Colors.grey),
                        //     title: Text(
                        //       "DELETE ALL DATA",
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //     onTap: () {
                        //       ref.remove();
                        //       ref2.remove();
                        //       ref5.remove();
                        //       ref6.remove();
                        //       ref7.remove();
                        //       ref8.remove();
                        //       dataBaseRef.remove();
                        //       dataBaseRef2.remove();
                        //     },
                        //   ),
                        // ),
                      ];
                    },
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Visibility(
                              child: Column(
                                children: [
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 219, 99, 255),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 219, 99, 255),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Container(
                                    width: 6,
                                    height: 6,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 219, 99, 255),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 4),
                      TopAnimation(
                          child: Image.asset('assets/images/selection.png',
                              width: 350)),
                      SizedBox(height: 10),
                      TopAnimation(
                        child: const Text(
                          'Choose Your Role',
                          style: TextStyle(
                              color: Color.fromARGB(255, 219, 99, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              // fontFamily: 'Ananda',
                              height: 1.8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return LoginRegScreen();
                              },
                            ),
                          );

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginRegScreen()));
                        },
                        child: TopCAnimation(
                          child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 208, 184, 255),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 13),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: const LinearGradient(
                                      // stops: [0.6, 0.5],

                                      // begin: Alignment.topRight,
                                      // end: Alignment.bottomLeft,
                                      begin: FractionalOffset(0.2, 0.4),
                                      end: FractionalOffset(1.0, 1.0),
                                      colors: [
                                        Color.fromARGB(255, 164, 119, 255),
                                        Color.fromARGB(255, 219, 99, 255),
                                        // Color.fromARGB(255, 0, 255, 94),
                                      ])),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/user.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  const Text(
                                    'User',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                      SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return ServiceLoginReg();
                              },
                            ),
                          );

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => const LoginRegScreen()));
                        },
                        child: TopCAnimation(
                          child: Container(
                              width: 130,
                              height: 130,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 208, 184, 255),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 13),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      // stops: [0.6, 0.5],

                                      // begin: Alignment.topRight,
                                      // end: Alignment.bottomLeft,
                                      begin: FractionalOffset(0.2, 0.4),
                                      end: FractionalOffset(1.0, 1.0),
                                      colors: [
                                        Color.fromARGB(255, 164, 119, 255),
                                        Color.fromARGB(255, 125, 60, 255),
                                        // Color.fromARGB(255, 0, 255, 94),
                                      ])),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/serviceprovider.png',
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'Worker',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.5,
                                      // fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  )
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
        )),
      ),
    );
  }
}
