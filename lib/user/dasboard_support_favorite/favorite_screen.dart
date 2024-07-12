import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/user/four_services/electrician.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/utils/utils.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final auth = FirebaseDatabase.instance;
  final ref = FirebaseDatabase.instance.ref('favorite');
  Timer? timer;
  final uids = FirebaseAuth.instance.currentUser!.uid;

  final String desired = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho) {
      final query = ref.child(uids).orderByChild('UserID').equalTo(desired);

      return query.onValue.map((event) {
        final dataSnapshot = event.snapshot;
        final userList = dataSnapshot.value ?? {};

        if (userList is Map<dynamic, dynamic>) {
          return userList.values.toList().cast<Map<dynamic, dynamic>>();
        }

        return [];
      });
    }

    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PostScreen()));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            // leading: Padding(
            //     padding: const EdgeInsets.only(
            //       left: 10,
            //     ),
            //     child: GestureDetector(
            //       child: Icon(
            //         Icons.arrow_back_ios,
            //         color: Color(0xff9749ff),
            //         size: 22,
            //       ),
            //       onTap: () {
            //         Navigator.push(
            //             context,
            //             MaterialPageRoute(
            //                 builder: (context) => const PostScreen()));
            //       },
            //     )),

            title: Text(
              'Favorites',
              style: TextStyle(
                color: Color(0xff9749ff),
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 1,
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
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
                            content: Text(
                                "Do you really want to clear all favorites?"),
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
                    child: Text(
                      "Clear all",
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Expanded(
                    child: StreamBuilder(
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
                          itemCount: userList.length,
                          itemBuilder: ((context, index) {
                            final userData = userList[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ServiceOne(
                                        name: userData['ServiceName'],
                                        imgpath: userData['Image'],
                                        prices: userData['Price'],
                                        expert: userData['Expertise']),
                                  ),
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 1),
                                width: 360,
                                height: 100,
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
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          child: Image.asset(
                                            userData['Image'],
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          userData['ServiceName'],
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                        const Spacer(),
                                        const SizedBox(width: 10),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {});
                                            ref
                                                .child(uids)
                                                .child(userData['ServiceName'])
                                                .remove();

                                            // ***********
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //       builder: (context) => FavoriteScreen()),
                                            // );
                                          },
                                          child: Icon(
                                            Icons.favorite_sharp,
                                            color: Colors.green,
                                            size: 30,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                            // ListTile(
                            //   title: Text(list[index]['Date']),
                            //   subtitle: Text(list[index]['Time']),
                            // );
                          }));
                    } else {
                      return Scaffold(
                        body: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20),
                              Text(
                                "THERE IS NO FAVORITE",
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
      ),
    );
  }
}
