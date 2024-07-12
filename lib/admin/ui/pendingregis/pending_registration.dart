import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/pendingregis/pending_details.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/new_booking_details_servicepro.dart';

class PendingRegistrationScreen extends StatefulWidget {
  const PendingRegistrationScreen({super.key});

  @override
  State<PendingRegistrationScreen> createState() =>
      _PendingRegistrationScreenState();
}

class _PendingRegistrationScreenState extends State<PendingRegistrationScreen> {
  final ref = FirebaseDatabase.instance.ref('Provider');

  Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge() {
    //final query = ref.orderByChild('UserID').equalTo('hi');
    final query = ref.orderByChild('verified').equalTo('false');

    return query.onValue.map((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        return userList.values.toList().cast<Map<dynamic, dynamic>>();
      }

      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder(
            stream: fetchUsersWithAge(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData &&
                  snapshot.data != null &&
                  (snapshot.data as List).isNotEmpty) {
                final userList = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // "Clear All" button
                    // InkWell(
                    //   onTap: () {
                    //     final query = ref.orderByChild('UserID').equalTo('hu');
                    //     query.once().then((DatabaseEvent event) {
                    //       DataSnapshot snapshot = event.snapshot;
                    //       Map<dynamic, dynamic>? values =
                    //           snapshot.value as Map<dynamic, dynamic>?;

                    //       if (values != null) {
                    //         values.forEach((key, value) {
                    //           ref.child(key).remove();
                    //         });
                    //       }
                    //     });
                    //   },
                    //   child: Text(
                    //     'Clear All',
                    //     style: TextStyle(fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: ((context, index) {
                          final userData = userList[index];
                          final imgPath = userData['image'] as String?;
                          return GestureDetector(
                            onTap: () {
                              // Navigate to new screen with selected item's data
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PendingDetailsScreen(
                                    name: userData['Name'],
                                    email: userData['email'],
                                    phone: userData['Phone'],
                                    address: userData['Address'],
                                    id1: userData['IdCardFront'],
                                    id2: userData['IdCardBack'],
                                    code: userData['code'],
                                    userid: userData['UserID'],
                                    profilepicture: userData['image'],
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
                                    color: Colors.blueGrey,
                                    spreadRadius: 2,
                                    blurRadius: 15,
                                    offset: Offset(0, 10),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
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
                                                  ? NetworkImage(
                                                      imgPath.toString())
                                                  : const NetworkImage(
                                                      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userData['Name'],
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              //ss
                                              Text(userData['email']),
                                            ],
                                          ),
                                        ),
                                        // const SizedBox(width: 100),
                                        Expanded(
                                            flex: 2,
                                            child:
                                                Icon(Icons.arrow_forward_ios)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              } else {
                return SafeArea(
                  child: Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 20),
                          Text(
                            "There is no pending registration",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
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
