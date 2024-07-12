// // // // import 'package:firebase_database/firebase_database.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:sahulatapp/admin/ui/user_workers_bookings/users_details.dart';

// // // // class UsersScreen extends StatefulWidget {
// // // //   const UsersScreen({super.key});

// // // //   @override
// // // //   State<UsersScreen> createState() => _UsersScreenState();
// // // // }

// // // // class _UsersScreenState extends State<UsersScreen> {
// // // //   int totalUsers = 0;
// // // //   String username = '';
// // // //   final ref = FirebaseDatabase.instance.ref('User');
// // // //   String _showVerified = '1'; // Default filter option

// // // //   Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String filter) {
// // // //     final query = ref;

// // // //     return query.onValue.map((event) {
// // // //       final dataSnapshot = event.snapshot;
// // // //       final userList = dataSnapshot.value ?? {};

// // // //       if (userList is Map<dynamic, dynamic>) {
// // // //         if (filter == '2') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'true')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '3') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'false')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '1') {
// // // //           final filteredList = userList.values.toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //       }

// // // //       return [];
// // // //     });
// // // //   }

// // // //   void _showFilterOptions() {
// // // //     showModalBottomSheet<void>(
// // // //       context: context,
// // // //       builder: (BuildContext context) {
// // // //         return Container(
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               ListTile(
// // // //                 title: Text('Show All'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '1';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Show Verified'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '2';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Show Not Verified'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '3';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _totalusers(String filter) {
// // // //     ref.onValue.listen((event) {
// // // //       final dataSnapshot = event.snapshot;
// // // //       final userList = dataSnapshot.value ?? {};

// // // //       if (userList is Map<dynamic, dynamic>) {
// // // //         // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'
// // // //         if (filter == '2') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'true')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Verified Users';
// // // //           });
// // // //         }
// // // //         if (filter == '3') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'false')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Not Verified Users';
// // // //           });
// // // //         }
// // // //         if (filter == '1') {
// // // //           final filteredList = userList.values.toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Total';
// // // //           });
// // // //         }
// // // //       }
// // // //     });
// // // //   }

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _totalusers('1');
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return SafeArea(
// // // //       child: Scaffold(
// // // //           backgroundColor: Colors.white,
// // // //           appBar: AppBar(
// // // //             actions: [
// // // //               Center(
// // // //                 child: Text(
// // // //                   "${username} : ${totalUsers}",
// // // //                   style: TextStyle(
// // // //                     color: Color(0xff9749ff),
// // // //                   ),
// // // //                 ),
// // // //               )
// // // //             ],
// // // //             leading: GestureDetector(
// // // //               child: Icon(
// // // //                 Icons.arrow_back_ios,
// // // //                 color: Color(0xff9749ff),
// // // //                 size: 22,
// // // //               ),
// // // //               onTap: () {
// // // //                 Navigator.pop(context);
// // // //               },
// // // //             ),
// // // //             title: Text(
// // // //               "Users",
// // // //               style: TextStyle(
// // // //                 // fontWeight: FontWeight.bold,
// // // //                 color: Color(0xff9749ff),
// // // //               ),
// // // //             ),
// // // //             elevation: 1,
// // // //             automaticallyImplyLeading: false,
// // // //             shadowColor: Colors.white,
// // // //             bottomOpacity: 10,
// // // //             backgroundColor: Colors.white,
// // // //           ),
// // // //           floatingActionButton: FloatingActionButton(
// // // //             backgroundColor: Color(0xff9749ff),
// // // //             onPressed: _showFilterOptions,
// // // //             child: Icon(Icons.filter_list),
// // // //           ),
// // // //           body: Column(
// // // //             children: [
// // // //               Expanded(
// // // //                   child: StreamBuilder(
// // // //                 stream: fetchUsersWithAge(_showVerified),
// // // //                 builder: (context, snapshot) {
// // // //                   if (snapshot.connectionState == ConnectionState.waiting) {
// // // //                     return Center(
// // // //                       child: Container(
// // // //                         width: 120,
// // // //                         child: LinearProgressIndicator(
// // // //                           minHeight: 5,
// // // //                           backgroundColor: Colors.black,
// // // //                           // strokeWidth: 3,
// // // //                           valueColor:
// // // //                               AlwaysStoppedAnimation<Color>(Colors.blue),
// // // //                         ),
// // // //                       ),
// // // //                     );
// // // //                   } else if (snapshot.hasData &&
// // // //                       snapshot.data != null &&
// // // //                       (snapshot.data as List).isNotEmpty) {
// // // //                     final userList = snapshot.data!;
// // // //                     return ListView.builder(
// // // //                         itemCount: userList.length,
// // // //                         itemBuilder: ((context, index) {
// // // //                           final userData = userList[index];

// // // //                           return GestureDetector(
// // // //                             onTap: () {
// // // //                               Navigator.push(
// // // //                                   context,
// // // //                                   MaterialPageRoute(
// // // //                                     builder: (context) => UsersDetailsScreen(
// // // //                                       name: userData['Name'],
// // // //                                       address: userData['Address'],
// // // //                                       email: userData['Email'],
// // // //                                       image: userData['image'],
// // // //                                       phone: userData['Phone'],
// // // //                                       userid: userData['UserID'],
// // // //                                     ),
// // // //                                   ));
// // // //                             },
// // // //                             child: Padding(
// // // //                               padding: const EdgeInsets.only(top: 5),
// // // //                               child: Container(
// // // //                                 margin: const EdgeInsets.symmetric(
// // // //                                     horizontal: 14, vertical: 4),
// // // //                                 width: 50,
// // // //                                 height: 80,
// // // //                                 decoration: BoxDecoration(
// // // //                                   boxShadow: const [
// // // //                                     BoxShadow(
// // // //                                       color: Color.fromARGB(255, 208, 184, 255),
// // // //                                       spreadRadius: 0,
// // // //                                       blurRadius: 10,
// // // //                                       offset: Offset(0, 2),
// // // //                                     ),
// // // //                                   ],
// // // //                                   color: Colors.white,
// // // //                                   borderRadius: BorderRadius.circular(20),
// // // //                                 ),
// // // //                                 child: Column(
// // // //                                   mainAxisAlignment: MainAxisAlignment.center,
// // // //                                   children: [
// // // //                                     Row(
// // // //                                       children: [
// // // //                                         Expanded(
// // // //                                           flex: 2,
// // // //                                           child: CircleAvatar(
// // // //                                             radius: 35,
// // // //                                             backgroundImage:
// // // //                                                 NetworkImage(userData['image']),
// // // //                                           ),
// // // //                                         ),
// // // //                                         SizedBox(width: 10),
// // // //                                         Expanded(
// // // //                                           flex: 6,
// // // //                                           child: Column(
// // // //                                             mainAxisAlignment:
// // // //                                                 MainAxisAlignment.start,
// // // //                                             crossAxisAlignment:
// // // //                                                 CrossAxisAlignment.start,
// // // //                                             children: [
// // // //                                               Text(
// // // //                                                 userData['Name'],
// // // //                                                 style: TextStyle(
// // // //                                                     fontSize: 17,
// // // //                                                     fontWeight:
// // // //                                                         FontWeight.bold),
// // // //                                               ),
// // // //                                               Text(
// // // //                                                 userData['Email'],
// // // //                                                 overflow: TextOverflow.ellipsis,
// // // //                                               ),
// // // //                                             ],
// // // //                                           ),
// // // //                                         ),
// // // //                                         SizedBox(width: 5),
// // // //                                         Expanded(
// // // //                                           child: Icon(Icons.arrow_forward_ios),
// // // //                                         )
// // // //                                       ],
// // // //                                     )
// // // //                                   ],
// // // //                                 ),
// // // //                               ),
// // // //                             ),
// // // //                           );
// // // //                         }));
// // // //                   } else {
// // // //                     return Scaffold(
// // // //                       backgroundColor: Colors.white,
// // // //                       body: Center(
// // // //                         child: Column(
// // // //                           mainAxisAlignment: MainAxisAlignment.center,
// // // //                           children: [
// // // //                             SizedBox(height: 20),
// // // //                             Text(
// // // //                               "There is no user",
// // // //                               style: TextStyle(fontWeight: FontWeight.w900),
// // // //                             )
// // // //                           ],
// // // //                         ),
// // // //                       ),
// // // //                     );
// // // //                   }
// // // //                 },
// // // //               ))
// // // //             ],
// // // //           )),
// // // //     );
// // // //   }
// // // // }

// // // // import 'package:firebase_database/firebase_database.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:sahulatapp/admin/ui/user_workers_bookings/users_details.dart';
// // // // import 'package:sahulatapp/admin/ui/user_workers_bookings/workers_details.dart';

// // // // class WorkersScreen extends StatefulWidget {
// // // //   const WorkersScreen({super.key});

// // // //   @override
// // // //   State<WorkersScreen> createState() => _WorkersScreenState();
// // // // }

// // // // class _WorkersScreenState extends State<WorkersScreen> {
// // // //   final ref = FirebaseDatabase.instance.ref('Provider');
// // // //   int totalUsers = 0;
// // // //   String username = '';
// // // //   String _showVerified = '1'; // Default filter option

// // // //   Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String filter) {
// // // //     final query = ref;

// // // //     return query.onValue.map((event) {
// // // //       final dataSnapshot = event.snapshot;
// // // //       final userList = dataSnapshot.value ?? {};

// // // //       if (userList is Map<dynamic, dynamic>) {
// // // //         if (filter == '2') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'true')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '3') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'false')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '1') {
// // // //           final filteredList = userList.values.toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //       }

// // // //       return [];
// // // //     });
// // // //   }

// // // //   void _showFilterOptions() {
// // // //     showModalBottomSheet<void>(
// // // //       context: context,
// // // //       builder: (BuildContext context) {
// // // //         return Container(
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               ListTile(
// // // //                 title: Text('Show All'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '1';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Show Verified'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '2';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Show Not Verified'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '3';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _totalusers(String filter) {
// // // //     ref.onValue.listen((event) {
// // // //       final dataSnapshot = event.snapshot;
// // // //       final userList = dataSnapshot.value ?? {};

// // // //       if (userList is Map<dynamic, dynamic>) {
// // // //         // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'
// // // //         if (filter == '1') {
// // // //           final filteredList = userList.values.toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Total';
// // // //           });
// // // //         }
// // // //         if (filter == '2') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'true')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Verified Wokers';
// // // //           });
// // // //         }
// // // //         if (filter == '3') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['verified'] == 'false')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Not Verified Workers';
// // // //           });
// // // //         }
// // // //       }
// // // //     });
// // // //   }

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _totalusers('1');
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return SafeArea(
// // // //       child: Expanded(
// // // //         child: Scaffold(
// // // //             backgroundColor: Colors.white,
// // // //             appBar: AppBar(
// // // //               actions: [
// // // //                 Center(
// // // //                   child: Text(
// // // //                     "${username} : ${totalUsers}",
// // // //                     style: TextStyle(
// // // //                       color: Color(0xff9749ff),
// // // //                     ),
// // // //                   ),
// // // //                 )
// // // //               ],
// // // //               leading: GestureDetector(
// // // //                 child: Icon(
// // // //                   Icons.arrow_back_ios,
// // // //                   color: Color(0xff9749ff),
// // // //                   size: 22,
// // // //                 ),
// // // //                 onTap: () {
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               title: Text(
// // // //                 "Workers",
// // // //                 style: TextStyle(
// // // //                   // fontWeight: FontWeight.bold,
// // // //                   color: Color(0xff9749ff),
// // // //                 ),
// // // //               ),
// // // //               elevation: 1,
// // // //               automaticallyImplyLeading: false,
// // // //               shadowColor: Colors.white,
// // // //               bottomOpacity: 10,
// // // //               backgroundColor: Colors.white,
// // // //             ),
// // // //             floatingActionButton: FloatingActionButton(
// // // //               backgroundColor: Color(0xff9749ff),
// // // //               onPressed: _showFilterOptions,
// // // //               child: Icon(Icons.filter_list),
// // // //             ),
// // // //             body: Column(
// // // //               children: [
// // // //                 Expanded(
// // // //                   child: StreamBuilder(
// // // //                     stream: fetchUsersWithAge(_showVerified),
// // // //                     builder: (context, snapshot) {
// // // //                       if (snapshot.connectionState == ConnectionState.waiting) {
// // // //                         return Center(
// // // //                           child: Container(
// // // //                             width: 120,
// // // //                             child: LinearProgressIndicator(
// // // //                               minHeight: 5,
// // // //                               backgroundColor: Colors.black,
// // // //                               // strokeWidth: 3,
// // // //                               valueColor:
// // // //                                   AlwaysStoppedAnimation<Color>(Colors.blue),
// // // //                             ),
// // // //                           ),
// // // //                         );
// // // //                       } else if (snapshot.hasData &&
// // // //                           snapshot.data != null &&
// // // //                           (snapshot.data as List).isNotEmpty) {
// // // //                         final userList = snapshot.data!;
// // // //                         return ListView.builder(
// // // //                             itemCount: userList.length,
// // // //                             itemBuilder: ((context, index) {
// // // //                               final userData = userList[index];
// // // //                               return InkWell(
// // // //                                 onTap: () {
// // // //                                   Navigator.push(
// // // //                                       context,
// // // //                                       MaterialPageRoute(
// // // //                                         builder: (context) =>
// // // //                                             WorkersDetailsScreen(
// // // //                                           name: userData['Name'],
// // // //                                           address: userData['Address'],
// // // //                                           email: userData['email'],
// // // //                                           image: userData['image'],
// // // //                                           phone: userData['Phone'],
// // // //                                           cnic: userData['CNIC'],
// // // //                                           expertise: userData['Expertise'],
// // // //                                           idcardback: userData['IdCardBack'],
// // // //                                           idcardfront: userData['IdCardFront'],
// // // //                                           isverified: userData['verified'],
// // // //                                           providerid: userData['UserID'],
// // // //                                         ),
// // // //                                       ));
// // // //                                 },
// // // //                                 child: Container(
// // // //                                   margin: const EdgeInsets.symmetric(
// // // //                                       horizontal: 12, vertical: 8),
// // // //                                   width: 50,
// // // //                                   height: 80,
// // // //                                   decoration: BoxDecoration(
// // // //                                     boxShadow: const [
// // // //                                       BoxShadow(
// // // //                                         color:
// // // //                                             Color.fromARGB(255, 208, 184, 255),
// // // //                                         spreadRadius: 0,
// // // //                                         blurRadius: 10,
// // // //                                         offset: Offset(0, 2),
// // // //                                       ),
// // // //                                     ],
// // // //                                     color: Colors.white,
// // // //                                     borderRadius: BorderRadius.circular(20),
// // // //                                   ),
// // // //                                   child: Padding(
// // // //                                     padding: const EdgeInsets.all(5.0),
// // // //                                     child: Column(
// // // //                                       mainAxisAlignment:
// // // //                                           MainAxisAlignment.center,
// // // //                                       children: [
// // // //                                         Row(
// // // //                                           children: [
// // // //                                             Expanded(
// // // //                                               flex: 2,
// // // //                                               child: CircleAvatar(
// // // //                                                 radius: 35,
// // // //                                                 backgroundImage: NetworkImage(
// // // //                                                     userData['image']),
// // // //                                               ),
// // // //                                             ),
// // // //                                             SizedBox(width: 10),
// // // //                                             Expanded(
// // // //                                               flex: 6,
// // // //                                               child: Column(
// // // //                                                 mainAxisAlignment:
// // // //                                                     MainAxisAlignment.start,
// // // //                                                 crossAxisAlignment:
// // // //                                                     CrossAxisAlignment.start,
// // // //                                                 children: [
// // // //                                                   Text(
// // // //                                                     userData['Name'],
// // // //                                                     style: TextStyle(
// // // //                                                         fontSize: 17,
// // // //                                                         fontWeight:
// // // //                                                             FontWeight.bold),
// // // //                                                   ),
// // // //                                                   Text(
// // // //                                                     userData['email'],
// // // //                                                     overflow:
// // // //                                                         TextOverflow.ellipsis,
// // // //                                                   ),
// // // //                                                 ],
// // // //                                               ),
// // // //                                             ),
// // // //                                             SizedBox(width: 5),
// // // //                                             Expanded(
// // // //                                               child:
// // // //                                                   Icon(Icons.arrow_forward_ios),
// // // //                                             )
// // // //                                           ],
// // // //                                         )
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                               );
// // // //                             }));
// // // //                       } else {
// // // //                         return Scaffold(
// // // //                           body: Center(
// // // //                             child: Column(
// // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // //                               children: [
// // // //                                 SizedBox(height: 20),
// // // //                                 Text(
// // // //                                   "There is no woker",
// // // //                                   style: TextStyle(fontWeight: FontWeight.w900),
// // // //                                 )
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         );
// // // //                       }
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             )),
// // // //       ),
// // // //     );
// // // //   }
// // // // }

// // // // import 'package:firebase_database/firebase_database.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:sahulatapp/admin/ui/user_workers_bookings/booking_details.dart';
// // // // import 'package:sahulatapp/admin/ui/user_workers_bookings/users_details.dart';

// // // // class OrdersScreen extends StatefulWidget {
// // // //   const OrdersScreen({super.key});

// // // //   @override
// // // //   State<OrdersScreen> createState() => _OrdersScreenState();
// // // // }

// // // // class _OrdersScreenState extends State<OrdersScreen> {
// // // //   int totalUsers = 0;
// // // //   String username = '';
// // // //   final ref = FirebaseDatabase.instance.ref('AllOrders');
// // // //   String _showVerified = '1'; // Default filter option

// // // //   Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String filter) {
// // // //     final query = ref;

// // // //     return query.onValue.map((event) {
// // // //       final dataSnapshot = event.snapshot;
// // // //       final userList = dataSnapshot.value ?? {};

// // // //       if (userList is Map<dynamic, dynamic>) {
// // // //         if (filter == '1') {
// // // //           final filteredList = userList.values.toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '2') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Pending')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '3') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Confirmed')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '4') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Completed')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //         if (filter == '5') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Canceled')
// // // //               .toList();

// // // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // // //         }
// // // //       }

// // // //       return [];
// // // //     });
// // // //   }

// // // //   void _showFilterOptions() {
// // // //     showModalBottomSheet<void>(
// // // //       context: context,
// // // //       builder: (BuildContext context) {
// // // //         return Container(
// // // //           child: Column(
// // // //             mainAxisSize: MainAxisSize.min,
// // // //             children: [
// // // //               ListTile(
// // // //                 title: Text('All'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '1';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Pending'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '2';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Confirmed'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '3';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Completed'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '4';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               ListTile(
// // // //                 title: Text('Canceled'),
// // // //                 onTap: () {
// // // //                   setState(() {
// // // //                     _showVerified = '5';
// // // //                   });
// // // //                   _totalusers(_showVerified);
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //             ],
// // // //           ),
// // // //         );
// // // //       },
// // // //     );
// // // //   }

// // // //   void _totalusers(String filter) {
// // // //     ref.onValue.listen((event) {
// // // //       final dataSnapshot = event.snapshot;
// // // //       final userList = dataSnapshot.value ?? {};

// // // //       if (userList is Map<dynamic, dynamic>) {
// // // //         // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'

// // // //         if (filter == '1') {
// // // //           final filteredList = userList.values.toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Total';
// // // //           });
// // // //         }
// // // //         if (filter == '2') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Pending')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Pending Bookings';
// // // //           });
// // // //         }
// // // //         if (filter == '3') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Confirmed')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Confirmed Bookings';
// // // //           });
// // // //         }
// // // //         if (filter == '4') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Completed')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Completed Bookings';
// // // //           });
// // // //         }
// // // //         if (filter == '5') {
// // // //           final filteredList = userList.values
// // // //               .where((userData) => userData['bookingstatus'] == 'Canceled')
// // // //               .toList();
// // // //           setState(() {
// // // //             totalUsers = filteredList.length;
// // // //             username = 'Canceled Bookings';
// // // //           });
// // // //         }
// // // //       }
// // // //     });
// // // //   }

// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _totalusers('1');
// // // //   }

// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return SafeArea(
// // // //       child: Expanded(
// // // //         child: Scaffold(
// // // //             backgroundColor: Colors.white,
// // // //             appBar: AppBar(
// // // //               actions: [
// // // //                 Center(
// // // //                   child: Text(
// // // //                     "${username} : ${totalUsers}",
// // // //                     style: TextStyle(
// // // //                       color: Color(0xff9749ff),
// // // //                     ),
// // // //                   ),
// // // //                 )
// // // //               ],
// // // //               leading: GestureDetector(
// // // //                 child: Icon(
// // // //                   Icons.arrow_back_ios,
// // // //                   color: Color(0xff9749ff),
// // // //                   size: 22,
// // // //                 ),
// // // //                 onTap: () {
// // // //                   Navigator.pop(context);
// // // //                 },
// // // //               ),
// // // //               title: Text(
// // // //                 "Bookings",
// // // //                 style: TextStyle(
// // // //                   // fontWeight: FontWeight.bold,
// // // //                   color: Color(0xff9749ff),
// // // //                 ),
// // // //               ),
// // // //               elevation: 1,
// // // //               automaticallyImplyLeading: false,
// // // //               shadowColor: Colors.white,
// // // //               bottomOpacity: 10,
// // // //               backgroundColor: Colors.white,
// // // //             ),
// // // //             floatingActionButton: FloatingActionButton(
// // // //               backgroundColor: Color(0xff9749ff),
// // // //               onPressed: _showFilterOptions,
// // // //               child: Icon(Icons.filter_list),
// // // //             ),
// // // //             body: Column(
// // // //               children: [
// // // //                 // Text("${username} : ${totalUsers}"),
// // // //                 Expanded(
// // // //                   child: StreamBuilder(
// // // //                     stream: fetchUsersWithAge(_showVerified),
// // // //                     builder: (context, snapshot) {
// // // //                       if (snapshot.connectionState == ConnectionState.waiting) {
// // // //                         return Center(
// // // //                           child: Container(
// // // //                             width: 120,
// // // //                             child: LinearProgressIndicator(
// // // //                               minHeight: 5,
// // // //                               backgroundColor: Colors.black,
// // // //                               // strokeWidth: 3,
// // // //                               valueColor:
// // // //                                   AlwaysStoppedAnimation<Color>(Colors.blue),
// // // //                             ),
// // // //                           ),
// // // //                         );
// // // //                       } else if (snapshot.hasData &&
// // // //                           snapshot.data != null &&
// // // //                           (snapshot.data as List).isNotEmpty) {
// // // //                         final userList = snapshot.data!;
// // // //                         return ListView.builder(
// // // //                             itemCount: userList.length,
// // // //                             itemBuilder: ((context, index) {
// // // //                               final userData = userList[index];
// // // //                               return InkWell(
// // // //                                 onTap: () {
// // // //                                   Navigator.push(
// // // //                                       context,
// // // //                                       MaterialPageRoute(
// // // //                                         builder: (context) =>
// // // //                                             BookingDetailsScreen(
// // // //                                           phone: userData['PhoneNo'],
// // // //                                           providerid: userData['providerid'],
// // // //                                           CustomerName: userData['Name'],
// // // //                                           ProviderName:
// // // //                                               userData['providername'],
// // // //                                           ServiceName: userData['ServiceName'],
// // // //                                           img: userData['Imgpath'],
// // // //                                           Time: userData['Time'],
// // // //                                           Date: userData['Date'],
// // // //                                           Address: userData['Address'],
// // // //                                           Expert: userData['Expert'],
// // // //                                           OrderID: userData['OrderID'],
// // // //                                           Price: userData['Price'],
// // // //                                           requestSubmit:
// // // //                                               userData['RequestSubmit'],
// // // //                                           requestAccept:
// // // //                                               userData['RequestAccept'],
// // // //                                           workInProgress:
// // // //                                               userData['Workinprog'],
// // // //                                           workdone: userData['workdone'],
// // // //                                           requestacceptdate:
// // // //                                               userData['RequestAcceptedDate'],
// // // //                                           requestaccepttime:
// // // //                                               userData['RequestAcceptedTime'],
// // // //                                           bookingstatus:
// // // //                                               userData['bookingstatus'],
// // // //                                           requestsubmitdate:
// // // //                                               userData['requestsubmitdate'],
// // // //                                           requestsubmittime:
// // // //                                               userData['requestsubmittime'],
// // // //                                           workdonedate:
// // // //                                               userData['workdonedate'],
// // // //                                           workdonetime:
// // // //                                               userData['workdonetime'],
// // // //                                           workinprogdate:
// // // //                                               userData['workprogressdate'],
// // // //                                           workinprogtime:
// // // //                                               userData['workprogresstime'],
// // // //                                           requestcanceldate:
// // // //                                               userData['requestcanceldate'],
// // // //                                           requestcanceltime:
// // // //                                               userData['requestcanceltime'],
// // // //                                           requestcancel:
// // // //                                               userData['Requestcancel'],
// // // //                                         ),
// // // //                                       ));
// // // //                                 },
// // // //                                 child: Container(
// // // //                                   margin: const EdgeInsets.symmetric(
// // // //                                       horizontal: 12, vertical: 8),
// // // //                                   width: 50,
// // // //                                   height: 80,
// // // //                                   decoration: BoxDecoration(
// // // //                                     boxShadow: const [
// // // //                                       BoxShadow(
// // // //                                         color:
// // // //                                             Color.fromARGB(255, 208, 184, 255),
// // // //                                         spreadRadius: 0,
// // // //                                         blurRadius: 10,
// // // //                                         offset: Offset(0, 2),
// // // //                                       ),
// // // //                                     ],
// // // //                                     color: Colors.white,
// // // //                                     borderRadius: BorderRadius.circular(20),
// // // //                                   ),
// // // //                                   child: Padding(
// // // //                                     padding: const EdgeInsets.all(5.0),
// // // //                                     child: Column(
// // // //                                       mainAxisAlignment:
// // // //                                           MainAxisAlignment.center,
// // // //                                       children: [
// // // //                                         Row(
// // // //                                           children: [
// // // //                                             Expanded(
// // // //                                               flex: 2,
// // // //                                               child: CircleAvatar(
// // // //                                                 radius: 35,
// // // //                                                 backgroundImage: AssetImage(
// // // //                                                     userData['Imgpath']),
// // // //                                               ),
// // // //                                             ),
// // // //                                             SizedBox(width: 10),
// // // //                                             Expanded(
// // // //                                               flex: 6,
// // // //                                               child: Column(
// // // //                                                 mainAxisAlignment:
// // // //                                                     MainAxisAlignment.start,
// // // //                                                 crossAxisAlignment:
// // // //                                                     CrossAxisAlignment.start,
// // // //                                                 children: [
// // // //                                                   Text(
// // // //                                                     "Booking ID: ${userData['OrderID']}",
// // // //                                                     style: TextStyle(
// // // //                                                         fontSize: 12,
// // // //                                                         fontWeight:
// // // //                                                             FontWeight.bold),
// // // //                                                   ),
// // // //                                                   Row(
// // // //                                                     children: [
// // // //                                                       Text(
// // // //                                                         "Schedule:",
// // // //                                                         style: TextStyle(
// // // //                                                             fontSize: 12,
// // // //                                                             fontWeight:
// // // //                                                                 FontWeight
// // // //                                                                     .bold),
// // // //                                                         overflow: TextOverflow
// // // //                                                             .ellipsis,
// // // //                                                       ),
// // // //                                                       SizedBox(width: 12),
// // // //                                                       Text(
// // // //                                                         userData['Date'],
// // // //                                                         style: TextStyle(
// // // //                                                             fontSize: 12,
// // // //                                                             fontWeight:
// // // //                                                                 FontWeight
// // // //                                                                     .bold),
// // // //                                                         overflow: TextOverflow
// // // //                                                             .ellipsis,
// // // //                                                       ),
// // // //                                                       SizedBox(width: 3),
// // // //                                                       Text(
// // // //                                                         userData['Time'],
// // // //                                                         style: TextStyle(
// // // //                                                             fontSize: 12,
// // // //                                                             fontWeight:
// // // //                                                                 FontWeight
// // // //                                                                     .bold),
// // // //                                                         overflow: TextOverflow
// // // //                                                             .ellipsis,
// // // //                                                       ),
// // // //                                                     ],
// // // //                                                   )
// // // //                                                 ],
// // // //                                               ),
// // // //                                             ),
// // // //                                             SizedBox(width: 5),
// // // //                                             Expanded(
// // // //                                               child:
// // // //                                                   Icon(Icons.arrow_forward_ios),
// // // //                                             )
// // // //                                           ],
// // // //                                         )
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                               );
// // // //                             }));
// // // //                       } else {
// // // //                         return Scaffold(
// // // //                           backgroundColor: Colors.white,
// // // //                           body: Center(
// // // //                             child: Column(
// // // //                               mainAxisAlignment: MainAxisAlignment.center,
// // // //                               children: [
// // // //                                 SizedBox(height: 20),
// // // //                                 Text(
// // // //                                   "There is no bookings",
// // // //                                   style: TextStyle(fontWeight: FontWeight.w900),
// // // //                                 )
// // // //                               ],
// // // //                             ),
// // // //                           ),
// // // //                         );
// // // //                       }
// // // //                     },
// // // //                   ),
// // // //                 ),
// // // //               ],
// // // //             )),
// // // //       ),
// // // //     );
// // // //   }
// // // // }







// // // import 'package:firebase_database/firebase_database.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:sahulatapp/admin/ui/user_workers_bookings/booking_details.dart';
// // // import 'package:sahulatapp/admin/ui/user_workers_bookings/users_details.dart';

// // // class UserOrderDetails extends StatefulWidget {
// // //   final String userid;
// // //   const UserOrderDetails({super.key, required this.userid});

// // //   @override
// // //   State<UserOrderDetails> createState() => _UserOrderDetailsState();
// // // }

// // // class _UserOrderDetailsState extends State<UserOrderDetails> {
// // //   int totalUsers = 0;
// // //   String username = '';
// // //   final ref = FirebaseDatabase.instance.ref('AllOrders');
// // //   String _showVerified = '1'; // Default filter option

// // //   Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String filter) {
// // //     final query = ref;

// // //     return query
// // //         .orderByChild("UserID")
// // //         .equalTo(widget.userid)
// // //         .onValue
// // //         .map((event) {
// // //       final dataSnapshot = event.snapshot;
// // //       final userList = dataSnapshot.value ?? {};

// // //       if (userList is Map<dynamic, dynamic>) {
// // //         if (filter == '1') {
// // //           final filteredList = userList.values.toList();

// // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // //         }
// // //         if (filter == '2') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Pending')
// // //               .toList();

// // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // //         }
// // //         if (filter == '3') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Confirmed')
// // //               .toList();

// // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // //         }
// // //         if (filter == '4') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Completed')
// // //               .toList();

// // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // //         }
// // //         if (filter == '5') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Canceled')
// // //               .toList();

// // //           return filteredList.cast<Map<dynamic, dynamic>>();
// // //         }
// // //       }

// // //       return [];
// // //     });
// // //   }

// // //   void _showFilterOptions() {
// // //     showModalBottomSheet<void>(
// // //       context: context,
// // //       builder: (BuildContext context) {
// // //         return Container(
// // //           child: Column(
// // //             mainAxisSize: MainAxisSize.min,
// // //             children: [
// // //               ListTile(
// // //                 title: Text('All'),
// // //                 onTap: () {
// // //                   setState(() {
// // //                     _showVerified = '1';
// // //                   });
// // //                   _totalusers(_showVerified);
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 title: Text('Pending'),
// // //                 onTap: () {
// // //                   setState(() {
// // //                     _showVerified = '2';
// // //                   });
// // //                   _totalusers(_showVerified);
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 title: Text('Confirmed'),
// // //                 onTap: () {
// // //                   setState(() {
// // //                     _showVerified = '3';
// // //                   });
// // //                   _totalusers(_showVerified);
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 title: Text('Completed'),
// // //                 onTap: () {
// // //                   setState(() {
// // //                     _showVerified = '4';
// // //                   });
// // //                   _totalusers(_showVerified);
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //               ListTile(
// // //                 title: Text('Canceled'),
// // //                 onTap: () {
// // //                   setState(() {
// // //                     _showVerified = '5';
// // //                   });
// // //                   _totalusers(_showVerified);
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //             ],
// // //           ),
// // //         );
// // //       },
// // //     );
// // //   }

// // //   void _totalusers(String filter) {
// // //     ref.onValue.listen((event) {
// // //       final dataSnapshot = event.snapshot;
// // //       final userList = dataSnapshot.value ?? {};

// // //       if (userList is Map<dynamic, dynamic>) {
// // //         // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'

// // //         if (filter == '1') {
// // //           final filteredList = userList.values.toList();
// // //           setState(() {
// // //             totalUsers = filteredList.length;
// // //             username = 'Total';
// // //           });
// // //         }
// // //         if (filter == '2') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Pending')
// // //               .toList();
// // //           setState(() {
// // //             totalUsers = filteredList.length;
// // //             username = 'Pending Bookings';
// // //           });
// // //         }
// // //         if (filter == '3') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Confirmed')
// // //               .toList();
// // //           setState(() {
// // //             totalUsers = filteredList.length;
// // //             username = 'Confirmed Bookings';
// // //           });
// // //         }
// // //         if (filter == '4') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Completed')
// // //               .toList();
// // //           setState(() {
// // //             totalUsers = filteredList.length;
// // //             username = 'Completed Bookings';
// // //           });
// // //         }
// // //         if (filter == '5') {
// // //           final filteredList = userList.values
// // //               .where((userData) => userData['bookingstatus'] == 'Canceled')
// // //               .toList();
// // //           setState(() {
// // //             totalUsers = filteredList.length;
// // //             username = 'Canceled Bookings';
// // //           });
// // //         }
// // //       }
// // //     });
// // //   }

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _totalusers('1');
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return SafeArea(
// // //       child: Expanded(
// // //         child: Scaffold(
// // //             backgroundColor: Colors.white,
// // //             appBar: AppBar(
// // //               actions: [
// // //                 Center(
// // //                   child: Text(
// // //                     "${username} : ${totalUsers}",
// // //                     style: TextStyle(
// // //                       color: Color(0xff9749ff),
// // //                     ),
// // //                   ),
// // //                 )
// // //               ],
// // //               leading: GestureDetector(
// // //                 child: Icon(
// // //                   Icons.arrow_back_ios,
// // //                   color: Color(0xff9749ff),
// // //                   size: 22,
// // //                 ),
// // //                 onTap: () {
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //               title: Text(
// // //                 "Bookings",
// // //                 style: TextStyle(
// // //                   // fontWeight: FontWeight.bold,
// // //                   color: Color(0xff9749ff),
// // //                 ),
// // //               ),
// // //               elevation: 1,
// // //               automaticallyImplyLeading: false,
// // //               shadowColor: Colors.white,
// // //               bottomOpacity: 10,
// // //               backgroundColor: Colors.white,
// // //             ),
// // //             floatingActionButton: FloatingActionButton(
// // //               backgroundColor: Color(0xff9749ff),
// // //               onPressed: _showFilterOptions,
// // //               child: Icon(Icons.filter_list),
// // //             ),
// // //             body: Column(
// // //               children: [
// // //                 // Text("${username} : ${totalUsers}"),
// // //                 Expanded(
// // //                   child: StreamBuilder(
// // //                     stream: fetchUsersWithAge(_showVerified),
// // //                     builder: (context, snapshot) {
// // //                       if (snapshot.connectionState == ConnectionState.waiting) {
// // //                         return Center(
// // //                           child: Container(
// // //                             width: 120,
// // //                             child: LinearProgressIndicator(
// // //                               minHeight: 5,
// // //                               backgroundColor: Colors.black,
// // //                               // strokeWidth: 3,
// // //                               valueColor:
// // //                                   AlwaysStoppedAnimation<Color>(Colors.blue),
// // //                             ),
// // //                           ),
// // //                         );
// // //                       } else if (snapshot.hasData &&
// // //                           snapshot.data != null &&
// // //                           (snapshot.data as List).isNotEmpty) {
// // //                         final userList = snapshot.data!;
// // //                         return ListView.builder(
// // //                             itemCount: userList.length,
// // //                             itemBuilder: ((context, index) {
// // //                               final userData = userList[index];
// // //                               return InkWell(
// // //                                 onTap: () {
// // //                                   Navigator.push(
// // //                                       context,
// // //                                       MaterialPageRoute(
// // //                                         builder: (context) =>
// // //                                             BookingDetailsScreen(
// // //                                           phone: userData['PhoneNo'],
// // //                                           providerid: userData['providerid'],
// // //                                           CustomerName: userData['Name'],
// // //                                           ProviderName:
// // //                                               userData['providername'],
// // //                                           ServiceName: userData['ServiceName'],
// // //                                           img: userData['Imgpath'],
// // //                                           Time: userData['Time'],
// // //                                           Date: userData['Date'],
// // //                                           Address: userData['Address'],
// // //                                           Expert: userData['Expert'],
// // //                                           OrderID: userData['OrderID'],
// // //                                           Price: userData['Price'],
// // //                                           requestSubmit:
// // //                                               userData['RequestSubmit'],
// // //                                           requestAccept:
// // //                                               userData['RequestAccept'],
// // //                                           workInProgress:
// // //                                               userData['Workinprog'],
// // //                                           workdone: userData['workdone'],
// // //                                           requestacceptdate:
// // //                                               userData['RequestAcceptedDate'],
// // //                                           requestaccepttime:
// // //                                               userData['RequestAcceptedTime'],
// // //                                           bookingstatus:
// // //                                               userData['bookingstatus'],
// // //                                           requestsubmitdate:
// // //                                               userData['requestsubmitdate'],
// // //                                           requestsubmittime:
// // //                                               userData['requestsubmittime'],
// // //                                           workdonedate:
// // //                                               userData['workdonedate'],
// // //                                           workdonetime:
// // //                                               userData['workdonetime'],
// // //                                           workinprogdate:
// // //                                               userData['workprogressdate'],
// // //                                           workinprogtime:
// // //                                               userData['workprogresstime'],
// // //                                           requestcanceldate:
// // //                                               userData['requestcanceldate'],
// // //                                           requestcanceltime:
// // //                                               userData['requestcanceltime'],
// // //                                           requestcancel:
// // //                                               userData['Requestcancel'],
// // //                                         ),
// // //                                       ));
// // //                                 },
// // //                                 child: Container(
// // //                                   margin: const EdgeInsets.symmetric(
// // //                                       horizontal: 12, vertical: 8),
// // //                                   width: 50,
// // //                                   height: 80,
// // //                                   decoration: BoxDecoration(
// // //                                     boxShadow: const [
// // //                                       BoxShadow(
// // //                                         color:
// // //                                             Color.fromARGB(255, 208, 184, 255),
// // //                                         spreadRadius: 0,
// // //                                         blurRadius: 10,
// // //                                         offset: Offset(0, 2),
// // //                                       ),
// // //                                     ],
// // //                                     color: Colors.white,
// // //                                     borderRadius: BorderRadius.circular(20),
// // //                                   ),
// // //                                   child: Padding(
// // //                                     padding: const EdgeInsets.all(5.0),
// // //                                     child: Column(
// // //                                       mainAxisAlignment:
// // //                                           MainAxisAlignment.center,
// // //                                       children: [
// // //                                         Row(
// // //                                           children: [
// // //                                             Expanded(
// // //                                               flex: 2,
// // //                                               child: CircleAvatar(
// // //                                                 radius: 35,
// // //                                                 backgroundImage: AssetImage(
// // //                                                     userData['Imgpath']),
// // //                                               ),
// // //                                             ),
// // //                                             SizedBox(width: 10),
// // //                                             Expanded(
// // //                                               flex: 6,
// // //                                               child: Column(
// // //                                                 mainAxisAlignment:
// // //                                                     MainAxisAlignment.start,
// // //                                                 crossAxisAlignment:
// // //                                                     CrossAxisAlignment.start,
// // //                                                 children: [
// // //                                                   Text(
// // //                                                     "Booking ID: ${userData['OrderID']}",
// // //                                                     style: TextStyle(
// // //                                                         fontSize: 12,
// // //                                                         fontWeight:
// // //                                                             FontWeight.bold),
// // //                                                   ),
// // //                                                   Row(
// // //                                                     children: [
// // //                                                       Text(
// // //                                                         "Schedule:",
// // //                                                         style: TextStyle(
// // //                                                             fontSize: 12,
// // //                                                             fontWeight:
// // //                                                                 FontWeight
// // //                                                                     .bold),
// // //                                                         overflow: TextOverflow
// // //                                                             .ellipsis,
// // //                                                       ),
// // //                                                       SizedBox(width: 12),
// // //                                                       Text(
// // //                                                         userData['Date'],
// // //                                                         style: TextStyle(
// // //                                                             fontSize: 12,
// // //                                                             fontWeight:
// // //                                                                 FontWeight
// // //                                                                     .bold),
// // //                                                         overflow: TextOverflow
// // //                                                             .ellipsis,
// // //                                                       ),
// // //                                                       SizedBox(width: 3),
// // //                                                       Text(
// // //                                                         userData['Time'],
// // //                                                         style: TextStyle(
// // //                                                             fontSize: 12,
// // //                                                             fontWeight:
// // //                                                                 FontWeight
// // //                                                                     .bold),
// // //                                                         overflow: TextOverflow
// // //                                                             .ellipsis,
// // //                                                       ),
// // //                                                     ],
// // //                                                   )
// // //                                                 ],
// // //                                               ),
// // //                                             ),
// // //                                             SizedBox(width: 5),
// // //                                             Expanded(
// // //                                               child:
// // //                                                   Icon(Icons.arrow_forward_ios),
// // //                                             )
// // //                                           ],
// // //                                         )
// // //                                       ],
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               );
// // //                             }));
// // //                       } else {
// // //                         return Scaffold(
// // //                           backgroundColor: Colors.white,
// // //                           body: Center(
// // //                             child: Column(
// // //                               mainAxisAlignment: MainAxisAlignment.center,
// // //                               children: [
// // //                                 SizedBox(height: 20),
// // //                                 Text(
// // //                                   "There is no ${username}",
// // //                                   style: TextStyle(fontWeight: FontWeight.w900),
// // //                                 )
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         );
// // //                       }
// // //                     },
// // //                   ),
// // //                 ),
// // //               ],
// // //             )),
// // //       ),
// // //     );
// // //   }
// // // }



// // // Widget build(BuildContext context) {
// // //     return SafeArea(
// // //       child: Expanded(
// // //         child: Scaffold(
// // //             backgroundColor: Colors.white,
// // //             appBar: AppBar(
// // //               actions: [
// // //                 Center(
// // //                   child: Text(
// // //                     "${username} : ${totalUsers}",
// // //                     style: TextStyle(
// // //                       color: Color(0xff9749ff),
// // //                     ),
// // //                   ),
// // //                 )
// // //               ],
// // //               leading: GestureDetector(
// // //                 child: Icon(
// // //                   Icons.arrow_back_ios,
// // //                   color: Color(0xff9749ff),
// // //                   size: 22,
// // //                 ),
// // //                 onTap: () {
// // //                   Navigator.pop(context);
// // //                 },
// // //               ),
// // //               title: Text(
// // //                 "Bookings",
// // //                 style: TextStyle(
// // //                   // fontWeight: FontWeight.bold,
// // //                   color: Color(0xff9749ff),
// // //                 ),
// // //               ),
// // //               elevation: 1,
// // //               automaticallyImplyLeading: false,
// // //               shadowColor: Colors.white,
// // //               bottomOpacity: 10,
// // //               backgroundColor: Colors.white,
// // //             ),
// // //             floatingActionButton: FloatingActionButton(
// // //               backgroundColor: Color(0xff9749ff),
// // //               onPressed: _showFilterOptions,
// // //               child: Icon(Icons.filter_list),
// // //             ),
// // //             body: Column(
// // //               children: [
// // //                 // Text("${username} : ${totalUsers}"),
// // //                 Expanded(
// // //                   child: StreamBuilder(
// // //                     stream: fetchUsersWithAge(_showVerified),
// // //                     builder: (context, snapshot) {
// // //                       if (snapshot.connectionState == ConnectionState.waiting) {
// // //                         return Center(
// // //                           child: Container(
// // //                             width: 120,
// // //                             child: LinearProgressIndicator(
// // //                               minHeight: 5,
// // //                               backgroundColor: Colors.black,
// // //                               // strokeWidth: 3,
// // //                               valueColor:
// // //                                   AlwaysStoppedAnimation<Color>(Colors.blue),
// // //                             ),
// // //                           ),
// // //                         );
// // //                       } else if (snapshot.hasData &&
// // //                           snapshot.data != null &&
// // //                           (snapshot.data as List).isNotEmpty) {
// // //                         final userList = snapshot.data!;
// // //                         return ListView.builder(
// // //                             itemCount: userList.length,
// // //                             itemBuilder: ((context, index) {
// // //                               final userData = userList[index];
// // //                               return InkWell(
// // //                                 onTap: () {
// // //                                   Navigator.push(
// // //                                       context,
// // //                                       MaterialPageRoute(
// // //                                         builder: (context) =>
// // //                                             BookingDetailsScreen(
// // //                                           phone: userData['PhoneNo'],
// // //                                           providerid: userData['providerid'],
// // //                                           CustomerName: userData['Name'],
// // //                                           ProviderName:
// // //                                               userData['providername'],
// // //                                           ServiceName: userData['ServiceName'],
// // //                                           img: userData['Imgpath'],
// // //                                           Time: userData['Time'],
// // //                                           Date: userData['Date'],
// // //                                           Address: userData['Address'],
// // //                                           Expert: userData['Expert'],
// // //                                           OrderID: userData['OrderID'],
// // //                                           Price: userData['Price'],
// // //                                           requestSubmit:
// // //                                               userData['RequestSubmit'],
// // //                                           requestAccept:
// // //                                               userData['RequestAccept'],
// // //                                           workInProgress:
// // //                                               userData['Workinprog'],
// // //                                           workdone: userData['workdone'],
// // //                                           requestacceptdate:
// // //                                               userData['RequestAcceptedDate'],
// // //                                           requestaccepttime:
// // //                                               userData['RequestAcceptedTime'],
// // //                                           bookingstatus:
// // //                                               userData['bookingstatus'],
// // //                                           requestsubmitdate:
// // //                                               userData['requestsubmitdate'],
// // //                                           requestsubmittime:
// // //                                               userData['requestsubmittime'],
// // //                                           workdonedate:
// // //                                               userData['workdonedate'],
// // //                                           workdonetime:
// // //                                               userData['workdonetime'],
// // //                                           workinprogdate:
// // //                                               userData['workprogressdate'],
// // //                                           workinprogtime:
// // //                                               userData['workprogresstime'],
// // //                                           requestcanceldate:
// // //                                               userData['requestcanceldate'],
// // //                                           requestcanceltime:
// // //                                               userData['requestcanceltime'],
// // //                                           requestcancel:
// // //                                               userData['Requestcancel'],
// // //                                         ),
// // //                                       ));
// // //                                 },
// // //                                 child: Container(
// // //                                   margin: const EdgeInsets.symmetric(
// // //                                       horizontal: 12, vertical: 8),
// // //                                   width: 50,
// // //                                   height: 80,
// // //                                   decoration: BoxDecoration(
// // //                                     boxShadow: const [
// // //                                       BoxShadow(
// // //                                         color:
// // //                                             Color.fromARGB(255, 208, 184, 255),
// // //                                         spreadRadius: 0,
// // //                                         blurRadius: 10,
// // //                                         offset: Offset(0, 2),
// // //                                       ),
// // //                                     ],
// // //                                     color: Colors.white,
// // //                                     borderRadius: BorderRadius.circular(20),
// // //                                   ),
// // //                                   child: Padding(
// // //                                     padding: const EdgeInsets.all(5.0),
// // //                                     child: Column(
// // //                                       mainAxisAlignment:
// // //                                           MainAxisAlignment.center,
// // //                                       children: [
// // //                                         Row(
// // //                                           children: [
// // //                                             Expanded(
// // //                                               flex: 2,
// // //                                               child: CircleAvatar(
// // //                                                 radius: 35,
// // //                                                 backgroundImage: AssetImage(
// // //                                                     userData['Imgpath']),
// // //                                               ),
// // //                                             ),
// // //                                             SizedBox(width: 10),
// // //                                             Expanded(
// // //                                               flex: 6,
// // //                                               child: Column(
// // //                                                 mainAxisAlignment:
// // //                                                     MainAxisAlignment.start,
// // //                                                 crossAxisAlignment:
// // //                                                     CrossAxisAlignment.start,
// // //                                                 children: [
// // //                                                   Text(
// // //                                                     "Booking ID: ${userData['OrderID']}",
// // //                                                     style: TextStyle(
// // //                                                         fontSize: 12,
// // //                                                         fontWeight:
// // //                                                             FontWeight.bold),
// // //                                                   ),
// // //                                                   Row(
// // //                                                     children: [
// // //                                                       Text(
// // //                                                         "Schedule:",
// // //                                                         style: TextStyle(
// // //                                                             fontSize: 12,
// // //                                                             fontWeight:
// // //                                                                 FontWeight
// // //                                                                     .bold),
// // //                                                         overflow: TextOverflow
// // //                                                             .ellipsis,
// // //                                                       ),
// // //                                                       SizedBox(width: 12),
// // //                                                       Text(
// // //                                                         userData['Date'],
// // //                                                         style: TextStyle(
// // //                                                             fontSize: 12,
// // //                                                             fontWeight:
// // //                                                                 FontWeight
// // //                                                                     .bold),
// // //                                                         overflow: TextOverflow
// // //                                                             .ellipsis,
// // //                                                       ),
// // //                                                       SizedBox(width: 3),
// // //                                                       Text(
// // //                                                         userData['Time'],
// // //                                                         style: TextStyle(
// // //                                                             fontSize: 12,
// // //                                                             fontWeight:
// // //                                                                 FontWeight
// // //                                                                     .bold),
// // //                                                         overflow: TextOverflow
// // //                                                             .ellipsis,
// // //                                                       ),
// // //                                                     ],
// // //                                                   )
// // //                                                 ],
// // //                                               ),
// // //                                             ),
// // //                                             SizedBox(width: 5),
// // //                                             Expanded(
// // //                                               child:
// // //                                                   Icon(Icons.arrow_forward_ios),
// // //                                             )
// // //                                           ],
// // //                                         )
// // //                                       ],
// // //                                     ),
// // //                                   ),
// // //                                 ),
// // //                               );
// // //                             }));
// // //                       } else {
// // //                         return Scaffold(
// // //                           backgroundColor: Colors.white,
// // //                           body: Center(
// // //                             child: Column(
// // //                               mainAxisAlignment: MainAxisAlignment.center,
// // //                               children: [
// // //                                 SizedBox(height: 20),
// // //                                 Text(
// // //                                   "There is no ${username}",
// // //                                   style: TextStyle(fontWeight: FontWeight.w900),
// // //                                 )
// // //                               ],
// // //                             ),
// // //                           ),
// // //                         );
// // //                       }
// // //                     },
// // //                   ),
// // //                 ),
// // //               ],
// // //             )),
// // //       ),
// // //     );
// // //   }




// // Widget build(BuildContext context) {
// //     Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho) {
// //       final query = ref.orderByChild('providerid').equalTo(desired);

// //       return query.onValue.map((event) {
// //         final dataSnapshot = event.snapshot;
// //         final userList = dataSnapshot.value ?? {};

// //         if (userList is Map<dynamic, dynamic>) {
// //           // Filter the userList to get only the entries where 'AddressVerification' is not null
// //           final filteredList = userList.values
// //               .where((userData) => userData['bookingstatus'] == 'Pending')
// //               .toList();

// //           return filteredList.cast<Map<dynamic, dynamic>>();
// //         }

// //         return [];
// //       });
// //     }

// //     return WillPopScope(
// //       onWillPop: () async {
// //         // This block of code will be executed when the user presses the back button
// //         return false;
// //       },
// //       child: SafeArea(
// //         child: Scaffold(
// //           appBar: AppBar(
// //             elevation: 1,
// //             shadowColor: Color.fromARGB(255, 125, 60, 255),
// //             automaticallyImplyLeading: false,
// //             title: Text(
// //               "Dashboard",
// //               style: TextStyle(
// //                 color: Color(0xff9749ff),
// //               ),
// //             ),
// //             backgroundColor: Colors.white,
// //             actions: [],
// //           ),
// //           body: Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 14),
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.center,
// //                   children: [
// //                     Column(
// //                       children: [
// //                         InkWell(
// //                           onTap: () {
// //                             Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) => const OrdersScreen(
// //                                           showAppBar: true,
// //                                         )));
// //                           },
// //                           child: LeftCAnimation(
// //                             child: Container(
// //                               height: 140,
// //                               width: 80,
// //                               decoration: BoxDecoration(
// //                                   boxShadow: const [
// //                                     BoxShadow(
// //                                       color: Color.fromARGB(255, 208, 184, 255),
// //                                       spreadRadius: 0,
// //                                       blurRadius: 10,
// //                                       offset: Offset(0, 13),
// //                                     ),
// //                                   ],
// //                                   borderRadius: BorderRadius.circular(15),
// //                                   gradient: LinearGradient(
// //                                       // stops: [0.6, 0.5],

// //                                       // begin: Alignment.topRight,
// //                                       // end: Alignment.bottomLeft,
// //                                       begin: FractionalOffset(0.2, 0.4),
// //                                       end: FractionalOffset(1.0, 1.0),
// //                                       colors: [
// //                                         Color.fromARGB(255, 164, 119, 255),
// //                                         Color.fromARGB(255, 125, 60, 255),
// //                                         // Color.fromARGB(255, 0, 255, 94),
// //                                       ])),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   // Expanded(
// //                                   //     child: Text(
// //                                   //   'Confirm',
// //                                   //   style: TextStyle(color: Colors.white),
// //                                   // )),
// //                                   Center(
// //                                     child: Expanded(
// //                                         child: Text('$pendingbooking',
// //                                             style: TextStyle(
// //                                                 color: Colors.white,
// //                                                 fontSize: 20,
// //                                                 fontWeight: FontWeight.bold))),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           height: 10,
// //                         ),
// //                         LeftAnimation(child: Text('Pending'))
// //                       ],
// //                     ),
// //                     SizedBox(
// //                       width: 20,
// //                     ),
// //                     Column(
// //                       children: [
// //                         InkWell(
// //                           onTap: () {
// //                             Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) => const ConfirmScreen(
// //                                           showAppBar: true,
// //                                         )));
// //                           },
// //                           child: TopCAnimation(
// //                             child: Container(
// //                               height: 140,
// //                               width: 80,
// //                               decoration: BoxDecoration(
// //                                   boxShadow: const [
// //                                     BoxShadow(
// //                                       color: Color.fromARGB(255, 208, 184, 255),
// //                                       spreadRadius: 0,
// //                                       blurRadius: 10,
// //                                       offset: Offset(0, 13),
// //                                     ),
// //                                   ],
// //                                   borderRadius: BorderRadius.circular(15),
// //                                   gradient: LinearGradient(
// //                                       // stops: [0.6, 0.5],

// //                                       // begin: Alignment.topRight,
// //                                       // end: Alignment.bottomLeft,
// //                                       begin: FractionalOffset(0.2, 0.4),
// //                                       end: FractionalOffset(1.0, 1.0),
// //                                       colors: [
// //                                         Color.fromARGB(255, 164, 119, 255),
// //                                         Color.fromARGB(255, 125, 60, 255),
// //                                         // Color.fromARGB(255, 0, 255, 94),
// //                                       ])),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   // Expanded(
// //                                   //     child: Text(
// //                                   //   'Confirm',
// //                                   //   style: TextStyle(color: Colors.white),
// //                                   // )),
// //                                   Center(
// //                                     child: Expanded(
// //                                         child: Text('$confirmbooking',
// //                                             style: TextStyle(
// //                                                 color: Colors.white,
// //                                                 fontSize: 20,
// //                                                 fontWeight: FontWeight.bold))),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           height: 10,
// //                         ),
// //                         TopAnimation(child: Text('Confirm'))
// //                       ],
// //                     ),
// //                     SizedBox(
// //                       width: 20,
// //                     ),
// //                     Column(
// //                       children: [
// //                         InkWell(
// //                           onTap: () {
// //                             Navigator.push(
// //                                 context,
// //                                 MaterialPageRoute(
// //                                     builder: (context) => const CompletedScreen(
// //                                           showAppBar: true,
// //                                         )));
// //                           },
// //                           child: RightCAnimation(
// //                             child: Container(
// //                               height: 140,
// //                               width: 80,
// //                               decoration: BoxDecoration(
// //                                   boxShadow: const [
// //                                     BoxShadow(
// //                                       color: Color.fromARGB(255, 208, 184, 255),
// //                                       spreadRadius: 0,
// //                                       blurRadius: 10,
// //                                       offset: Offset(0, 13),
// //                                     ),
// //                                   ],
// //                                   borderRadius: BorderRadius.circular(15),
// //                                   gradient: LinearGradient(
// //                                       // stops: [0.6, 0.5],

// //                                       // begin: Alignment.topRight,
// //                                       // end: Alignment.bottomLeft,
// //                                       begin: FractionalOffset(0.2, 0.4),
// //                                       end: FractionalOffset(1.0, 1.0),
// //                                       colors: [
// //                                         Color.fromARGB(255, 164, 119, 255),
// //                                         Color.fromARGB(255, 125, 60, 255),
// //                                         // Color.fromARGB(255, 0, 255, 94),
// //                                       ])),
// //                               child: Column(
// //                                 mainAxisAlignment: MainAxisAlignment.center,
// //                                 children: [
// //                                   // Expanded(
// //                                   //     child: Text(
// //                                   //   'Confirm',
// //                                   //   style: TextStyle(color: Colors.white),
// //                                   // )),
// //                                   Center(
// //                                     child: Expanded(
// //                                         child: Text('$completedbooking',
// //                                             style: TextStyle(
// //                                                 color: Colors.white,
// //                                                 fontSize: 20,
// //                                                 fontWeight: FontWeight.bold))),
// //                                   ),
// //                                 ],
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(
// //                           height: 10,
// //                         ),
// //                         RightAnimation(child: Text('Completed'))
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(
// //                   height: 25,
// //                 ),
// //                 LeftAnimation(
// //                   child: Text("New bookings",
// //                       style: TextStyle(
// //                           fontSize: 25,
// //                           color: Color(0xff9749ff),
// //                           fontWeight: FontWeight.w500)),
// //                 ),
// //                 SizedBox(
// //                   height: 25,
// //                 ),
// //                 Expanded(
// //                   child: StreamBuilder(
// //                     // stream: ref.onValue,
// //                     stream: fetchUsersWithAge(desired),
// //                     // builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
// //                     //   if (snapshot.hasData &&
// //                     //       snapshot.data!.snapshot.value != null &&
// //                     //       snapshot.data!.snapshot.value
// //                     //           is Map<dynamic, dynamic>) {
// //                     //     Map<dynamic, dynamic> map =
// //                     //         snapshot.data!.snapshot.value as dynamic;
// //                     //     List<dynamic> list = [];

// //                     //     list = map.values.toList();
// //                     builder: (context, snapshot) {
// //                       if (snapshot.connectionState == ConnectionState.waiting) {
// //                         return const Center(
// //                           child: SizedBox(
// //                             width: 120,
// //                             child: LinearProgressIndicator(
// //                               minHeight: 5,
// //                               backgroundColor: Colors.black,
// //                               // strokeWidth: 3,
// //                               valueColor:
// //                                   AlwaysStoppedAnimation<Color>(Colors.blue),
// //                             ),
// //                           ),
// //                         );
// //                       } else if (snapshot.hasData &&
// //                           snapshot.data != null &&
// //                           (snapshot.data as List).isNotEmpty) {
// //                         final userList = snapshot.data!;
// //                         return ListView.builder(
// //                           // istemCount: snapshot.data!.snapshot.children.length,
// //                           itemCount: userList.length,
// //                           itemBuilder: ((context, index) {
// //                             final userData = userList[index];
// //                             final imgPath = userData['Imgpath'] as String?;
// //                             return GestureDetector(
// //                               onTap: () {
// //                                 // Navigate to new screen with selected item's data
// //                                 Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                     builder: (context) => OrderDetailScreen(
// //                                       // name: userData['ServiceName'],
// //                                       // names: userData['Name'],
// //                                       // date: userData['Date'],
// //                                       // price: userData['Price'],
// //                                       // imagePath: userData['Imgpath'],
// //                                       // address: userData['Address'],
// //                                       // // userid: list[index]['UserID'],
// //                                       // userid: userData['UserID'],
// //                                       // orderid: userData['OrderID'],
// //                                       // providerid: userData['providerid']

// //                                       providerid: userData['providerid'],
// //                                       userid: userData['UserID'],
// //                                       phone: userData['PhoneNo'],
// //                                       CustomerName: userData['Name'],
// //                                       ProviderName: userData['providername'],
// //                                       ServiceName: userData['ServiceName'],
// //                                       img: userData['Imgpath'],
// //                                       Time: userData['Time'],
// //                                       Date: userData['Date'],
// //                                       Address: userData['Address'],
// //                                       Expert: userData['Expert'],
// //                                       OrderID: userData['OrderID'],
// //                                       Price: userData['Price'],
// //                                       requestSubmit: userData['RequestSubmit'],
// //                                       requestAccept: userData['RequestAccept'],
// //                                       workInProgress: userData['Workinprog'],
// //                                       workdone: userData['workdone'],
// //                                       requestacceptdate:
// //                                           userData['RequestAcceptedDate'],
// //                                       requestaccepttime:
// //                                           userData['RequestAcceptedTime'],
// //                                       bookingstatus: userData['bookingstatus'],
// //                                       requestsubmitdate:
// //                                           userData['requestsubmitdate'],
// //                                       requestsubmittime:
// //                                           userData['requestsubmittime'],
// //                                       workdonedate: userData['workdonedate'],
// //                                       workdonetime: userData['workdonetime'],
// //                                       requestcancel: userData['Requestcancel'],
// //                                       workinprogdate:
// //                                           userData['workprogressdate'],
// //                                       workinprogtime:
// //                                           userData['workprogresstime'],
// //                                       requestcanceldate:
// //                                           userData['requestcanceldate'],
// //                                       requestcanceltime:
// //                                           userData['requestcanceltime'],
// //                                     ),
// //                                   ),
// //                                 );
// //                               },
// //                               child: Container(
// //                                 margin: const EdgeInsets.symmetric(
// //                                     horizontal: 12, vertical: 12),
// //                                 width: 50,
// //                                 height: 80,
// //                                 decoration: BoxDecoration(
// //                                   boxShadow: [
// //                                     BoxShadow(
// //                                       color: Color.fromARGB(255, 208, 184, 255),
// //                                       spreadRadius: 0,
// //                                       blurRadius: 10,
// //                                       offset: Offset(0, 9),
// //                                     ),
// //                                   ],
// //                                   color: Colors.white,
// //                                   borderRadius: BorderRadius.circular(20),
// //                                 ),
// //                                 child: Column(
// //                                   mainAxisAlignment: MainAxisAlignment.center,
// //                                   children: [
// //                                     Row(
// //                                       children: [
// //                                         SizedBox(width: 10),
// //                                         Expanded(
// //                                           flex: 2,
// //                                           child: CircleAvatar(
// //                                             radius: 35,
// //                                             backgroundImage: imgPath != null
// //                                                 ? AssetImage(imgPath)
// //                                                 : const AssetImage(
// //                                                     'assets/placeholder.png'),
// //                                           ),
// //                                         ),
// //                                         SizedBox(width: 10),
// //                                         Expanded(
// //                                           flex: 6,
// //                                           child: Column(
// //                                             mainAxisAlignment:
// //                                                 MainAxisAlignment.start,
// //                                             crossAxisAlignment:
// //                                                 CrossAxisAlignment.start,
// //                                             children: [
// //                                               Text(
// //                                                 "Booking ID: ${userData['OrderID']}",
// //                                                 style: const TextStyle(
// //                                                   fontSize: 10,
// //                                                   fontWeight: FontWeight.bold,
// //                                                 ),
// //                                               ),
// //                                               Row(
// //                                                 children: [
// //                                                   Text(
// //                                                     "Schedule:",
// //                                                     style: TextStyle(
// //                                                         fontSize: 10,
// //                                                         fontWeight:
// //                                                             FontWeight.bold),
// //                                                     overflow:
// //                                                         TextOverflow.ellipsis,
// //                                                   ),
// //                                                   SizedBox(width: 12),
// //                                                   Text(
// //                                                     userData['Date'],
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                     overflow:
// //                                                         TextOverflow.ellipsis,
// //                                                   ),
// //                                                   SizedBox(width: 3),
// //                                                   Text(
// //                                                     userData['Time'],
// //                                                     style: TextStyle(
// //                                                       fontSize: 12,
// //                                                     ),
// //                                                     overflow:
// //                                                         TextOverflow.ellipsis,
// //                                                   ),
// //                                                 ],
// //                                               )
// //                                             ],
// //                                           ),
// //                                         ),
// //                                         const SizedBox(width: 20),
// //                                         Icon(
// //                                           Icons.arrow_forward_ios,
// //                                           color:
// //                                               Color.fromARGB(255, 125, 60, 255),
// //                                         ),
// //                                         const SizedBox(
// //                                           width: 20,
// //                                         )
// //                                       ],
// //                                     )
// //                                   ],
// //                                 ),
// //                               ),
// //                             );
// //                           }),
// //                         );
// //                       } else {
// //                         return Scaffold(
// //                           body: Column(
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             children: [
// //                               SizedBox(height: 20),
// //                               Center(
// //                                 child: Text(
// //                                   "There is no new booking",
// //                                   style: TextStyle(fontWeight: FontWeight.w900),
// //                                 ),
// //                               )
// //                             ],
// //                           ),
// //                         );
// //                       }
// //                     },
// //                   ),
// //                 )
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }



// ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   const Color.fromARGB(255, 238, 237, 237),
//                               foregroundColor: const Color.fromARGB(255, 50, 0,
//                                   119), // Change the button text color
//                               textStyle: const TextStyle(
//                                   fontSize: 15), // Change the button text size
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     20), // Change button border radius
//                               ),
//                             ),
//                             onPressed: () {
//                               DatePicker.showDatePicker(
//                                 context,
//                                 showTitleActions: true,
//                                 minTime: DateTime.now(),
//                                 onConfirm: (date) {
//                                   setState(() {
//                                     selectedDate = date;
//                                   });
//                                 },
//                                 currentTime: selectedDate,
//                                 locale: LocaleType.en,
//                               );
//                             },
//                             child: const Text("Date")),
                        



//                         ElevatedButton(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor:
//                                   const Color.fromARGB(255, 238, 237, 237),
//                               foregroundColor: const Color.fromARGB(255, 50, 0,
//                                   119), // Change the button text color
//                               textStyle: const TextStyle(
//                                   fontSize: 15), // Change the button text size
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(
//                                     20), // Change button border radius
//                               ),
//                             ),
//                             onPressed: () {
//                               DatePicker.showTime12hPicker(
//                                 context,
//                                 showTitleActions: true,
//                                 onConfirm: (time) {
//                                   setState(() {
//                                     final selectedDateTime = DateTime(
//                                       selectedDate.year,
//                                       selectedDate.month,
//                                       selectedDate.day,
//                                       time.hour,
//                                       time.minute,
//                                     );
//                                     // debugPrint("Time:: $selectedDateTime");

//                                     debugPrint("Timess:: $selectedDateTime");
//                                     selectedTime = TimeOfDay.fromDateTime(
//                                         selectedDateTime);
//                                   });
//                                 },
//                                 currentTime: selectedTime != null
//                                     ? DateTime(
//                                         selectedDate.year,
//                                         selectedDate.month,
//                                         selectedDate.day,
//                                         selectedTime.hour,
//                                         selectedTime.minute,
//                                       )
//                                     : DateTime.now(),
//                                 locale: LocaleType.en,
//                               );
//                             },
//                             child: const Text("Time")),
                        