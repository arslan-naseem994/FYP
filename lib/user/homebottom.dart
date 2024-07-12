// ignore_for_file: unnecessary_null_comparison

import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/chatscreen.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/favorite_screen.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/home_screen.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/support_screen.dart';
import 'package:sahulatapp/ui/posts/order_history.dart';
import 'package:sahulatapp/user/user_profile_screens/update_profile.dart';
import 'package:sahulatapp/user/user_profile_screens/profile.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';
import 'package:sahulatapp/userchat.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sahulatapp/user/notifications/notification_tabs.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final databaseReference = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final userRef = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('Name');

  final ref = FirebaseDatabase.instance.ref('AllNotification');
  final auth = FirebaseAuth.instance;
  final uids = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef = FirebaseDatabase.instance.ref('User');
  final String desired = FirebaseAuth.instance.currentUser!.uid;
  int totalmessages = 0;
  int myindex = 0;
  bool hasNewData = false;

  List widgeList = [
    HomeScreen(),
    SupportScreen(),
    FavoriteScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _messageSeen();
    // _listenForNewData();
  }

  void _messageSeen() {
    ref.orderByChild('messageseen').equalTo('1').onValue.listen((event) {
      final users = event.snapshot.value as Map<dynamic, dynamic>?;
      if (users != null) {
        setState(() {
          totalmessages = users.length;
        });
      } else {
        setState(() {
          totalmessages = 0;
        });
      }
    }, onError: (error) {
      // Handle error if any
    });
  }

  // void _listenForNewData() async {
  //   ref.onValue.listen((event) {
  //     DataSnapshot dataSnapshot = event.snapshot;
  //     if (dataSnapshot.value != null) {
  //       setState(() {
  //         hasNewData = true;
  //       });
  //     } else {
  //       hasNewData = false;
  //     }
  //   });
  // }

  void _navigateToNotificationScreen() async {
    setState(() {
      hasNewData = false;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('hasNewData');
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NotificationTabs(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
///////////

//////////////////

    ///

    return WillPopScope(
      onWillPop: () async {
        // This block of code will be executed when the user presses the back button
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          appBar: myindex == 0
              ? AppBar(
                  elevation: 1,
                  iconTheme: IconThemeData(
                    color: Color(0xff9749ff),
                  ),
                  title: Text(
                    'Dashboard',
                    style: TextStyle(
                      color: Color(0xff9749ff),
                    ),
                  ),
                  backgroundColor: Colors.white,
                  actions: [
                    IconButton(
                      onPressed: () {
                        userRef.once().then((DatabaseEvent event) {
                          String Name = 'empty';
                          DataSnapshot snapshot = event.snapshot;
                          Name = snapshot.value.toString();

                          return Name;
                        }).then((Name) {
                          if (Name == "null") {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration: Duration(milliseconds: 100),
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
                                  return ProfileScreen();
                                },
                              ),
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const ProfileScreen()));
                          } else {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                transitionDuration:
                                    Duration(milliseconds: 1000),
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
                                  return ProfileTwo();
                                },
                              ),
                            );
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => const ProfileTwo()));
                          }
                        });
                      },
                      icon: const Icon(
                        Icons.account_circle,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: _navigateToNotificationScreen,
                      child: Center(
                        child: Stack(
                          children: [
                            Icon(
                              Icons.notifications,
                              size: 25,
                            ),
                            if (totalmessages != 0)
                              Positioned(
                                top: 2,
                                right: 2,
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255, 17, 0),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.circle,
                                    size: 5,
                                    color: Color.fromARGB(255, 255, 17, 0),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                )
              : null,
          drawer: NavigationDrawer(),
          body: Center(
            child: widgeList[myindex],
          ),
          bottomNavigationBar: BottomNavigationBar(
              elevation: 20,
              enableFeedback: true,
              selectedItemColor: Color.fromARGB(255, 0, 226, 185),
              unselectedItemColor: Color(0xff9749ff),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              backgroundColor: Colors.teal,
              type: BottomNavigationBarType.shifting,
              currentIndex: myindex,
              onTap: (index) {
                setState(() {
                  myindex = index;

                  // if (index == 0) {
                  //   Navigator.push(
                  //     context,
                  //     MaterialPageRoute(builder: (context) => PostScreen()),
                  //   );
                  // }
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    // color: Color(0xff9749ff),
                  ),
                  label: 'Dashboard',
                  // backgroundColor: Color(0xff9749ff),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.forum),
                  label: 'Support',
                  // backgroundColor: Colors.indigo[600]
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  label: 'Favorite',
                  // backgroundColor: Colors.indigo[600]
                )
              ]),
        ),
      ),
    );
  }
}

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

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({super.key});

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  final fullname = TextEditingController();
  final image = TextEditingController();
  final email = FirebaseAuth.instance.currentUser!.email;

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
          final images = value['image'] as String;
          fullname.text = name;
          image.text = images;
        }
      });
    });
  }

  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Material(
        elevation: 1,
        color: Color.fromARGB(255, 191, 141, 255),
        child: InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ProfileTwo()));
          },
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 10.0),
            child: Container(
              // height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.4), BlendMode.srcOver),
                  image: AssetImage(
                      'assets/images/nevigationdrawerbackground.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              // color: Colors.blue.shade700,
              padding: EdgeInsets.only(
                top: 24 + MediaQuery.of(context).padding.top,
                bottom: 24,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 2,
                              color: Color.fromARGB(255, 191, 141, 255),
                            )),
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 191, 141, 255),
                          foregroundColor: Color.fromARGB(255, 191, 141, 255),
                          radius: 35,
                          backgroundImage: NetworkImage(image.text.toString()),
                        ),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fullname.text.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            email.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_outlined,
                size: 25,
                color: Color.fromARGB(255, 191, 141, 255),
              ),
              title: const Text('Dashboard',
                  style: TextStyle(
                    // shadows: [
                    //   Shadow(
                    //     color: Colors.black,
                    //     offset: Offset(0, 4),
                    //     blurRadius: 0.5,
                    //   ),
                    // ],
                    fontSize: 13,
                  )),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PostScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.library_books_outlined,
                size: 25,
                color: Color.fromARGB(255, 191, 141, 255),
              ),
              title: const Text('Recent Bookings',
                  style: TextStyle(
                    fontSize: 13,
                  )),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RecentOrders()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.history,
                size: 25,
                color: Color.fromARGB(255, 191, 141, 255),
              ),
              title: const Text('Booking History',
                  style: TextStyle(
                    fontSize: 13,
                  )),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const OrderHistory()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.star_border_outlined,
                size: 25,
                color: Color.fromARGB(255, 191, 141, 255),
              ),
              title: const Text('Favorite',
                  style: TextStyle(
                    fontSize: 13,
                  )),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FavoriteScreen()));
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.chat,
                size: 25,
                color: Color.fromARGB(255, 191, 141, 255),
              ),
              title: const Text('Chats',
                  style: TextStyle(
                    fontSize: 13,
                  )),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserChatScreenDetails()));
              },
            ),
            const SizedBox(height: 280),
            ListTile(
              leading: const Icon(
                Icons.logout_rounded,
                size: 25,
                color: Color.fromARGB(255, 191, 141, 255),
              ),
              title: const Text('Logout',
                  style: TextStyle(
                    fontSize: 13,
                  )),
              onTap: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserService()));
                  final snackBar = SnackBar(
                    content: Text('Logout'),
                    duration: Duration(seconds: 3),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
            ),
          ],
        ),
      );
}
// NavigationDrawer /////////////////////////////////////////////////////////////

