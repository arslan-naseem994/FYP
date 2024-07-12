import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/admin/ui/pendingregis/image.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/service_login_screen.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';
import 'package:sahulatapp/utils/utils.dart';

import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/profileupdate.dart';

class ProfilesTwo extends StatefulWidget {
  const ProfilesTwo({super.key});

  @override
  State<ProfilesTwo> createState() => _ProfilesTwoState();
}

class _ProfilesTwoState extends State<ProfilesTwo> {
  final currentUser = FirebaseAuth.instance.currentUser!.email;
  final auth = FirebaseAuth.instance;
  final fullname = TextEditingController();
  final addresss = TextEditingController();
  final phoneno = TextEditingController();
  final exp = TextEditingController();
  final com = TextEditingController();
  final image = TextEditingController();

  final databaseReference = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    _fetchData();
    _fetchData2();
    super.initState();
    // Call the method when the widget is initialized
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
          final expp = value['experience'] as String;
          final comm = value['commission'] as String;

          fullname.text = name;
          addresss.text = address;
          phoneno.text = phone;
          exp.text = expp;
          com.text = comm;
        }
      });
    });
  }

  void _fetchData2() async {
    databaseReference.onValue.listen((event) {
      setState(() {
        // Update the state with the retrieved data
        if (event.snapshot.value != null) {
          final value = event.snapshot.value as Map<dynamic, dynamic>;
          final images = value['image'] as String;
          image.text = images;
        }
      });
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(top: 18, left: 30, right: 30),
              child: Column(children: [
                SizedBox(height: 60),
                // Row(
                //   children: [
                //     Container(
                //       padding: EdgeInsets.only(top: 10, left: 0),
                //       child: IconButton(
                //         icon: Icon(Icons.arrow_back),
                //         onPressed: () {
                //           Navigator.push(
                //             context,
                //             PageRouteBuilder(
                //               transitionDuration: Duration(milliseconds: 1000),
                //               transitionsBuilder: (context, animation,
                //                   secondaryAnimation, child) {
                //                 var begin = Offset(1.0, 0.0);
                //                 var end = Offset.zero;
                //                 var curve = Curves.ease;

                //                 var tween = Tween(begin: begin, end: end)
                //                     .chain(CurveTween(curve: curve));
                //                 return SlideTransition(
                //                   position: animation.drive(tween),
                //                   child: child,
                //                 );
                //               },
                //               pageBuilder:
                //                   (context, animation, secondaryAnimation) {
                //                 return HomeScreens();
                //               },
                //             ),
                //           );

                //           // Navigator.push(context,
                //           //     MaterialPageRoute(builder: (context) => const SplashScreen3()));
                //         },
                //       ),
                //     ),
                //   ],
                // ),
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
                        radius: 50,
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
                Text(currentUser.toString(), style: TextStyle(fontSize: 12)),
                SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 300,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 209, 173, 255),
                        spreadRadius: 1,
                        blurRadius: 13,
                        offset: Offset(0, 13),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 161, 90, 255),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Experience\n${exp.text.toString()} Years",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height:
                              30, // Adjust the height of the vertical line as needed
                          width:
                              1, // Adjust the width of the vertical line as needed
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Commission\n ${com.text.toString()} Rs",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 209, 173, 255),
                        spreadRadius: 1,
                        blurRadius: 13,
                        offset: Offset(0, 13),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: Color.fromARGB(255, 191, 141, 255),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "+92${phoneno.text}",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 209, 173, 255),
                        spreadRadius: 1,
                        blurRadius: 13,
                        offset: Offset(0, 13),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 191, 141, 255),
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
                const SizedBox(height: 20),
                // Container(
                //   decoration: BoxDecoration(
                //       boxShadow: [
                //         BoxShadow(
                //           color: Colors.blueGrey,
                //           spreadRadius: 2,
                //           blurRadius: 8,
                //           offset: Offset(0, 10), // changes position of shadow
                //         ),
                //       ],
                //       color: Colors.white,
                //       border: Border.all(),
                //       borderRadius: BorderRadius.circular(8)),
                //   padding: EdgeInsets.all(10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           flex: 4,
                //           child: Row(
                //             children: [
                //               Text(
                //                 "Experience: ${exp.text.toString()} Years",
                //                 style: TextStyle(fontSize: 13),
                //               ),
                //             ],
                //           )),
                //       Expanded(
                //           flex: 6,
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Text(
                //                 "Commission: ${com.text.toString()} Rs",
                //                 style: TextStyle(fontSize: 13),
                //                 textAlign: TextAlign.right,
                //               ),
                //             ],
                //           )),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 20),
                InkWell(
                  onTap: () async {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilesScreen()));
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 209, 173, 255),
                          spreadRadius: 1,
                          blurRadius: 13,
                          offset: Offset(0, 13),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff9749ff),
                    ),
                    child: const Center(
                        child: Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
                const SizedBox(height: 60),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
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
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
