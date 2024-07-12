import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';

class IntroScreenCustomConfigState extends StatefulWidget {
  const IntroScreenCustomConfigState({super.key});

  @override
  State<IntroScreenCustomConfigState> createState() =>
      _IntroScreenCustomConfigStateState();
}

class _IntroScreenCustomConfigStateState
    extends State<IntroScreenCustomConfigState> {
  List<ContentConfig> listContentConfig = [];

  @override
  void initState() {
    super.initState();

    listContentConfig.add(
      const ContentConfig(
          styleDescription: TextStyle(color: Colors.black, fontSize: 20),
          title: "Best Service",
          description:
              "We provide \n professional service \n at a friendly price",
          pathImage: "assets/images/friend.jpg",
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          styleTitle: TextStyle(color: Color(0xff9749ff), fontSize: 20)),
    );
    listContentConfig.add(
      const ContentConfig(
          styleDescription: TextStyle(color: Colors.black, fontSize: 20),
          title: "User Satisfaction",
          description:
              "The best result and \n satisfaction is our \ntop priority",
          pathImage: "assets/images/result.png",
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          styleTitle: TextStyle(color: Color(0xff9749ff), fontSize: 20)),
    );
    listContentConfig.add(
      const ContentConfig(
          styleDescription: TextStyle(color: Colors.black, fontSize: 20),
          title: "Striving for Greatness",
          description: "Let’s make\nAwesome changes",
          pathImage: "assets/images/change.png",
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          styleTitle: TextStyle(color: Color(0xff9749ff), fontSize: 20)),
    );
  }

  void onDonePress() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
          return UserService();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 30),
              child: IntroSlider(
                curveScroll: Curves.bounceOut,
                indicatorConfig: IndicatorConfig(
                  colorActiveIndicator: Color(0xff9749ff),
                ),
                backgroundColorAllTabs: Colors.amber,
                key: UniqueKey(),
                listContentConfig: listContentConfig,
                onDonePress: onDonePress,
                renderDoneBtn: Text("Done",
                    style: TextStyle(
                      color: Colors.green,
                    )),
                renderSkipBtn: Text("Skip",
                    style: TextStyle(
                      color: Color(0xff9749ff),
                    )), // Customize skip button text and color
                renderNextBtn: Text("Next",
                    style: TextStyle(
                      color: Color(0xff9749ff),
                    )), // Customize next button text and color
                // Change the dots color
              ))),
    );
  }
}
