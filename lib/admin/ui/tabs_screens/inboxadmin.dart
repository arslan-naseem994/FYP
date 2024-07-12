import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/inbox_screen/inbox_details.dart';

class AdminInboxScreen extends StatefulWidget {
  final int totalmess;

  const AdminInboxScreen({
    super.key,
    required this.totalmess,
  });

  @override
  State<AdminInboxScreen> createState() => _AdminInboxScreenState();
}

class _AdminInboxScreenState extends State<AdminInboxScreen> {
  final ref = FirebaseDatabase.instance.ref('Allsupport');
  Timer? timer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "New Messages: ${widget.totalmess}",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold
                          ),
                    ),
                  ),
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
                                "Do you really want to clear all messages?"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.blue,
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
                    child: Text("clear all"),
                  ),
                ],
              ),
              Expanded(
                  child: StreamBuilder(
                stream: ref.onValue,
                builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!.snapshot.value != null &&
                      snapshot.data!.snapshot.value is Map<dynamic, dynamic>) {
                    Map<dynamic, dynamic> map =
                        snapshot.data!.snapshot.value as dynamic;
                    List<dynamic> list = [];

                    list = map.values.toList();
                    return ListView.builder(
                      itemCount: snapshot.data!.snapshot.children.length,
                      itemBuilder: ((context, index) {
                        final imgPath = list[index]['userImage'];
                        return GestureDetector(
                          onTap: () {
                            ref
                                .child(list[index]['SupporID'])
                                .update({'messageseen': '0'});
                            // Navigate to new screen with selected item's data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                    reply: list[index]['Reply'],
                                    supporid: list[index]['SupporID'],
                                    message: list[index]['Message'],
                                    name: list[index]['Name'],
                                    title: list[index]['Title'],
                                    date: list[index]['Date'],
                                    userImage: list[index]['Date'],
                                    imagePath: imgPath,
                                    type: list[index]['Type'],
                                    sender: list[index]['senderid']),
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
                                  offset: Offset(0, 2),
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
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 2,
                                      child: CircleAvatar(
                                        radius: 35,
                                        backgroundImage: imgPath != null
                                            ? NetworkImage(imgPath!)
                                                as ImageProvider<Object>?
                                            : AssetImage(
                                                'assets/logo/camera.jpg'),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      flex: 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            list[index]['Name'],
                                            style: const TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(list[index]['Title']),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            Text(
                                              list[index]['Date'],
                                              style: const TextStyle(
                                                fontSize: 12,
                                                // fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        )),
                                    Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(height: 43),
                                            if (list[index]['messageseen'] ==
                                                "0")
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.done_all,
                                                    size: 20,
                                                    color: Colors.blue,
                                                  )
                                                ],
                                              )
                                            else
                                              Icon(
                                                Icons.done,
                                                size: 20,
                                              )
                                          ],
                                        )),
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
                              "There is no new message",
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
