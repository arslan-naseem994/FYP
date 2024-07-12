import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/chatscreen.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/home_screen.dart';
import 'package:sahulatapp/user/homebottom.dart';

class UserChatScreenDetails extends StatefulWidget {
  const UserChatScreenDetails({super.key});

  @override
  State<UserChatScreenDetails> createState() => _UserChatScreenDetailsState();
}

class _UserChatScreenDetailsState extends State<UserChatScreenDetails> {
  final ref = FirebaseDatabase.instance.ref('mychat');
  Timer? timer;
  final providerid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge() {
      // final query = ref.child(desired).orderByChild('workdone').equalTo('0');

      final query = ref.child(providerid);

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

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostScreen(),
          ),
        );
        return true;
      },
      child: Scaffold(
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
                      content: Text("Do you really want to clear all chats?"),
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
                            ref.child(providerid).remove();
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
          leading: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff9749ff),
                  size: 22,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScreen(),
                    ),
                  );
                },
              )),
          automaticallyImplyLeading: false,
          title: Text(
            "Chat",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff9749ff),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: fetchUsersWithAge(),
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
                            String driverId = userData.keys.first;
                            String userId = userData[driverId].keys.first;
                            dynamic driverData = userData[driverId];
                            String userId2 = driverData.keys.first;
                            dynamic userDataValue = driverData[userId2];

                            debugPrint("hi$driverId"); // id
                            debugPrint("hi$userId"); //text
                            debugPrint("hi$driverData"); //text value
                            debugPrint("hi$userDataValue");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(
                                  userid: userDataValue,
                                  providerid: providerid,
                                  role: 'user',
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
                                                'assets/images/message.jpg'),
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
                                            "Message",
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 125, 60, 255),
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
                              "No Chat",
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          )
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
