import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/edit_order.dart';
import 'package:sahulatapp/ui/posts/historydetailsscreen.dart';
import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/ui/posts/recent_orders_details.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({super.key});

  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  final auth = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref('OrderHistory');
  final uids = FirebaseAuth.instance.currentUser!.uid;
  Timer? timer;

  bool showRedDots = true;
  final String desired = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho) {
    // final query = ref.child(desired).orderByChild('workdone').equalTo('0');

    final query = ref.child(desired);

    return query.onValue.map((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'AddressVerification' is not null
        final filteredList = userList.values
            // .where((userData) => userData['bookingstatus'] != 'Completed')
            .toList();

        return filteredList.cast<Map<dynamic, dynamic>>();
      }

      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PostScreen()));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.grey.shade100,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        title: Text("Confirmation"),
                        content:
                            Text("Do you really want to clear all history?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Color(0xff9749ff),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              timer = Timer.periodic(
                                Duration(seconds: 2),
                                (timer) {
                                  final snackBar = SnackBar(
                                    content: Text('Deleted'),
                                    duration: Duration(seconds: 3),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              );
                              ref.child(uids).remove();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              "Clear All",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Color(0xff9749ff),
                ),
              )
            ],
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff9749ff),
                size: 22,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PostScreen()));
              },
            ),
            title: Text(
              "Order history",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff9749ff),
              ),
            ),
            elevation: 1,
            automaticallyImplyLeading: false,
            shadowColor: Colors.white,
            bottomOpacity: 10,
            backgroundColor: Colors.white,
          ),
          body: StreamBuilder(
            stream: fetchUsersWithAge(desired),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Container(
                    width: 120,
                    child: LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: Colors.black,
                      // strokeWidth: 3,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
                );
              } else if (snapshot.hasData &&
                  snapshot.data != null &&
                  (snapshot.data as List).isNotEmpty) {
                final userList = snapshot.data!;
                return ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: ((context, index) {
                      final userData = userList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HistoryDetailScreen(
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
                                  workinprogdate: userData['workprogressdate'],
                                  workinprogtime: userData['workprogresstime'],
                                  requestcanceldate:
                                      userData['requestcanceldate'],
                                  requestcanceltime:
                                      userData['requestcanceltime'],
                                  review: userData['review'],
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 4),
                            width: 50,
                            height: 80,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff9749ff),
                                    spreadRadius: 0,
                                    blurRadius: 2,
                                    // offset: Offset(0, 10), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage:
                                            AssetImage(userData['Imgpath']),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(width: 12),
                                              Text(
                                                userData['Date'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(width: 3),
                                              Text(
                                                userData['Time'],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    Expanded(
                                      flex: 2,
                                      child: PopupMenuButton(
                                        enabled: showRedDots,
                                        itemBuilder: (BuildContext context) {
                                          return <PopupMenuEntry>[
                                            if (showRedDots)
                                              PopupMenuItem(
                                                // Disable the menu item
                                                child: ListTile(
                                                  leading: Icon(
                                                    Icons.delete,
                                                    color: Color(0xff9749ff),
                                                  ),
                                                  title: Text(
                                                    "Delete",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onTap: () {
                                                    ref
                                                        .child(uids)
                                                        .child(
                                                            userData['OrderID'])
                                                        .remove();
                                                  },
                                                ),
                                              ),
                                            // PopupMenuItem(
                                            //   child: ListTile(
                                            //     leading: Icon(Icons.edit,
                                            //         color: Colors.grey),
                                            //     title: Text(
                                            //       "Edit",
                                            //       style: TextStyle(
                                            //           fontWeight:
                                            //               FontWeight.bold),
                                            //     ),
                                            //     onTap: () {
                                            //       // userData['Price']
                                            //       Navigator.push(
                                            //         context,
                                            //         MaterialPageRoute(
                                            //           builder: (context) =>
                                            //               EditOrderScreen(
                                            //             name: userData
                                            //                 ['Name'],
                                            //             address: userData
                                            //                 ['Address'],
                                            //             date: userData
                                            //                 ['Date'],
                                            //             time: userData
                                            //                 ['Time'],
                                            //             phone: userData
                                            //                 ['PhoneNo'],
                                            //             orderid: userData
                                            //                 ['OrderID'],
                                            //             userid: userData
                                            //                 ['UserID'],
                                            //             providerid: userData
                                            //                 ['providerid'],
                                            //             providername: list[
                                            //                     index]
                                            //                 ['providername'],
                                            //             expert: userData
                                            //                 ['Expert'],
                                            //           ),
                                            //         ),
                                            //       );
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Visibility(
                                                  visible: showRedDots,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: 6,
                                                        height: 6,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Container(
                                                        width: 6,
                                                        height: 6,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      SizedBox(height: 4),
                                                      Container(
                                                        width: 6,
                                                        height: 6,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          shape:
                                                              BoxShape.circle,
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
                                    SizedBox(width: 5),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                      // ListTile(
                      //   title: Text(userData['Date']),
                      //   subtitle: Text(userData['Time']),
                      // );
                    }));
              } else {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          "There is no orders",
                          style: TextStyle(fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
