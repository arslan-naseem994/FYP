import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahulatapp/admin/ui/inbox_screen/inbox_details.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/profileupdate.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/editprofile.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final ref = FirebaseDatabase.instance.ref('Allsupport');
  final userRef = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('Name');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("ServiceProvider"),
          backgroundColor: Colors.indigo[600],
          actions: [
            // IconButton(
            //   onPressed: () {
            //     userRef.once().then((DatabaseEvent event) {
            //       String Name = 'empty';
            //       DataSnapshot snapshot = event.snapshot;
            //       Name = snapshot.value.toString();

            //       return Name;
            //     }).then((Name) {
            //       if (Name == "null") {
            //         Navigator.push(
            //           context,
            //           PageRouteBuilder(
            //             transitionDuration: Duration(milliseconds: 100),
            //             transitionsBuilder:
            //                 (context, animation, secondaryAnimation, child) {
            //               var begin = Offset(1.0, 0.0);
            //               var end = Offset.zero;
            //               var curve = Curves.ease;

            //               var tween = Tween(begin: begin, end: end)
            //                   .chain(CurveTween(curve: curve));
            //               return SlideTransition(
            //                 position: animation.drive(tween),
            //                 child: child,
            //               );
            //             },
            //             pageBuilder: (context, animation, secondaryAnimation) {
            //               return ProfilesScreen();
            //             },
            //           ),
            //         );
            //         // Navigator.push(
            //         //     context,
            //         //     MaterialPageRoute(
            //         //         builder: (context) => const ProfileScreen()));
            //       } else {
            //         Navigator.push(
            //           context,
            //           PageRouteBuilder(
            //             transitionDuration: Duration(milliseconds: 1000),
            //             transitionsBuilder:
            //                 (context, animation, secondaryAnimation, child) {
            //               var begin = Offset(1.0, 0.0);
            //               var end = Offset.zero;
            //               var curve = Curves.ease;

            //               var tween = Tween(begin: begin, end: end)
            //                   .chain(CurveTween(curve: curve));
            //               return SlideTransition(
            //                 position: animation.drive(tween),
            //                 child: child,
            //               );
            //             },
            //             pageBuilder: (context, animation, secondaryAnimation) {
            //               return ProfilesTwo();
            //             },
            //           ),
            //         );
            //         // Navigator.push(
            //         //     context,
            //         //     MaterialPageRoute(
            //         //         builder: (context) => const ProfileTwo()));
            //       }
            //     });
            //   },
            //   icon: const Icon(Icons.account_circle),
            // ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                                  userImage: list[index]['userImage'],
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
                                color: Colors.indigo,
                                spreadRadius: 2,
                                blurRadius: 15,
                                offset: Offset(0, 10),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundImage: imgPath != null
                                          ? AssetImage(imgPath)
                                          : const AssetImage(
                                              'assets/images/message.jpg'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
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
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      list[index]['Date'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
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
    );
  }
}
