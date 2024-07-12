import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/bookings_details_service.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/new_booking_details_servicepro.dart';

class CompletedScreen extends StatefulWidget {
  final bool showAppBar;

  const CompletedScreen({super.key, required this.showAppBar});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  final auth = FirebaseAuth.instance;
  final uids = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef = FirebaseDatabase.instance.ref('Provider');
  final databaseReference = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final userRef = FirebaseDatabase.instance
      .ref('Provider')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('Name');

  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final String desired = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho) {
      final query = ref.orderByChild('providerid').equalTo(desired);

      return query.onValue.map((event) {
        final dataSnapshot = event.snapshot;
        final userList = dataSnapshot.value ?? {};

        if (userList is Map<dynamic, dynamic>) {
          // Filter the userList to get only the entries where 'AddressVerification' is not null
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Completed')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }

        return [];
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: widget.showAppBar
            ? AppBar(
                elevation: 1,
                shadowColor: Color.fromARGB(255, 125, 60, 255),
                automaticallyImplyLeading: false,
                title: Text(
                  "Completed Bookings",
                  style: TextStyle(
                    color: Color(0xff9749ff),
                  ),
                ),
                backgroundColor: Colors.white,
                actions: [
                  // IconButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       PageRouteBuilder(
                  //         transitionDuration: Duration(milliseconds: 1000),
                  //         transitionsBuilder:
                  //             (context, animation, secondaryAnimation, child) {
                  //           var begin = Offset(1.0, 0.0);
                  //           var end = Offset.zero;
                  //           var curve = Curves.ease;

                  //           var tween = Tween(begin: begin, end: end)
                  //               .chain(CurveTween(curve: curve));
                  //           return SlideTransition(
                  //             position: animation.drive(tween),
                  //             child: child,
                  //           );
                  //         },
                  //         pageBuilder: (context, animation, secondaryAnimation) {
                  //           return ProfilesTwo();
                  //         },
                  //       ),
                  //     );
                  //     //   userRef.once().then((DatabaseEvent event) {
                  //     //     String Name = 'empty';
                  //     //     DataSnapshot snapshot = event.snapshot;
                  //     //     Name = snapshot.value.toString();

                  //     //     return Name;
                  //     //   }).then((Name) {
                  //     //     if (Name == "null") {
                  //     //       Navigator.push(
                  //     //         context,
                  //     //         PageRouteBuilder(
                  //     //           transitionDuration: Duration(milliseconds: 100),
                  //     //           transitionsBuilder:
                  //     //               (context, animation, secondaryAnimation, child) {
                  //     //             var begin = Offset(1.0, 0.0);
                  //     //             var end = Offset.zero;
                  //     //             var curve = Curves.ease;

                  //     //             var tween = Tween(begin: begin, end: end)
                  //     //                 .chain(CurveTween(curve: curve));
                  //     //             return SlideTransition(
                  //     //               position: animation.drive(tween),
                  //     //               child: child,
                  //     //             );
                  //     //           },
                  //     //           pageBuilder: (context, animation, secondaryAnimation) {
                  //     //             return ProfilesScreen();
                  //     //           },
                  //     //         ),
                  //     //       );
                  //     //       // Navigator.push(
                  //     //       //     context,
                  //     //       //     MaterialPageRoute(
                  //     //       //         builder: (context) => const ProfileScreen()));
                  //     //     } else {

                  //     //       // Navigator.push(
                  //     //       //     context,
                  //     //       //     MaterialPageRoute(
                  //     //       //         builder: (context) => const ProfileTwo()));
                  //     //     }
                  //     //   });
                  //   },
                  //   icon: const Icon(Icons.account_circle),
                  // ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              )
            : null,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: fetchUsersWithAge(desired),
            // builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //   if (snapshot.hasData &&
            //       snapshot.data!.snapshot.value != null &&
            //       snapshot.data!.snapshot.value is Map<dynamic, dynamic>) {
            //     Map<dynamic, dynamic> map =
            //         snapshot.data!.snapshot.value as dynamic;
            //     List<dynamic> list = [];

            //     list = map.values.toList();
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData &&
                  snapshot.data != null &&
                  (snapshot.data as List).isNotEmpty) {
                final userList = snapshot.data!;
                return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: ((context, index) {
                    final userData = userList[index];
                    final imgPath = userData['Imgpath'] as String?;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookingDetailsScreenSP(
                                providerid: userData['providerid'],
                                userid: userData['UserID'],
                                phone: userData['PhoneNo'],
                                CustomerName: userData['Name'],
                                ProviderName: userData['providername'],
                                ServiceName: userData['ServiceName'],
                                img: userData['Imgpath'],
                                Time: userData['Time'],
                                Date: userData['Date'],
                                Address: userData['Address'],
                                Expert: userData['Expert'],
                                OrderID: userData['OrderID'],
                                Price: userData['Price'],
                                requestSubmit: userData['RequestSubmit'],
                                requestAccept: userData['RequestAccept'],
                                workInProgress: userData['Workinprog'],
                                workdone: userData['workdone'],
                                requestacceptdate:
                                    userData['RequestAcceptedDate'],
                                requestaccepttime:
                                    userData['RequestAcceptedTime'],
                                bookingstatus: userData['bookingstatus'],
                                requestsubmitdate:
                                    userData['requestsubmitdate'],
                                requestsubmittime:
                                    userData['requestsubmittime'],
                                workdonedate: userData['workdonedate'],
                                workdonetime: userData['workdonetime'],
                                requestcancel: userData['Requestcancel'],
                                workinprogdate: userData['workprogressdate'],
                                workinprogtime: userData['workprogresstime'],
                                requestcanceldate:
                                    userData['requestcanceldate'],
                                requestcanceltime:
                                    userData['requestcanceltime'],
                              ),
                            ));
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
                              offset: Offset(0, 9),
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
                                // const SizedBox(width: 10),
                                Expanded(
                                  flex: 2,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: imgPath != null
                                        ? AssetImage(imgPath)
                                        : const AssetImage(
                                            'assets/images/friend.jpg'),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 6,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Booking ID: ${userData['OrderID']}",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      //ss
                                      Row(
                                        children: [
                                          Text(
                                            "Schedule:",
                                            style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 12),
                                          Text(
                                            userData['Date'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(width: 3),
                                          Text(
                                            userData['Time'],
                                            style: TextStyle(
                                              fontSize: 12,
                                              // fontWeight: FontWeight.bold
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                // const SizedBox(width: 100),
                                Expanded(
                                  flex: 2,
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 125, 60, 255),
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
                          "There is no Completed Booking",
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
      ),
    );
  }
}
