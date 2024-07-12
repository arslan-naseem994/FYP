import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/continue.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/booking.dart';
import 'package:sahulatapp/admin/ui/pendingregis/pending_registration.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/user/users.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/workers.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/service_login_screen.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';
import 'package:sahulatapp/utils/utils.dart';

class TabOne extends StatefulWidget {
  const TabOne({super.key});

  @override
  State<TabOne> createState() => _TabOneState();
}

class _TabOneState extends State<TabOne> {
  int totalUsers = 0;
  int workers = 0;
  int totalorders = 0;
  int pendingRegistration = 0;

  final userRef = FirebaseDatabase.instance.ref('User');
  final workerRef = FirebaseDatabase.instance.ref('Provider');
  final totalOrdersRef = FirebaseDatabase.instance.ref('AllOrders');
  final pendingRegistrationRef = FirebaseDatabase.instance.ref('Provider');
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
//Pending Registration
    pendingRegistrationRef
        .orderByChild('verified')
        .equalTo('false')
        .onValue
        .listen((event) {
      final registration = event.snapshot.value as Map<dynamic, dynamic>?;
      if (registration != null) {
        setState(() {
          pendingRegistration = registration.length;
        });
      } else {
        setState(() {
          pendingRegistration = 0;
        });
      }
    }, onError: (error) {
      // Handle error if any
    });
//Total users
    userRef.onValue.listen((event) {
      final users = event.snapshot.value as Map<dynamic, dynamic>?;
      if (users != null) {
        setState(() {
          totalUsers = users.length;
        });
      } else {
        setState(() {
          totalUsers = 0;
        });
      }
    }, onError: (error) {
      // Handle error if any
    });

//Workers
    workerRef.onValue.listen((event) {
      final users = event.snapshot.value as Map<dynamic, dynamic>?;
      if (users != null) {
        setState(() {
          workers = users.length;
        });
      } else {
        setState(() {
          workers = 0;
        });
      }
    }, onError: (error) {
      // Handle error if any
    });
//Total Orders
    totalOrdersRef.onValue.listen((event) {
      final users = event.snapshot.value as Map<dynamic, dynamic>?;
      if (users != null) {
        setState(() {
          totalorders = users.length;
        });
      } else {
        setState(() {
          totalorders = 0;
        });
      }
    }, onError: (error) {
      // Handle error if any
    });
  }

//other UI Content
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
//Total users container
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UsersScreen()));
                    },
                    child: MoveAnimation(
                      child: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 208, 184, 255),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 13),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Users",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '$totalUsers',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
//Total Workers container
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WorkersScreen()));
                    },
                    child: MoveAnimation(
                      child: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 208, 184, 255),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 13),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Workers",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '$workers',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
//Total bookings container
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const OrdersScreen()));
                    },
                    child: MoveAnimation(
                      child: Container(
                        height: 100,
                        width: 80,
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 208, 184, 255),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 13),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15),
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  "Bookings",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '$totalorders',
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const PendingRegistrationScreen()));
              },
              child: LeftAnimation(
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 208, 184, 255),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 13),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
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
                  height: 130,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 5,
                          child: Center(
                            child: Text(
                              "Pending \nRegistrations",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        //  SizedBox(width: 40),
                        Expanded(
                          flex: 4,
                          child: Center(
                            child: Text(
                              '$pendingRegistration',
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          //Reviews Container
          // Center(
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) =>
          //                   const PendingRegistrationScreen()));
          //     },
          //     child: Container(
          //       decoration: BoxDecoration(
          //           boxShadow: const [
          //             BoxShadow(
          //               color: Color.fromARGB(255, 208, 184, 255),
          //               spreadRadius: 0,
          //               blurRadius: 10,
          //               offset: Offset(0, 13),
          //             ),
          //           ],
          //           borderRadius: BorderRadius.circular(15),
          //           gradient: LinearGradient(
          //               // stops: [0.6, 0.5],

          //               // begin: Alignment.topRight,
          //               // end: Alignment.bottomLeft,
          //               begin: FractionalOffset(0.2, 0.4),
          //               end: FractionalOffset(1.0, 1.0),
          //               colors: [
          //                 Color.fromARGB(255, 164, 119, 255),
          //                 Color.fromARGB(255, 125, 60, 255),
          //                 // Color.fromARGB(255, 0, 255, 94),
          //               ])),
          //       height: 130,
          //       width: 300,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           crossAxisAlignment: CrossAxisAlignment.center,
          //           children: [
          //             Expanded(
          //               flex: 5,
          //               child: Center(
          //                 child: Text(
          //                   "Reviews",
          //                   style: TextStyle(
          //                       fontSize: 20,
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //             //  SizedBox(width: 40),
          //             Expanded(
          //               flex: 4,
          //               child: Center(
          //                   child: Icon(
          //                 Icons.arrow_forward_ios,
          //                 color: Colors.white,
          //               )),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
//Logout Button
          SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 238, 237, 237),
                    foregroundColor: const Color.fromARGB(
                        255, 50, 0, 119), // Change the button text color
                    textStyle: const TextStyle(
                        fontSize: 15), // Change the button text size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Change button border radius
                    ),
                  ),
                  onPressed: () {
                    auth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserService()));
                      final snackBar = SnackBar(
                        content: Text('Logout'),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text("Logout")),
            ],
          )
        ],
      ),
    ));
  }
}
