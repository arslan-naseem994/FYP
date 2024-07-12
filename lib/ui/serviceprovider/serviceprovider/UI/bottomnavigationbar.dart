// ignore_for_file: unnecessary_null_comparison

// import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/Animation/continue.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/editprofile.dart';
// import 'package:sahulatapp/ui/auth/login_screen.dart';
// import 'package:sahulatapp/ui/posts/favorite_screen.dart';
// import 'package:sahulatapp/ui/posts/four_services/home_screen.dart';
// import 'package:sahulatapp/admin/ui/support_screen/support_screen.dart';
// import 'package:sahulatapp/ui/posts/user_profile_screens/update_profile.dart';
// import 'package:sahulatapp/ui/posts/user_profile_screens/profile.dart';
// import 'package:sahulatapp/ui/posts/recent_orders.dart';
// import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Dashboard/dashboardscreen.dart';
// import 'package:sahulatapp/ui/serviceprovider/UI/orders.dart';
// import 'package:sahulatapp/admin/ui/support_screen/inbox_details.dart';
// import 'package:sahulatapp/ui/serviceprovider/UI/profile1.dart';

import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/bookings_tabs_class.dart';
// import 'package:sahulatapp/utils/utils.dart';

class HomeScreens extends StatefulWidget {
  const HomeScreens({super.key});

  @override
  State<HomeScreens> createState() => _HomeScreensState();
}

class _HomeScreensState extends State<HomeScreens> {
  final auth = FirebaseAuth.instance;
  final uids = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef = FirebaseDatabase.instance.ref('Provider');
  final databaseReference = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final userRef = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('Name');
  int myindex = 0;

  List widgeList = [
    HomeScreenTwo(),
    OrderTabs(),
    ProfilesTwo(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // This block of code will be executed when the user presses the back button
        return false;
      },
      child: Scaffold(
        // drawer: NavigationDrawer(),
        body: Center(
          child: widgeList[myindex],
        ),
        bottomNavigationBar: BottomNavigationBar(
            elevation: 20,
            enableFeedback: true,
            selectedItemColor: Color.fromARGB(255, 0, 226, 185),
            unselectedItemColor: Color(0xff9749ff),
            showUnselectedLabels: true,
            showSelectedLabels: true,
            backgroundColor: Colors.teal,
            type: BottomNavigationBarType.shifting,
            currentIndex: myindex,
            onTap: (index) {
              setState(() {
                myindex = index;

                // if (index == 0) {
                //   Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => HomeScreens()),
                //   );
                // }
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: MoveAnimation(child: Icon(Icons.home)),
                label: 'Dashboard',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu_book),
                label: 'Bookings',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              )
            ]),
      ),
    );
  }
}
