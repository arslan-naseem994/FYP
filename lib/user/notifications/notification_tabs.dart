import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/user/notifications/notification_details.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/new_booking_details_servicepro.dart';

class NotificationTabs extends StatefulWidget {
  const NotificationTabs({super.key});

  @override
  State<NotificationTabs> createState() => _NotificationTabsState();
}

class _NotificationTabsState extends State<NotificationTabs> {
  final auth = FirebaseAuth.instance;
  final uids = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef = FirebaseDatabase.instance.ref('Provider');
  final databaseReference = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final ref = FirebaseDatabase.instance.ref('AllNotification');
  final String desired = FirebaseAuth.instance.currentUser!.uid;
  Timer? timer;
  String _showVerified = '1';

  @override
  Widget build(BuildContext context) {
    Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(
        String filter, String desired) {
      final query = ref.orderByChild('userid').equalTo(desired);

      return query.onValue.map((event) {
        final dataSnapshot = event.snapshot;
        final userList = dataSnapshot.value ?? {};

        if (userList is Map<dynamic, dynamic>) {
          if (filter == '1') {
            final filteredList = userList.values.toList();

            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (filter == '2') {
            final filteredList = userList.values
                .where((userData) =>
                    userData['notificationtype'] == 'Order Confirmed')
                .toList();

            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (filter == '3') {
            final filteredList = userList.values
                .where((userData) => userData['messageseen'] == '1')
                .toList();

            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (filter == '4') {
            final filteredList = userList.values
                .where((userData) =>
                    userData['notificationtype'] == 'Order Canceled')
                .toList();

            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (filter == '6') {
            final filteredList = userList.values
                .where((userData) =>
                    userData['notificationtype'] == 'Order Completed')
                .toList();

            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (filter == '5') {
            final filteredList = userList.values
                .where((userData) => userData['type'] == 'message')
                .toList();

            return filteredList.cast<Map<dynamic, dynamic>>();
          }
        }

        return [];
      });
    }

    void _showFilterOptions() {
      showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('All'),
                  onTap: () {
                    setState(() {
                      _showVerified = '1';
                    });

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('New'),
                  onTap: () {
                    setState(() {
                      _showVerified = '3';
                    });

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Confirmed'),
                  onTap: () {
                    setState(() {
                      _showVerified = '2';
                    });

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Canceled'),
                  onTap: () {
                    setState(() {
                      _showVerified = '4';
                    });

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Completed'),
                  onTap: () {
                    setState(() {
                      _showVerified = '6';
                    });

                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Messages'),
                  onTap: () {
                    setState(() {
                      _showVerified = '5';
                    });

                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      title: Text("Confirmation"),
                      content:
                          Text("Do you really want to clear all notification?"),
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
                            ref.remove();
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
              child: Padding(
                padding: EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.delete_sharp,
                  color: Color(0xff9749ff),
                ),
              )),
        ],
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff9749ff),
            size: 22,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Notification",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        bottomOpacity: 10,
        backgroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff9749ff),
        onPressed: _showFilterOptions,
        child: Icon(Icons.filter_list),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: fetchUsersWithAge(_showVerified, desired),
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
                  final imgPath = userData['Image'] as String?;
                  return GestureDetector(
                    onTap: () {
                      ref
                          .child(userData['notificationid'])
                          .update({'messageseen': '0'});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NotificationDetailsScreen(
                                    type: userData['type'],
                                    date: userData['date'],
                                    time: userData['time'],
                                    image: userData['image'],
                                    subject: userData['subject'],
                                    name: userData['notificationname'],
                                    price: userData['price'],
                                    allid: userData['notificationid'],
                                    usermessagge: userData['usermessage'],
                                    notificationtype:
                                        userData['notificationtype'],
                                    providerid: userData['providerid'],
                                  )));
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 1, vertical: 5),
                      width: 100,
                      height: 150,
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xff9749ff),
                              spreadRadius: 0,
                              blurRadius: 3,
                              // offset: Offset(0, 10), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    radius: 18,
                                    backgroundImage: AssetImage(
                                        'assets/images/notification.png')),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(userData['notificationtype'],
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${userData['date']} ${userData['time']}",
                                        style: TextStyle(fontSize: 10)),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 250, 243, 255),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      bottomRight: Radius.circular(30))),
                              height: 65,
                              width: 325,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1),
                                child: Row(
                                  children: [
                                    if (userData['type'] == 'message')
                                      Expanded(
                                          flex: 3,
                                          child: SizedBox(
                                              height: 60,
                                              width: 20,
                                              child: Image.asset(
                                                'assets/images/message.jpg',
                                                fit: BoxFit.fill,
                                                scale: 10,
                                              ))),
                                    if (userData['type'] == 'order')
                                      Expanded(
                                        flex: 3,
                                        child: SizedBox(
                                            height: 60,
                                            width: 20,
                                            child: Image.asset(
                                              userData['image'],
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${userData['notificationname']}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            "${userData['subject']}",
                                            style: TextStyle(fontSize: 11),
                                            textAlign: TextAlign.justify,
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                if (userData['messageseen'] == "0")
                                  Row(
                                    children: [
                                      Text(
                                        "seen",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Icon(
                                        Icons.done_all,
                                        size: 12,
                                        color: Colors.blue,
                                      )
                                    ],
                                  )
                                else
                                  Row(
                                    children: [
                                      Text(
                                        "New",
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Icon(
                                        Icons.done,
                                        size: 12,
                                      )
                                    ],
                                  )
                              ],
                            )

                            // if (userData['messageseen'] == "0")
                            //               Row(
                            //                 children: [
                            //                   Icon(
                            //                     Icons.done_all,
                            //                     size: 20,
                            //                     color: Colors.blue,
                            //                   )
                            //                 ],
                            //               )
                            //             else
                            //               Icon(
                            //                 Icons.done,
                            //                 size: 20,
                            //               )

                            // Row(
                            //   children: [
                            //     // const SizedBox(width: 10),
                            //     Expanded(
                            //       flex: 2,
                            //       child: CircleAvatar(
                            //         radius: 35,
                            //         backgroundImage: userData['Type'] ==
                            //                 'message'
                            //             ? NetworkImage(imgPath.toString())
                            //                 as ImageProvider<Object>?
                            //             : AssetImage(imgPath.toString()),
                            //       ),
                            //     ),
                            //     const SizedBox(width: 10),
                            //     Expanded(
                            //       flex: 5,
                            //       child: Column(
                            //         crossAxisAlignment:
                            //             CrossAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             userData['Name'],
                            //             overflow: TextOverflow.ellipsis,
                            //             style: const TextStyle(
                            //               fontSize: 16,
                            //               fontWeight: FontWeight.bold,
                            //             ),
                            //           ),
                            //           //ss
                            //           Text(
                            //             userData['subject'],
                            //             overflow: TextOverflow.ellipsis,
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     // const SizedBox(width: 100),
                            //     Expanded(
                            //       flex: 2,
                            //       child: Text(
                            //         userData['Date'],
                            //         style: const TextStyle(
                            //           fontSize: 10,
                            //           fontWeight: FontWeight.bold,
                            //         ),
                            //       ),
                            //     ),
                            //     Expanded(
                            //         flex: 1,
                            //         child: Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.center,
                            //           children: [
                            //             SizedBox(height: 43),
                            //             if (userData['messageseen'] == "0")
                            //               Row(
                            //                 children: [
                            //                   Icon(
                            //                     Icons.done_all,
                            //                     size: 20,
                            //                     color: Colors.blue,
                            //                   )
                            //                 ],
                            //               )
                            //             else
                            //               Icon(
                            //                 Icons.done,
                            //                 size: 20,
                            //               )
                            //           ],
                            //         )),
                            //   ],
                            // )
                          ],
                        ),
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
                        "There is no notification",
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
    );
  }
}
