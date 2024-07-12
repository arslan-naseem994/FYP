import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/tabs_screens/dashboardadmin.dart';
import 'package:sahulatapp/admin/ui/tabs_screens/inboxadmin.dart';
import 'package:sahulatapp/admin/ui/tabs_screens/profileadmin.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final ref = FirebaseDatabase.instance.ref('Allsupport');

  int totalmessages = 0;

  @override
  void initState() {
    super.initState();
    _messageSeen();
  }

  void _messageSeen() {
    ref.orderByChild('messageseen').equalTo('1').onValue.listen((event) {
      final users = event.snapshot.value as Map<dynamic, dynamic>?;
      if (users != null) {
        setState(() {
          totalmessages = users.length;
        });
      } else {
        setState(() {
          totalmessages = 0;
        });
      }
    }, onError: (error) {
      // Handle error if any
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(9.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        // decoration: BoxDecoration(
                        //   borderRadius: BorderRadius.circular(100),
                        //   border:
                        //       Border.all(color: Color(0xff9749ff), width: 2),
                        // ),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundImage:
                              AssetImage("assets/images/admins.jpg"),
                        ),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      flex: 6,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Arslan Nasim",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(height: 3),
                          Text("03168683835"),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminInboxScreen(
                                        totalmess: totalmessages,
                                      )),
                            );
                          },
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                              Icon(
                                Icons.mail,
                                size: 30,
                                color: Color(0xff9749ff),
                              ), // Replace with your actual mail icon
                              if (totalmessages != 0)
                                Positioned(
                                  top: 1,
                                  right: 1,
                                  child: Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
              //Divider(), // 1st row for circular image name and phone number
              Expanded(
                child: DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      TabBar(
                        labelPadding: EdgeInsets.symmetric(horizontal: 25),
                        isScrollable: true,
                        indicatorPadding: EdgeInsets.symmetric(horizontal: 14),
                        indicatorWeight: 5,
                        // Customize the TabBar appearance
                        indicatorColor:
                            Color(0xff9749ff), // Color of the tab indicator
                        labelColor: Colors.black, // Selected tab text color
                        unselectedLabelColor:
                            Colors.grey, // Unselected tab text color
                        labelStyle: TextStyle(
                          fontWeight: FontWeight
                              .bold, // Customize the font style for selected tab
                        ),
                        tabs: [
                          Tab(text: "Dashboard"),
                          Tab(text: "Inbox"),
                          // Tab(text: "Profile"),
                        ],
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Your Order Tab content
                            TabOne(),
                            // Your Confirm Tab content
                            AdminInboxScreen(totalmess: totalmessages),
                            // Your Cancel Tab content
                            // TabOne3(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ), // main column for all top to down
        ),
      ),
    );
  }
}
