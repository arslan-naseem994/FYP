// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/Animation/continue.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/leftc.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/rightc.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/Animation/topc.dart';
import 'package:sahulatapp/chatscreen.dart';
import 'package:sahulatapp/providerchat.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/completed.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/user/four_services/electrician.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/support_screen.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:sahulatapp/user/user_profile_screens/profile.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/cancel.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/confirm.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/pendingbookings.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/new_booking_details_servicepro.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/profileupdate.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/editprofile.dart';
import 'package:sahulatapp/utils/utils.dart';

class HomeScreenTwo extends StatefulWidget {
  const HomeScreenTwo({super.key});

  @override
  State<HomeScreenTwo> createState() => _HomeScreenTwoState();
}

class _HomeScreenTwoState extends State<HomeScreenTwo> {
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
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final ref2 = FirebaseDatabase.instance.ref('CancelTable');
  final ref3 = FirebaseDatabase.instance.ref('ConfirmTable');
  final String desired = FirebaseAuth.instance.currentUser!.uid;

  int pendingbooking = 0;
  int completedbooking = 0;
  int confirmbooking = 0;

  @override
  void initState() {
    super.initState();
//pending booking
    ref.orderByChild('providerid').equalTo(desired).onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'
        final filteredList = userList.values
            .where((userData) => userData['bookingstatus'] == 'Pending')
            .toList();
        setState(() {
          pendingbooking = filteredList.length;
        });
      } else {
        setState(() {
          pendingbooking = 0;
        });
      }
    });

//completed booking
    ref.orderByChild('providerid').equalTo(desired).onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'
        final filteredList = userList.values
            .where((userData) => userData['bookingstatus'] == 'Completed')
            .toList();
        setState(() {
          completedbooking = filteredList.length;
        });
      } else {
        setState(() {
          completedbooking = 0;
        });
      }
    });
//confirm bookin
    ref.orderByChild('providerid').equalTo(desired).onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'
        final filteredList = userList.values
            .where((userData) => userData['bookingstatus'] == 'Confirmed')
            .toList();
        setState(() {
          confirmbooking = filteredList.length;
        });
      } else {
        setState(() {
          confirmbooking = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    ref.onValue.drain();
    ref2.onValue.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho) {
      final query = ref.orderByChild('providerid').equalTo(desired);

      return query.onValue.map((event) {
        final dataSnapshot = event.snapshot;
        final userList = dataSnapshot.value ?? {};

        if (userList is Map<dynamic, dynamic>) {
          // Filter the userList to get only the entries where 'AddressVerification' is not null
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Pending')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }

        return [];
      });
    }

    return WillPopScope(
      onWillPop: () async {
        // This block of code will be executed when the user presses the back button
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            shadowColor: Color.fromARGB(255, 125, 60, 255),
            automaticallyImplyLeading: false,
            title: Text(
              "Dashboard",
              style: TextStyle(
                color: Color(0xff9749ff),
              ),
            ),
            backgroundColor: Colors.white,
            actions: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProviderChatScreenDetails()));
                },
                child: Icon(
                  Icons.chat,
                  color: Color(0xff9749ff),
                  size: 35,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const OrdersScreen(
                                          showAppBar: true,
                                        )));
                          },
                          child: LeftCAnimation(
                            child: Container(
                              height: 140,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //     child: Text(
                                  //   'Confirm',
                                  //   style: TextStyle(color: Colors.white),
                                  // )),
                                  Center(
                                    child: Text('$pendingbooking',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        LeftAnimation(child: Text('Pending'))
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ConfirmScreen(
                                          showAppBar: true,
                                        )));
                          },
                          child: TopCAnimation(
                            child: Container(
                              height: 140,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //     child: Text(
                                  //   'Confirm',
                                  //   style: TextStyle(color: Colors.white),
                                  // )),
                                  Center(
                                    child: Text('$confirmbooking',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TopAnimation(child: Text('Confirm'))
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CompletedScreen(
                                          showAppBar: true,
                                        )));
                          },
                          child: RightCAnimation(
                            child: Container(
                              height: 140,
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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Expanded(
                                  //     child: Text(
                                  //   'Confirm',
                                  //   style: TextStyle(color: Colors.white),
                                  // )),
                                  Center(
                                    child: Text('$completedbooking',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RightAnimation(child: Text('Completed'))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                LeftAnimation(
                  child: Text("New bookings",
                      style: TextStyle(
                          fontSize: 25,
                          color: Color(0xff9749ff),
                          fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: StreamBuilder(
                    // stream: ref.onValue,
                    stream: fetchUsersWithAge(desired),
                    // builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    //   if (snapshot.hasData &&
                    //       snapshot.data!.snapshot.value != null &&
                    //       snapshot.data!.snapshot.value
                    //           is Map<dynamic, dynamic>) {
                    //     Map<dynamic, dynamic> map =
                    //         snapshot.data!.snapshot.value as dynamic;
                    //     List<dynamic> list = [];

                    //     list = map.values.toList();
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: SizedBox(
                            width: 120,
                            child: LinearProgressIndicator(
                              minHeight: 5,
                              backgroundColor: Colors.black,
                              // strokeWidth: 3,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.blue),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data != null &&
                          (snapshot.data as List).isNotEmpty) {
                        final userList = snapshot.data!;
                        return ListView.builder(
                          // istemCount: snapshot.data!.snapshot.children.length,
                          itemCount: userList.length,
                          itemBuilder: ((context, index) {
                            final userData = userList[index];
                            final imgPath = userData['Imgpath'] as String?;
                            return GestureDetector(
                              onTap: () {
                                // Navigate to new screen with selected item's data
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderDetailScreen(
                                      // name: userData['ServiceName'],
                                      // names: userData['Name'],
                                      // date: userData['Date'],
                                      // price: userData['Price'],
                                      // imagePath: userData['Imgpath'],
                                      // address: userData['Address'],
                                      // // userid: list[index]['UserID'],
                                      // userid: userData['UserID'],
                                      // orderid: userData['OrderID'],
                                      // providerid: userData['providerid']

                                      providerid: userData['providerid'],
                                      userid: userData['UserID'],
                                      phone: userData['PhoneNo'],
                                      CustomerName: userData['Name'],
                                      ProviderName: userData['providername'],
                                      ServiceName: userData['ServiceName'],
                                      img: userData['Imgpath'],
                                      Time: userData['Time'],
                                      Date: userData['Date'],
                                      Address: userData['Address'],
                                      Expert: userData['Expert'],
                                      OrderID: userData['OrderID'],
                                      Price: userData['Price'],
                                      requestSubmit: userData['RequestSubmit'],
                                      requestAccept: userData['RequestAccept'],
                                      workInProgress: userData['Workinprog'],
                                      workdone: userData['workdone'],
                                      requestacceptdate:
                                          userData['RequestAcceptedDate'],
                                      requestaccepttime:
                                          userData['RequestAcceptedTime'],
                                      bookingstatus: userData['bookingstatus'],
                                      requestsubmitdate:
                                          userData['requestsubmitdate'],
                                      requestsubmittime:
                                          userData['requestsubmittime'],
                                      workdonedate: userData['workdonedate'],
                                      workdonetime: userData['workdonetime'],
                                      requestcancel: userData['Requestcancel'],
                                      workinprogdate:
                                          userData['workprogressdate'],
                                      workinprogtime:
                                          userData['workprogresstime'],
                                      requestcanceldate:
                                          userData['requestcanceldate'],
                                      requestcanceltime:
                                          userData['requestcanceltime'],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 12),
                                width: 50,
                                height: 80,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 208, 184, 255),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 9),
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 2,
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundImage: imgPath != null
                                                ? AssetImage(imgPath)
                                                : const AssetImage(
                                                    'assets/placeholder.png'),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Booking ID: ${userData['OrderID']}",
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Schedule:",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    userData['Date'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    userData['Time'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              Color.fromARGB(255, 125, 60, 255),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      } else {
                        return Scaffold(
                          body: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Center(
                                child: Text(
                                  "There is no new booking",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
