import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class BookingDetailsScreen extends StatefulWidget {
  final String CustomerName;
  final String? ProviderName;
  final String ServiceName;
  final String Price;
  final String Address;
  final String Date;
  final String Time;
  final String Expert;
  final String OrderID;
  final String img;
  final String requestSubmit;
  final String requestAccept;
  final String workInProgress;
  final String workdone;
  final String? requestacceptdate;
  final String? requestaccepttime;
  final String bookingstatus;
  final String requestsubmitdate;
  final String requestsubmittime;
  final String workdonedate;
  final String workdonetime;
  final String workinprogdate;
  final String workinprogtime;
  final String requestcanceldate;
  final String requestcanceltime;
  final String requestcancel;
  final String phone;
  final String providerid;
  const BookingDetailsScreen({
    super.key,
    required this.CustomerName,
    required this.ProviderName,
    required this.ServiceName,
    required this.Price,
    required this.Address,
    required this.Date,
    required this.Time,
    required this.Expert,
    required this.OrderID,
    required this.img,
    required this.requestSubmit,
    required this.requestAccept,
    required this.workInProgress,
    required this.workdone,
    required this.requestacceptdate,
    required this.requestaccepttime,
    required this.bookingstatus,
    required this.requestsubmitdate,
    required this.requestsubmittime,
    required this.workdonedate,
    required this.workdonetime,
    required this.workinprogdate,
    required this.workinprogtime,
    required this.requestcanceldate,
    required this.requestcanceltime,
    required this.requestcancel,
    required this.phone,
    required this.providerid,
  });

  @override
  State<BookingDetailsScreen> createState() => _BookingDetailsScreenState();
}

class _BookingDetailsScreenState extends State<BookingDetailsScreen> {
  final ref = FirebaseDatabase.instance.ref('OrderTable');
  final ref2 = FirebaseDatabase.instance.ref('AllOrders');
  final orderHistoryReference = FirebaseDatabase.instance.ref('OrderHistory');

  final providerreference = FirebaseDatabase.instance.ref('Provider');
  Timer? timer;

  String provideremail = '';
  String providercontactnumber = '';

  @override
  void initState() {
    super.initState();
    fetchUsersWithAge2();
  }

  void fetchUsersWithAge2() {
    providerreference
        .child(widget.providerid.toString())
        .once()
        .then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        var userData = snapshot.value as Map<dynamic, dynamic>;

        var provideremails = userData['Email'];
        var providercontactnumbers = userData['Phone'];

        provideremail = provideremails;
        providercontactnumber = providercontactnumbers;
        setState(() {});
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: GestureDetector(
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xff9749ff),
                  size: 22,
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              )),
          automaticallyImplyLeading: false,
          title: Text(
            "Booking",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff9749ff),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                width: 160,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 252, 222),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                    child: Text(
                  'Booking status',
                  style: TextStyle(
                      color: Color.fromARGB(255, 50, 0, 119),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, top: 30, bottom: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskBubble("Request Submitted", widget.requestsubmitdate,
                        widget.requestsubmittime, widget.requestSubmit),
                    if (widget.bookingstatus != 'Canceled')
                      TaskBubble(
                          "Request Accepted by ${widget.ProviderName!}",
                          widget.requestacceptdate!,
                          widget.requestaccepttime!,
                          widget.requestAccept),
                    if (widget.bookingstatus == 'Canceled')
                      TaskBubble(
                          "Request Canceld by ${widget.ProviderName!}",
                          widget.requestcanceldate,
                          widget.requestcanceltime,
                          widget.requestcancel),
                    if (widget.bookingstatus != 'Canceled')
                      TaskBubble("Work in Progress", widget.workinprogdate,
                          widget.workinprogtime, widget.workInProgress),
                    if (widget.bookingstatus != 'Canceled')
                      TaskBubble("Work Completed", widget.workdonedate,
                          widget.workdonetime, widget.workdone),
                  ],
                ),
              ),
              Container(
                height: 45,
                width: 160,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 252, 222),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: Center(
                    child: Text(
                  'Booking Details',
                  style: TextStyle(
                      color: Color.fromARGB(255, 50, 0, 119),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 35, top: 30, bottom: 30, right: 25),
                child: Column(
                  // 1st column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Booking Number")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(flex: 4, child: Text("${widget.OrderID}")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // Personal Details:
                    Text(
                      "Service details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Service type")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(flex: 4, child: Text("${widget.Expert}")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Service name")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(
                                flex: 4, child: Text('${widget.ServiceName}')),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Service price")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(
                                flex: 4, child: Text('Rs${widget.Price}/Day')),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // Provider Details
                    Text(
                      "Your details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Name")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(
                                flex: 4, child: Text("${widget.CustomerName}")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Contact number")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(flex: 4, child: Text("${widget.phone}")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    Text(
                      "Provider details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Name")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(
                                flex: 4, child: Text("${widget.ProviderName}")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Email")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(flex: 4, child: Text("$provideremail")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(flex: 4, child: Text("Contact number")),
                            SizedBox(
                              width: 35,
                            ),
                            Expanded(flex: 2, child: Text(":")),
                            Expanded(
                                flex: 4,
                                child: Text("0$providercontactnumber")),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    // details
                    Text(
                      "Booking address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("${widget.Address}"),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    //
                    Text(
                      "Booking slot",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text("${widget.Date} ${widget.Time}"),
                            SizedBox(
                              width: 35,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ], // 1st column bracket
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TaskBubble extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String isCompleted;

  TaskBubble(this.title, this.date, this.time, this.isCompleted);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted == '1'
                    ? Color.fromARGB(255, 13, 185, 19)
                    : isCompleted == '2'
                        ? Colors.red
                        : Colors.grey,
              ),
            ),
            SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: isCompleted == '1'
                        ? Color.fromARGB(255, 0, 0, 0)
                        : isCompleted == '2'
                            ? Colors.red
                            : Colors.black,
                    fontSize: 10,
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      date,
                      style: TextStyle(
                        color: isCompleted == '1'
                            ? Color.fromARGB(255, 0, 0, 0)
                            : isCompleted == '2'
                                ? Colors.red
                                : Colors.black,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(width: 3),
                    Text(
                      time,
                      style: TextStyle(
                        color: isCompleted == '1'
                            ? Color.fromARGB(255, 0, 0, 0)
                            : isCompleted == '2'
                                ? Colors.red
                                : Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
        // if (isCompleted)
        //   Container(
        //     height: 30, // Adjust this height to control the line's position
        //     width: 3,
        //     color: Color.fromARGB(255, 13, 185, 19),
        //   ),
        SizedBox(height: 6), // Add spacing below circle
      ],
    );
  }
}
