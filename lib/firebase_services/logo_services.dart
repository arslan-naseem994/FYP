import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/home_screen.dart';
import 'package:sahulatapp/ui/introscreens/intro.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/address_varification.dart';
import 'package:sahulatapp/ui/splashscreens/splashscreen1.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/utils/utils.dart';

class LogoServices {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;


    if (user == null) {
      // auth.signOut();
      Timer(const Duration(seconds: 3), () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
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
              return const IntroScreenCustomConfigState();
            },
          ),
        );

      });
    } else {
      {
        String? userId = FirebaseAuth.instance.currentUser!.uid;
        final userRef = FirebaseDatabase.instance
            .ref('Allusers')
            .child(FirebaseAuth.instance.currentUser!.uid)
            .child('Role');
        userRef.once().then((DatabaseEvent event) {
          String ROLE = 'empty';
          DataSnapshot snapshot = event.snapshot;
          ROLE = snapshot.value.toString();

          return ROLE;
        }).then((ROLE) {
          if (ROLE == "provider") {
           

            final userRef = FirebaseDatabase.instance
                .ref('Provider')
                .child(userId)
                .child('AddressVerification');
            userRef.once().then((DatabaseEvent event) {
              String verfication = 'empty';
              DataSnapshot snapshot = event.snapshot;
              verfication = snapshot.value.toString();

              return verfication;
            }).then((verfication) {
              if (verfication == "null") {
                Timer(const Duration(seconds: 5), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AddressVarificationScreen()));

           
                  final snackBar = SnackBar(
                    content: Text('Please Insert Verification Code'),
                    duration: Duration(seconds: 4),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              } else {
                Timer(const Duration(seconds: 5), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeScreens()));


                  final snackBar = SnackBar(
                    content: Text('Welcome Back'),
                    duration: Duration(seconds: 5),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                });
              }
            }).onError((error, stackTrace) {
              debugPrint(error.toString());
              Utils().toastMessage(error.toString());
            });

          } else if (ROLE == "user") {
            Timer(const Duration(seconds: 5), () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const PostScreen()));

              final snackBar = SnackBar(
                content: Text('Welcome Backs'),
                duration: Duration(seconds: 2),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
         
            });
      
          } else {
            Timer(const Duration(seconds: 5), () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminDashboardScreen()));
              final snackBar = SnackBar(
                content: Text('Welcome Back'),
                duration: Duration(seconds: 2),
              );
           
            });
           
          }
        });
      }
    }
  }
}
