// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/user/four_services/electrician.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/support_screen.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:sahulatapp/user/user_profile_screens/profile.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/confirm.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/pendingbookings.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/new_booking_details_servicepro.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/profileupdate.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/editprofile.dart';
import 'package:sahulatapp/utils/utils.dart';

class OrdersScreen extends StatefulWidget {
  final bool showAppBar;
  const OrdersScreen({super.key, required this.showAppBar});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
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
  final String desired = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ref.onValue.drain();

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
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const HomeScreens()));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: widget.showAppBar
              ? AppBar(
                  elevation: 0,
                  shadowColor: Color.fromARGB(255, 125, 60, 255),
                  automaticallyImplyLeading: false,
                  title: Text(
                    "Pending Bookings",
                    style: TextStyle(
                      color: Color(0xff9749ff),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.push(
                    //       context,
                    //       PageRouteBuilder(
                    //         transitionDuration: Duration(milliseconds: 1000),
                    //         transitionsBuilder:
                    //             (context, animation, secondaryAnimation, child) {
                    //           var begin = Offset(1.0, 0.0);
                    //           var end = Offset.zero;
                    //           var curve = Curves.ease;

                    //           var tween = Tween(begin: begin, end: end)
                    //               .chain(CurveTween(curve: curve));
                    //           return SlideTransition(
                    //             position: animation.drive(tween),
                    //             child: child,
                    //           );
                    //         },
                    //         pageBuilder: (context, animation, secondaryAnimation) {
                    //           return ProfilesTwo();
                    //         },
                    //       ),
                    //     );
                    //     //   userRef.once().then((DatabaseEvent event) {
                    //     //     String Name = 'empty';
                    //     //     DataSnapshot snapshot = event.snapshot;
                    //     //     Name = snapshot.value.toString();

                    //     //     return Name;
                    //     //   }).then((Name) {
                    //     //     if (Name == "null") {
                    //     //       Navigator.push(
                    //     //         context,
                    //     //         PageRouteBuilder(
                    //     //           transitionDuration: Duration(milliseconds: 100),
                    //     //           transitionsBuilder:
                    //     //               (context, animation, secondaryAnimation, child) {
                    //     //             var begin = Offset(1.0, 0.0);
                    //     //             var end = Offset.zero;
                    //     //             var curve = Curves.ease;

                    //     //             var tween = Tween(begin: begin, end: end)
                    //     //                 .chain(CurveTween(curve: curve));
                    //     //             return SlideTransition(
                    //     //               position: animation.drive(tween),
                    //     //               child: child,
                    //     //             );
                    //     //           },
                    //     //           pageBuilder: (context, animation, secondaryAnimation) {
                    //     //             return ProfilesScreen();
                    //     //           },
                    //     //         ),
                    //     //       );
                    //     //       // Navigator.push(
                    //     //       //     context,
                    //     //       //     MaterialPageRoute(
                    //     //       //         builder: (context) => const ProfileScreen()));
                    //     //     } else {

                    //     //       // Navigator.push(
                    //     //       //     context,
                    //     //       //     MaterialPageRoute(
                    //     //       //         builder: (context) => const ProfileTwo()));
                    //     //     }
                    //     //   });
                    //   },
                    //   icon: const Icon(Icons.account_circle),
                    // ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              : null,
          body: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: StreamBuilder(
                    stream: fetchUsersWithAge(desired),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data != null &&
                          (snapshot.data as List).isNotEmpty) {
                        final userList = snapshot.data!;
                        return ListView.builder(
                          // itemCount: snapshot.data!.snapshot.children.length,
                          // itemBuilder: ((context, index) {
                          //   final imgPath = list[index]['Imgpath'] as String?;
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
                                  boxShadow: const [
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
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Schedule:",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight:
                                                      //     FontWeight.bold
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    userData['Date'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight:
                                                      //     FontWeight.bold
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    userData['Time'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight:
                                                      //     FontWeight.bold
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 30),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color:
                                              Color.fromARGB(255, 125, 60, 255),
                                        ),
                                        const SizedBox(width: 20),
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
                          body: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                SizedBox(height: 20),
                                Text(
                                  "There is no new booking",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}














// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:sahulatapp/ui/serviceprovider/UI/orders_details.dart';

// class OrdersScreen extends StatefulWidget {
//   const OrdersScreen({super.key});

//   @override
//   State<OrdersScreen> createState() => _OrdersScreenState();
// }

// class _OrdersScreenState extends State<OrdersScreen> {
//   final uids = FirebaseAuth.instance.currentUser!.uid;
//   final ref = FirebaseDatabase.instance.ref('AllOrders');
//   final int desiredAge = 10;
//   @override
//   Widget build(BuildContext context) {
//     Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(int price) {
//       final query = ref.orderByChild('Price').equalTo('10');

//       return query.onValue.map((event) {
//         final dataSnapshot = event.snapshot;
//         final userList = dataSnapshot.value ?? {};

//         if (userList is Map<dynamic, dynamic>) {
//           return userList.values.toList().cast<Map<dynamic, dynamic>>();
//         }

//         return [];
//       });
//     }

//     return Scaffold(
//       body: Column(
//         children: [
//           StreamBuilder(
//             stream: fetchUsersWithAge(desiredAge),
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 final userList = snapshot.data!;

//                 return ListView.builder(
//                   itemCount: userList.length,
//                   itemBuilder: (context, index) {
//                     final userData = userList[index];
//                     final imgPath = userData['Imgpath'] as String?;

//                     return GestureDetector(
//                       onTap: () {
//                         // Navigate to new screen with selected item's data
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => OrderDetailScreen(
//                               name: userData['ServiceName'],
//                               date: userData['Date'],
//                               price: userData['Price'],
//                               imagePath: userData['Imgpath'],
//                               address: userData['Address'],
//                               userid: userData['UserID'],
//                               orderid: userData['OrderID'],
//                             ),
//                           ),
//                         );
//                       },
//                       child: Container(
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 12),
//                         width: 50,
//                         height: 80,
//                         decoration: BoxDecoration(
//                           boxShadow: const [
//                             BoxShadow(
//                               color: Colors.blueGrey,
//                               spreadRadius: 2,
//                               blurRadius: 15,
//                               offset: Offset(0, 10),
//                             ),
//                           ],
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               children: [
//                                 Expanded(
//                                   flex: 2,
//                                   child: CircleAvatar(
//                                     radius: 35,
//                                     backgroundImage: imgPath != null
//                                         ? AssetImage(imgPath)
//                                         : const AssetImage(
//                                             'assets/placeholder.png'),
//                                   ),
//                                 ),
//                                 SizedBox(width: 10),
//                                 Expanded(
//                                   flex: 6,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         userData['OrderID'],
//                                         style: const TextStyle(
//                                           fontSize: 17,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                       Text(userData['Address']),
//                                     ],
//                                   ),
//                                 ),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Text(
//                                     userData['Price'] + '\$',
//                                     style: const TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Text('Error: ${snapshot.error}');
//               } else {
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



