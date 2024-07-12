import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/pendingregis/image.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:flutter/services.dart';

import '../../ui/serviceprovider/auth/service_login_screen.dart';

class ProfileTwo extends StatefulWidget {
  const ProfileTwo({super.key});

  @override
  State<ProfileTwo> createState() => _ProfileTwoState();
}

class _ProfileTwoState extends State<ProfileTwo> {
  final dataBaseRef = FirebaseDatabase.instance.ref('ConfirmTable');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('CancelTable');
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final ref2 = FirebaseDatabase.instance.ref('AllNotification');
  final ref5 = FirebaseDatabase.instance.ref('OrderTable');
  final ref6 = FirebaseDatabase.instance.ref('favorite');
  final ref7 = FirebaseDatabase.instance.ref('OrderHistory');
  final ref8 = FirebaseDatabase.instance.ref('Allsupport');
  final currentUser = FirebaseAuth.instance.currentUser!.email;
  final auth = FirebaseAuth.instance;
  final fullname = TextEditingController();
  final addresss = TextEditingController();
  final phoneno = TextEditingController();
  final image = TextEditingController();

  final databaseReference = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    super.initState();
    _fetchData(); // Call the method when the widget is initialized
  }

  void _fetchData() async {
    databaseReference.onValue.listen((event) {
      setState(() {
        // Update the state with the retrieved data
        if (event.snapshot.value != null) {
          final value = event.snapshot.value as Map<dynamic, dynamic>;
          final name = value['Name'] as String;
          final address = value['Address'] as String;
          final phone = value['Phone'] as String;
          final images = value['image'] as String;
          fullname.text = name;
          addresss.text = address;
          phoneno.text = phone;
          image.text = images;
        }
      });
    });
  }

  @override
  // void initState() {
  //   // //////////////////////Name
  //   // names.once().then((DatabaseEvent event) {
  //   //   if (event.snapshot.value != null) {
  //   //     String Name = 'empty';
  //   //     DataSnapshot snapshot = event.snapshot;
  //   //     Name = snapshot.value.toString();
  //   //     fullname.text = Name;
  //   //     return Name;
  //   //   }
  //   // }).then((Name) {
  //   //   if (Name == "null") {
  //   //   } else {}
  //   // });
  //   // ///////////////////////////Address

  //   // //////////////////////
  //   // addresses.once().then((DatabaseEvent event) {
  //   //   if (event.snapshot.value != null) {
  //   //     String address = 'empty';
  //   //     DataSnapshot snapshot = event.snapshot;
  //   //     address = snapshot.value.toString();
  //   //     addresss.text = address;
  //   //     return address;
  //   //   }
  //   // }).then((address) {
  //   //   if (address == "null") {
  //   //   } else {}
  //   // });
  //   // ///////////////////////////

  //   // //////////////////////Phone
  //   // phones.once().then((DatabaseEvent event) {
  //   //   if (event.snapshot.value != null) {
  //   //     String phone = 'empty';
  //   //     DataSnapshot snapshot = event.snapshot;
  //   //     phone = snapshot.value.toString();
  //   //     phoneno.text = phone;
  //   //     return phone;
  //   //   }
  //   // }).then((phone) {
  //   //   if (phone == "null") {
  //   //   } else {}
  //   // });
  //   // ///////////////////////////
  //   databaseReference.onValue.listen((event) {
  //     if (event.snapshot.value != null) {
  //       final value = event.snapshot.value as Map<dynamic, dynamic>;
  //       final name = value['Name'] as String;
  //       final address = value['Address'] as String;
  //       final phone = value['Phone'] as String;
  //       fullname.text = name;
  //       addresss.text = address;
  //       phoneno.text = phone;
  //     }
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return PostScreen();
            },
          ),
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              padding:
                  EdgeInsets.only(top: 60, bottom: 60, left: 40, right: 40),
              child: Column(children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 10, left: 0),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Color(0xff9749ff),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration: Duration(milliseconds: 1000),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                var begin = Offset(1.0, 0.0);
                                var end = Offset.zero;
                                var curve = Curves.ease;

                                var tween = Tween(begin: begin, end: end)
                                    .chain(CurveTween(curve: curve));
                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return PostScreen();
                              },
                            ),
                          );

                          // Navigator.push(context,
                          //     MaterialPageRoute(builder: (context) => const SplashScreen3()));
                        },
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ImageViewScreen(
                          imageUrl: image.text.toString(),
                        ),
                      ),
                    );
                  },
                  child: SizedBox(
                    width: 120,
                    height: 120,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 2,
                            color: Color.fromARGB(255, 191, 141, 255),
                          )),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(image.text.toString()),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  fullname.text.toString(),
                  style: TextStyle(
                    color: Color(0xff9749ff),
                    fontSize: 30,
                  ),
                ),
                Text(currentUser.toString(),
                    style: TextStyle(
                      fontSize: 12,
                      // color: Color(0xff9749ff),
                    )),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color(0xff9749ff),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          phoneno.text.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(0, 10), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color(0xff9749ff),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          addresss.text.toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()));
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueGrey,
                            spreadRadius: 2,
                            blurRadius: 8,
                            offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                        color: Color(0xff9749ff),
                        border: Border.all(color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(height: 130),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 10,
                            minimumSize: Size(50, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
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
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }).onError((error, stackTrace) {
                            Utils().toastMessage(error.toString());
                          });
                        },
                        child: Text(
                          "Logout",
                          style: TextStyle(color: Colors.black),
                        )),
                  ],
                )
                // InkWell(
                //     onTap: () {
                //       ref.remove();
                //       ref2.remove();
                //       ref5.remove();
                //       ref6.remove();
                //       ref7.remove();
                //       ref8.remove();
                //       dataBaseRef.remove();
                //       dataBaseRef2.remove();
                //     },
                //     child: Text("Clear All")),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
