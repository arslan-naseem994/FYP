import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahulatapp/chatscreen.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/confirm.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/ui/posts/services/service.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/Bookings/pendingbookings.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';

class OrderDetailScreen extends StatefulWidget {
  final String? ProviderName;
  final String ServiceName;
  final String Price;
  final String Address;
  final String Date;
  final String Time;
  final String Expert;
  final String OrderID;
  final String img;
  final String phone;
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
  final String userid;
  final String CustomerName;
  final String providerid;

  OrderDetailScreen({
    super.key,
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
    required this.userid,
    required this.phone,
    required this.CustomerName,
    required this.providerid,
  });

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final dataBaseRef = FirebaseDatabase.instance.ref('ConfirmTable');
  final uids = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef2 = FirebaseDatabase.instance.ref('CancelTable');
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final ref2 = FirebaseDatabase.instance.ref('AllNotification');
  final ref5 = FirebaseDatabase.instance.ref('OrderTable');
  final orderHistoryref = FirebaseDatabase.instance.ref('OrderHistory');
  Timer? timer;

  String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  void dispose() {
    dataBaseRef.onValue.drain();
    dataBaseRef2.onValue.drain();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
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
                  SizedBox(
                    width: 150,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                    providerid: widget.providerid,
                                    userid: widget.userid,
                                    role: 'provider',
                                  )));
                    },
                    child: Icon(
                      Icons.chat,
                      color: Color(0xff9749ff),
                      size: 35,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 35, top: 50, bottom: 30, right: 25),
                child: Column(
                  // 1st column
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Booking",
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
                            Expanded(flex: 4, child: Text(widget.ServiceName)),
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
                      "Client details",
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
                            Expanded(flex: 4, child: Text(widget.CustomerName)),
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
                            Expanded(flex: 4, child: Text(widget.phone)),
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
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff9749ff),
                                  elevation: 12,
                                  minimumSize: Size(200, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.grey.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title: Text("Confirmation"),
                                      content: Text(
                                          "Do you really want to confirm this booking?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff9749ff),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            timer = Timer.periodic(
                                              Duration(seconds: 2),
                                              (timer) {
                                                final snackBar = SnackBar(
                                                  content:
                                                      Text('Booking Confirmed'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                timer.cancel();
                                              },
                                            );
                                            String currentDate =
                                                getCurrentDate();
                                            String orderID = widget.OrderID;
                                            dataBaseRef.child(orderID).set({
                                              'Address':
                                                  widget.Address.toString(),
                                              'OrderID': orderID.toString(),
                                              'UserID':
                                                  widget.userid.toString(),
                                              'Image': widget.img.toString(),
                                              'Price': widget.Price.toString(),
                                              'providerid':
                                                  widget.providerid.toString(),
                                              'Date': currentDate,
                                            }).then((value) {
                                              Utils().toastMessage(
                                                  'Booking Confirmed');
                                            }).onError((error, stackTrace) {
                                              Utils().toastMessage(
                                                  error.toString());
                                            });

                                            /////// all notification on confirmed

                                            ref2.child(orderID).set({
                                              'notificationid':
                                                  orderID.toString(),
                                              'notificationname':
                                                  widget.ServiceName,
                                              'subject':
                                                  widget.Address.toString(),
                                              'notificationtype':
                                                  'Order Confirmed',
                                              'userid':
                                                  widget.userid.toString(),
                                              'image': widget.img.toString(),
                                              'price': widget.Price.toString(),
                                              'providerid':
                                                  widget.providerid.toString(),
                                              'time': selectedTime
                                                  .format(context)
                                                  .toString(),
                                              'date': currentDate,
                                              'messageseen': '1',
                                              'type': 'order'
                                            }).then((value) {
                                              Utils().toastMessage('');
                                            }).onError((error, stackTrace) {
                                              Utils().toastMessage(
                                                  error.toString());
                                            });
                                            /////// all orders update on confirm button

                                            ref.child(orderID).update({
                                              'RequestAccept': '1',
                                              'RequestAcceptedDate':
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate)
                                                      .toString(),
                                              'RequestAcceptedTime':
                                                  selectedTime
                                                      .format(context)
                                                      .toString(),
                                              'bookingstatus': 'Confirmed'
                                            });
                                            /////// order history update on confirm button
                                            orderHistoryref
                                                .child(widget.userid)
                                                .child(orderID)
                                                .update({
                                              'RequestAccept': '1',
                                              'RequestAcceptedDate':
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate)
                                                      .toString(),
                                              'RequestAcceptedTime':
                                                  selectedTime
                                                      .format(context)
                                                      .toString(),
                                              'bookingstatus': 'Confirmed'
                                            });

                                            // arslan made changes made comment it
                                            // ref.child(orderID).remove();
                                            ref5
                                                .child(widget.userid)
                                                .child(orderID)
                                                .remove();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreens(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Confirm Booking',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(width: 10),
                            //canceled booking button
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  elevation: 10,
                                  minimumSize: Size(60, 40),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20))),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.grey.shade100,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      title: Text("Confirmation"),
                                      content: Text(
                                          "Do you really want to cancel this booking?"),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                                color: Color(0xff9749ff),
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            timer = Timer.periodic(
                                              Duration(seconds: 2),
                                              (timer) {
                                                final snackBar = SnackBar(
                                                  content:
                                                      Text('Booking Canceled'),
                                                  duration:
                                                      Duration(seconds: 3),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                                timer.cancel();
                                              },
                                            );
                                            String currentDate =
                                                getCurrentDate();
                                            String orderID = widget.OrderID;
                                            dataBaseRef2.child(orderID).set({
                                              'Address':
                                                  widget.Address.toString(),
                                              'OrderID': orderID.toString(),
                                              'UserID':
                                                  widget.userid.toString(),
                                              'Image': widget.img.toString(),
                                              'Price': widget.Price.toString(),
                                              'providerid':
                                                  widget.providerid.toString(),
                                              'Date': currentDate,
                                            }).then((value) {
                                              Utils().toastMessage(
                                                  'Booking Canceled');
                                            }).onError((error, stackTrace) {
                                              Utils().toastMessage(
                                                  error.toString());
                                            });

                                            /////// all notification on canceled
                                            ref2.child(orderID).set({
                                              'notificationid':
                                                  orderID.toString(),
                                              'notificationname':
                                                  widget.ServiceName,
                                              'subject':
                                                  widget.Address.toString(),
                                              'notificationtype':
                                                  'Order Canceled',
                                              'userid':
                                                  widget.userid.toString(),
                                              'image': widget.img.toString(),
                                              'price': widget.Price.toString(),
                                              'providerid':
                                                  widget.providerid.toString(),
                                              'date': currentDate,
                                              'time': selectedTime
                                                  .format(context)
                                                  .toString(),
                                              'messageseen': '1',
                                              'type': 'order'
                                            }).then((value) {
                                              Utils().toastMessage(
                                                  'Booking Canceled');
                                            }).onError((error, stackTrace) {
                                              Utils().toastMessage(
                                                  error.toString());
                                            });

                                            // all order booking canceld refrence updatee on cancel button
                                            ref.child(orderID).update({
                                              'Requestcancel': '2',
                                              'requestcanceldate':
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate)
                                                      .toString(),
                                              'requestcanceltime': selectedTime
                                                  .format(context)
                                                  .toString(),
                                              'bookingstatus': 'Canceled'
                                            });
                                            // order history update on cancel button
                                            orderHistoryref
                                                .child(widget.userid)
                                                .child(orderID)
                                                .update({
                                              'Requestcancel': '2',
                                              'requestcanceldate':
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate)
                                                      .toString(),
                                              'requestcanceltime': selectedTime
                                                  .format(context)
                                                  .toString(),
                                              'bookingstatus': 'Canceled'
                                            });
                                            // order history update on cancel button
                                            ref5.child(orderID).update({
                                              'Requestcancel': '2',
                                              'requestcanceldate':
                                                  DateFormat('yyyy-MM-dd')
                                                      .format(selectedDate)
                                                      .toString(),
                                              'requestcanceltime': selectedTime
                                                  .format(context)
                                                  .toString(),
                                              'bookingstatus': 'Canceled'
                                            });

                                            //arslan made this comment for testing
                                            // ref.child(orderID).remove();
                                            ref5
                                                .child(widget.userid)
                                                .child(orderID)
                                                .remove();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    HomeScreens(),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                'Cancel',
                                style: TextStyle(color: Colors.black),
                              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
