import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/users_details.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/workers_details.dart';

class WorkersScreen extends StatefulWidget {
  const WorkersScreen({super.key});

  @override
  State<WorkersScreen> createState() => _WorkersScreenState();
}

class _WorkersScreenState extends State<WorkersScreen> {
  final ref = FirebaseDatabase.instance.ref('Provider');
  int totalUsers = 0;
  String username = '';
  String _showVerified = '1'; // Default filter option

  Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String filter) {
    final query = ref;

    return query.onValue.map((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        if (filter == '2') {
          final filteredList = userList.values
              .where((userData) => userData['verified'] == 'true')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (filter == '3') {
          final filteredList = userList.values
              .where((userData) => userData['verified'] == 'false')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (filter == '1') {
          final filteredList = userList.values.toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
      }

      return [];
    });
  }

  void _showFilterOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Show All'),
                onTap: () {
                  setState(() {
                    _showVerified = '1';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Show Verified'),
                onTap: () {
                  setState(() {
                    _showVerified = '2';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Show Not Verified'),
                onTap: () {
                  setState(() {
                    _showVerified = '3';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _totalusers(String filter) {
    ref.onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'
        if (filter == '1') {
          final filteredList = userList.values.toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Total';
          });
        }
        if (filter == '2') {
          final filteredList = userList.values
              .where((userData) => userData['verified'] == 'true')
              .toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Verified Wokers';
          });
        }
        if (filter == '3') {
          final filteredList = userList.values
              .where((userData) => userData['verified'] == 'false')
              .toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Not Verified Workers';
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _totalusers('1');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0xff9749ff),
            onPressed: _showFilterOptions,
            child: Icon(Icons.filter_list),
          ),
          appBar: AppBar(
            actions: [
              Center(
                child: Text(
                  "${username} : ${totalUsers}",
                  style: TextStyle(
                    color: Color(0xff9749ff),
                  ),
                ),
              )
            ],
            leading: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff9749ff),
                size: 22,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Workers",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff9749ff),
              ),
            ),
            elevation: 1,
            automaticallyImplyLeading: false,
            shadowColor: Colors.white,
            bottomOpacity: 10,
            backgroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Expanded(
                  child: StreamBuilder(
                stream: fetchUsersWithAge(_showVerified),
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
                                    builder: (context) => WorkersDetailsScreen(
                                      name: userData['Name'],
                                      address: userData['Address'],
                                      email: userData['email'],
                                      image: userData['image'],
                                      phone: userData['Phone'],
                                      cnic: userData['CNIC'],
                                      expertise: userData['Expertise'],
                                      idcardback: userData['IdCardBack'],
                                      idcardfront: userData['IdCardFront'],
                                      isverified: userData['verified'],
                                      providerid: userData['UserID'],
                                    ),
                                  ));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 4),
                                width: 50,
                                height: 80,
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color(0xff9749ff),
                                        spreadRadius: 0,
                                        blurRadius: 2,
                                        // offset: Offset(0, 10), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: CircleAvatar(
                                            radius: 35,
                                            backgroundImage:
                                                NetworkImage(userData['image']),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Expanded(
                                          flex: 6,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                userData['Name'],
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                userData['email'],
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                          // ListTile(
                          //   title: Text(userData['Date']),
                          //   subtitle: Text(userData['Time']),
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
                              "There is no worker",
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
