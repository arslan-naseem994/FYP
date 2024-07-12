// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/user/notifications/notification_tabs.dart';
import 'package:sahulatapp/user/four_services/cleaning.dart';
import 'package:sahulatapp/user/four_services/electrician.dart';
import 'package:sahulatapp/user/four_services/plumber.dart';
import 'package:sahulatapp/user/four_services/ac_tech.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  final uids = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef = FirebaseDatabase.instance.ref('User');
  final databaseReference = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final userRef = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('Name');

  int totalmessages = 0;

  bool hasNewData = false;

  int myindex = 0;
  int _currentIndex = 0;

  // void _navigateToNotificationScreen() async {
  //   setState(() {
  //     hasNewData = false;
  //   });
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove('hasNewData');
  //   // ignore: use_build_context_synchronously
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => const NotificationTabs(),
  //     ),
  //   );
  // }

  List<String> imageList = [
    'assets/images/slide1.jpg',
    'assets/images/slide2.jpg',
    'assets/images/slide3.jpg',
    'assets/images/slide4.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // This block of code will be executed when the user presses the back button
        return false;
      },
      child: Scaffold(
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            CarouselSlider(
              items: imageList
                  .map(
                    (e) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(
                            e,
                            fit: BoxFit.fill,
                          ),
                          const Text(""),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                // autoPlayAnimationDuration: Duration(milliseconds: 500),
                autoPlayInterval: const Duration(milliseconds: 3000),
                autoPlay: true,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                height: 150,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imageList.map((item) {
                int index = imageList.indexOf(item);
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? const Color(0xff9749ff)
                        : Colors.grey,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(
              height: 35,
            ),
            //before offerings or services categories
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // offerings
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("Services",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xff9749ff),
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                                      builder: (context) =>
                                          ElectricianScreen()));
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 171, 199),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 13),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      // stops: [0.6, 0.5],

                                      // begin: Alignment.topRight,
                                      // end: Alignment.bottomLeft,
                                      begin: FractionalOffset(1.0, 0.0),
                                      end: FractionalOffset(0.0, 1.0),
                                      colors: [
                                        Color.fromARGB(255, 255, 189, 211),
                                        Color.fromARGB(255, 255, 36, 109),
                                        // Color.fromARGB(255, 0, 255, 94),
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 15,
                                    top: 15.0,
                                    bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      // color: Colors.white,
                                      height: 84,
                                      width: 200,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            flex: 7,
                                            child: Container(
                                              // color: Colors.black,
                                              child: Image.asset(
                                                'assets/images/electrician.png',
                                                height: 70,
                                              ),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: 5,
                                          // ),
                                          Expanded(
                                              flex: 3,
                                              child: Container(
                                                height: 20,

                                                // color: Colors.black,
                                                child: Icon(
                                                  Icons.arrow_forward,
                                                  color: Colors.white,
                                                ),
                                              ))
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Electrician",
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PlumberScreen()));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 208, 184, 255),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 13),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
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
                              height: 100,
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 1, top: 9, bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            height: 55,
                                            child: Image.asset(
                                              'assets/images/plumberlogo.png',
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                            child: SizedBox(
                                          height: 55,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ))
                                      ],
                                    ),
                                    Text(
                                      "Plumber",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
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
                                      builder: (context) => CleaningScreen()));
                            },
                            child: Container(
                              height: 100,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 255, 236, 192),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 13),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      // stops: [0.6, 0.5],

                                      // begin: Alignment.topRight,
                                      // end: Alignment.bottomLeft,
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 1.0),
                                      colors: [
                                        Color.fromARGB(255, 255, 225, 154),
                                        Color.fromARGB(255, 255, 190, 38),
                                        // Color.fromARGB(255, 0, 255, 94),
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15, top: 12, bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: 50,
                                            child: Image.asset(
                                              'assets/images/cleaninglogos.png',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Container(
                                          height: 50,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: 20,
                                          ),
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "Cleaning",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VehicleCareScreen()));
                            },
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 194, 251, 255),
                                      spreadRadius: 0,
                                      blurRadius: 10,
                                      offset: Offset(0, 13),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                  gradient: LinearGradient(
                                      // stops: [0.6, 0.5],

                                      // begin: Alignment.topRight,
                                      // end: Alignment.bottomLeft,
                                      begin: FractionalOffset(0.0, 0.0),
                                      end: FractionalOffset(1.0, 1.0),
                                      colors: [
                                        Color.fromARGB(255, 138, 247, 255),
                                        Color.fromARGB(255, 0, 204, 255),
                                        // Color.fromARGB(255, 0, 255, 94),
                                      ])),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0,
                                    right: 1,
                                    top: 15.0,
                                    bottom: 15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ClipOval(
                                            child: Image.asset(
                                              'assets/images/vehiclecarelogo.png',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                            child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "AC Service",
                                      style: TextStyle(
                                          fontSize: 22, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
// changes arslan made it comment if any error occure fix
// NavigationDrawer ////////////
// class NavigationDrawer extends StatefulWidget {
//   const NavigationDrawer({super.key});

//   @override
//   State<NavigationDrawer> createState() => _NavigationDrawerState();
// }

// class _NavigationDrawerState extends State<NavigationDrawer> {
//   final fullname = TextEditingController();
//   final image = TextEditingController();
//   final email = FirebaseAuth.instance.currentUser!.email;

//   final databaseReference = FirebaseDatabase.instance
//       .ref('User')
//       .child(FirebaseAuth.instance.currentUser!.uid);

//   @override
//   void initState() {
//     super.initState();
//     _fetchData(); // Call the method when the widget is initialized
//   }

//   void _fetchData() async {
//     databaseReference.onValue.listen((event) {
//       setState(() {
//         // Update the state with the retrieved data
//         if (event.snapshot.value != null) {
//           final value = event.snapshot.value as Map<dynamic, dynamic>;
//           final name = value['Name'] as String;
//           final images = value['image'] as String;
//           fullname.text = name;
//           image.text = images;
//         }
//       });
//     });
//   }

//   final auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             buildHeader(context),
//             buildMenuItems(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader(BuildContext context) => Material(
//         color: Colors.black,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const ProfileTwo()));
//           },
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 10.0),
//             child: Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.4), BlendMode.srcOver),
//                   image: AssetImage(
//                       'assets/images/nevigationdrawerbackground.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               // color: Colors.blue.shade700,
//               padding: EdgeInsets.only(
//                 top: 24 + MediaQuery.of(context).padding.top,
//                 bottom: 24,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(image.text.toString()),
//                       ),
//                       SizedBox(
//                         width: 14,
//                       ),
//                       Column(
//                         children: [
//                           Text(
//                             fullname.text.toString(),
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontFamily: 'pacifico',
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             email.toString(),
//                             style: TextStyle(
//                               fontSize: 50,
//                               color: Colors.white,
//                               fontFamily: 'pacifico',
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   Widget buildMenuItems(BuildContext context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Wrap(
//           runSpacing: 16,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.home_outlined),
//               title: const Text('Homea'),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const HomeScreen()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.add_box_outlined),
//               title: const Text('Recent Orders'),
//               onTap: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const RecentOrders()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.star_border_rounded),
//               title: const Text('Favorite'),
//               onTap: () {},
//             ),
//             Container(
//               height: 10,
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.grey.withOpacity(0.5),
//                     spreadRadius: 3,
//                     blurRadius: 7,
//                     offset: Offset(0, 2), // changes position of shadow
//                   ),
//                 ],
//               ),
//               child: ClipRect(
//                 child: BackdropFilter(
//                   filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
//                   child: Divider(
//                     thickness: 2.0,
//                     height: 50.0,
//                     color: Colors.black,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.logout_outlined),
//               title: const Text('Logout'),
//               onTap: () {
//                 auth.signOut().then((value) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const UserService()));
//                 }).onError((error, stackTrace) {
//                   Utils().toastMessage(error.toString());
//                 });
//               },
//             ),
//           ],
//         ),
//       );
// }

// NavigationDrawer /////////////////////////////////////////////////////////////

// class NavigationDrawer extends StatefulWidget {
//   const NavigationDrawer({super.key});

//   @override
//   State<NavigationDrawer> createState() => _NavigationDrawerState();
// }

// class _NavigationDrawerState extends State<NavigationDrawer> {
//   final fullname = TextEditingController();
//   final image = TextEditingController();
//   final email = FirebaseAuth.instance.currentUser!.email;

//   final databaseReference = FirebaseDatabase.instance
//       .ref('User')
//       .child(FirebaseAuth.instance.currentUser!.uid);

//   @override
//   void initState() {
//     super.initState();
//     _fetchData(); // Call the method when the widget is initialized
//   }

//   void _fetchData() async {
//     databaseReference.onValue.listen((event) {
//       setState(() {
//         // Update the state with the retrieved data
//         if (event.snapshot.value != null) {
//           final value = event.snapshot.value as Map<dynamic, dynamic>;
//           final name = value['Name'] as String;
//           final images = value['image'] as String;
//           fullname.text = name;
//           image.text = images;
//         }
//       });
//     });
//   }

//   final auth = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             buildHeader(context),
//             buildMenuItems(context),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildHeader(BuildContext context) => Material(
//         color: Colors.black,
//         child: InkWell(
//           onTap: () {
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const ProfileTwo()));
//           },
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 10.0),
//             child: Container(
//               // height: 150,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   colorFilter: ColorFilter.mode(
//                       Colors.black.withOpacity(0.4), BlendMode.srcOver),
//                   image: AssetImage(
//                       'assets/images/nevigationdrawerbackground.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               // color: Colors.blue.shade700,
//               padding: EdgeInsets.only(
//                 top: 24 + MediaQuery.of(context).padding.top,
//                 bottom: 24,
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       SizedBox(
//                         width: 10,
//                       ),
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundImage: NetworkImage(image.text.toString()),
//                       ),
//                       SizedBox(
//                         width: 14,
//                       ),
//                       Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             fullname.text.toString(),
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             email.toString(),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 13,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );

//   Widget buildMenuItems(BuildContext context) => Container(
//         padding: const EdgeInsets.all(24),
//         child: Wrap(
//           runSpacing: 16,
//           children: [
//             ListTile(
//               leading: const Icon(Icons.home, size: 30),
//               title: const Text('Home',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const PostScreen()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.add_box,
//                 size: 25,
//               ),
//               title: const Text('Recent Orders',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const RecentOrders()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.history,
//                 size: 25,
//               ),
//               title: const Text('Order History',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const OrderHistory()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(
//                 Icons.star,
//                 size: 25,
//               ),
//               title: const Text('Favorite',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               onTap: () {
//                 Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const FavoriteScreen()));
//               },
//             ),
//             const SizedBox(height: 280),
//             ListTile(
//               leading: const Icon(
//                 Icons.logout_rounded,
//                 size: 25,
//               ),
//               title: const Text('Logout',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
//               onTap: () {
//                 auth.signOut().then((value) {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const UserService()));
//                   final snackBar = SnackBar(
//                     content: Text('Logout'),
//                     duration: Duration(seconds: 3),
//                   );
//                   ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                 }).onError((error, stackTrace) {
//                   Utils().toastMessage(error.toString());
//                 });
//               },
//             ),
//           ],
//         ),
//       );
// }
