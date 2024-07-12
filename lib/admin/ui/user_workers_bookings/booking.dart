import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/booking_details.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/users_details.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int totalUsers = 0;
  String username = '';
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  String _showVerified = '1'; // Default filter option

  Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String filter) {
    final query = ref;

    return query.onValue.map((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        if (filter == '1') {
          final filteredList = userList.values.toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (filter == '2') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Pending')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (filter == '3') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Confirmed')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (filter == '4') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Completed')
              .toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (filter == '5') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Canceled')
              .toList();

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
                title: Text('All'),
                onTap: () {
                  setState(() {
                    _showVerified = '1';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Pending'),
                onTap: () {
                  setState(() {
                    _showVerified = '2';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Confirmed'),
                onTap: () {
                  setState(() {
                    _showVerified = '3';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Completed'),
                onTap: () {
                  setState(() {
                    _showVerified = '4';
                  });
                  _totalusers(_showVerified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Canceled'),
                onTap: () {
                  setState(() {
                    _showVerified = '5';
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
              .where((userData) => userData['bookingstatus'] == 'Pending')
              .toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Pending Bookings';
          });
        }
        if (filter == '3') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Confirmed')
              .toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Confirmed Bookings';
          });
        }
        if (filter == '4') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Completed')
              .toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Completed Bookings';
          });
        }
        if (filter == '5') {
          final filteredList = userList.values
              .where((userData) => userData['bookingstatus'] == 'Canceled')
              .toList();
          setState(() {
            totalUsers = filteredList.length;
            username = 'Canceled Bookings';
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
              "Bookings",
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
                    userList.sort((a, b) => b['Date'].compareTo(a['Date']));
                    return ListView.builder(
                        itemCount: userList.length,
                        itemBuilder: ((context, index) {
                          final userData = userList[index];

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookingDetailsScreen(
                                      phone: userData['PhoneNo'],
                                      providerid: userData['providerid'],
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
                                      workinprogdate:
                                          userData['workprogressdate'],
                                      workinprogtime:
                                          userData['workprogresstime'],
                                      requestcanceldate:
                                          userData['requestcanceldate'],
                                      requestcanceltime:
                                          userData['requestcanceltime'],
                                      requestcancel: userData['Requestcancel'],
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
                                                AssetImage(userData['Imgpath']),
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
                                                "Booking ID: ${userData['OrderID']}",
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Schedule:",
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight:
                                                      //     FontWeight.bold
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 12),
                                                  Text(
                                                    userData['Date'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight:
                                                      //     FontWeight.bold
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(width: 3),
                                                  Text(
                                                    userData['Time'],
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      // fontWeight:
                                                      //     FontWeight.bold
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
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
                              "There is no bookings",
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
