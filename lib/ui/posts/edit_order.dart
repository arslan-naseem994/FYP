import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';

import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/ui/posts/selectProvider/select.dart';
import 'package:sahulatapp/ui/posts/services/service.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class EditOrderScreen extends StatefulWidget {
  final String name;
  final String address;
  final String date;
  final String time;
  final String phone;
  final String orderid;
  final String userid;
  final String providerid;
  final String providername;
  final String expert;
  final String imgpath;
  final String prices;
  final String rating;

  const EditOrderScreen({
    super.key,
    required this.name,
    required this.address,
    required this.date,
    required this.time,
    required this.phone,
    required this.orderid,
    required this.userid,
    required this.providerid,
    required this.providername,
    required this.expert,
    required this.imgpath,
    required this.prices,
    required this.rating,
  });

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime currentdate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  final auth = FirebaseAuth.instance;
  final ids = FirebaseAuth.instance.currentUser!.uid;
  bool loading = false;
  final dataBaseRef = FirebaseDatabase.instance.ref('OrderTable');
  final orderHistoryRefrence = FirebaseDatabase.instance.ref('OrderHistory');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('AllOrders');
  final dateController = TextEditingController();
  final timerController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String desired = FirebaseAuth.instance.currentUser!.uid;
  final username = TextEditingController();
  final useraddresss = TextEditingController();
  final userphoneno = TextEditingController();
  String providerid = '';
  late DateTime logicDate = selectedDate;
  late TimeOfDay logictime = selectedTime;
  String providerName = '1';
  String price = '';
  String ratingss = '';

  String providercontactnumber = '';

  final databaseReference = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    price = widget.prices;
    ratingss = widget.rating;
    providerName = widget.providername;
    username.text = widget.name;
    useraddresss.text = widget.address;
    userphoneno.text = widget.phone;
    final dateFormat = DateFormat('yyyy-MM-dd');
    final timeFormat = DateFormat.Hm();
    selectedDate = dateFormat.parse(widget.date);
    logicDate = dateFormat.parse(widget.date);
    final time = timeFormat.parse(widget.time);
    selectedTime = TimeOfDay.fromDateTime(time);
    logictime = TimeOfDay.fromDateTime(time);
    providerid = widget.providerid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Color(0xff9749ff),
                size: 22,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        automaticallyImplyLeading: false,
        title: const Text(
          "Booking Form",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.7,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 45,
                width: 225,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 88, 252, 222),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Center(
                    child: Text(
                  'Pick Service Provider',
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
                    Row(
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 237, 237),
                              foregroundColor: const Color.fromARGB(255, 50, 0,
                                  119), // Change the button text color
                              textStyle: const TextStyle(
                                  fontSize: 15), // Change the button text size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Change button border radius
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => selectionScreen(
                                    expert: widget.expert.toString(),
                                  ),
                                ),
                              ).then((userData) {
                                if (userData != null) {
                                  providerid = userData['UserID'];

                                  providerName = userData['Name'];
                                  price = userData['commission'];
                                  ratingss = userData['rating'];
                                  providercontactnumber = userData['Phone'];
                                  setState(() {});
                                  // Update UI with the selected fruit data
                                }
                              });
                            },
                            child: const Text("Book Now")),
                        const SizedBox(
                          width: 6,
                        ),
                        if (providerName == '1')
                          const Text("Not Selected")
                        else
                          const Icon(
                            Icons.done,
                          )
                      ],
                    ),
                    if (providerName != '1')
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 30, top: 15, right: 25),
                        child: Column(
                          // 1st column
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 4, child: Text("Selected")),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Expanded(flex: 2, child: Text(":")),
                                    Expanded(
                                        flex: 4, child: Text(providerName)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 4, child: Text("Rating")),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Expanded(flex: 2, child: Text(":")),
                                    Expanded(flex: 4, child: Text(ratingss)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 4, child: Text("Price")),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Expanded(flex: 2, child: Text(":")),
                                    Expanded(flex: 4, child: Text("Rs$price")),
                                  ],
                                ),
                                const SizedBox(
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
              Container(
                height: 45,
                width: 225,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 88, 252, 222),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Center(
                    child: Text(
                  'Pick Date & Time',
                  style: TextStyle(
                      color: Color.fromARGB(255, 50, 0, 119),
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 35,
                  top: 30,
                  bottom: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 238, 237, 237),
                              foregroundColor: const Color.fromARGB(255, 50, 0,
                                  119), // Change the button text color
                              textStyle: const TextStyle(
                                  fontSize: 15), // Change the button text size
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // Change button border radius
                              ),
                            ),
                            onPressed: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                minTime: DateTime.now(),
                                maxTime: DateTime(DateTime.now().year,
                                        DateTime.now().month + 1, 1)
                                    .subtract(Duration(days: 1)),

                                // maxTime: DateTime(DateTime.now().year + 1,
                                //     DateTime.now().month, DateTime.now().day),
                                onConfirm: (date) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                },
                                currentTime: selectedDate,
                                locale: LocaleType.en,
                              );
                            },
                            child: const Text("Date")),
                        const SizedBox(
                          width: 4,
                        ),
                        selectedDate != null
                            ? const Icon(Icons.done)
                            : const Text(""),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 238, 237, 237),
                            foregroundColor:
                                const Color.fromARGB(255, 50, 0, 119),
                            textStyle: const TextStyle(fontSize: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            DatePicker.showTime12hPicker(
                              context,
                              showTitleActions: true,
                              onConfirm: (time) {
                                if (time.hour >= 8 && time.hour < 20) {
                                  setState(() {
                                    final selectedDateTime = DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    debugPrint("Timess:: $selectedDateTime");
                                    selectedTime = TimeOfDay.fromDateTime(
                                        selectedDateTime);
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Please select a time between 8 AM and 8 PM.'),
                                    ),
                                  );
                                }
                              },
                              currentTime: selectedTime != null
                                  ? DateTime(
                                      selectedDate.year,
                                      selectedDate.month,
                                      selectedDate.day,
                                      selectedTime.hour,
                                      selectedTime.minute,
                                    )
                                  : DateTime.now(),
                              locale: LocaleType.en,
                            );
                          },
                          child: const Text("Time"),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        selectedTime != null
                            ? const Icon(Icons.done)
                            : const Text(""),
                      ],
                    ),
                    //////////////////////
                    // if (logicDate != selectedDate && logictime != selectedTime)
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 30, top: 15, right: 25),
                      child: Column(
                        // 1st column
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (selectedDate != null)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 4, child: Text("Selected Date")),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Expanded(flex: 2, child: Text(":")),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                            "${DateFormat('yyyy-MM-dd').format(selectedDate)}")),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          if (selectedTime != null)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    const Expanded(
                                        flex: 4, child: Text("Selected time")),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Expanded(flex: 2, child: Text(":")),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                            "${selectedTime.format(context)}")),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                        ], // 1st column bracket
                      ),
                    )

                    /////////////////////
                  ],
                ),
              ),
              Container(
                height: 45,
                width: 160,
                decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 88, 252, 222),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Center(
                    child: Text(
                  'Personal Details',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Name",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff9749ff),
                                    spreadRadius: 0,
                                    blurRadius: 3,
                                    // offset: Offset(0, 10), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white),
                            width: 360,
                            height: 59,
                            child: TextFormField(
                              controller: username,
                              maxLength: 30,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                // labelText: "Name",
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                                counterText: '',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Name';
                                }
                                return null;
                              },
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Booking Address",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff9749ff),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  // offset: Offset(0, 10), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          width: 360,
                          height: 59,
                          child: TextFormField(
                              maxLength: 40,
                              controller: useraddresss,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '123 Main St, Sahiwal',
                                // label: Text("Address",
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 25)),
                                counterText: '',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Address';
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      "Contact Number",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xff9749ff),
                                  spreadRadius: 0,
                                  blurRadius: 3,
                                  // offset: Offset(0, 10), // changes position of shadow
                                ),
                              ],
                              color: Colors.white),
                          width: 360,
                          height: 59,
                          child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')), // Only allow digits
                                LengthLimitingTextInputFormatter(
                                    11), // Limit input length to 11 characters
                              ],
                              controller: userphoneno,
                              maxLength: 11,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: '####',
                                // label: Text("Phone Number",
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 25)
                                //         )
                                counterText: '',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Enter Phone Number';
                                }
                                return null;
                              }),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff9749ff),
                              elevation: 12,
                              minimumSize: const Size(200, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            if (providerName == '1') {
                              _showSnackbar(1);
                            } else if (logicDate != selectedDate) {
                              _showSnackbar(2);
                            } else if (logictime != selectedTime) {
                              _showSnackbar(3);
                            } else {
                              if (_formkey.currentState!.validate()) {
                                // *******
                                // ******* order table
                                // String orderID = DateTime.now()
                                //     .millisecondsSinceEpoch
                                //     .toString();
                                // dataBaseRef.child(ids).child(orderID).set({
                                //   'PhoneNo': userphoneno.text.toString(),
                                //   'Date': DateFormat('yyyy-MM-dd')
                                //       .format(selectedDate)
                                //       .toString(),
                                //   'Time':
                                //       selectedTime.format(context).toString(),
                                //   'Name': username.text.toString(),
                                //   'Address': useraddresss.text.toString(),
                                //   'ServiceName': widget.name.toString(),
                                //   'Imgpath': widget.imgpath.toString(),
                                //   'Price': price.toString(),
                                //   'OrderID': orderID.toString(),
                                //   'providerid': providerid.toString(),
                                //   'providername': providerName.toString(),
                                //   'UserID':
                                //       FirebaseAuth.instance.currentUser!.uid,
                                //   'Expert': widget.expert.toString().toString(),
                                //   'RequestSubmit': '1',
                                //   'RequestAccept': '0',
                                //   'workdone': '0',
                                //   'Workinprog': '0',
                                //   'bookingstatus': 'Pending',
                                //   'RequestAcceptedDate': '',
                                //   'RequestAcceptedTime': '',
                                //   'workprogresstime': '',
                                //   'workprogressdate': '',
                                //   'workdonetime': '',
                                //   'workdonedate': '',
                                //   'Requestcancel': '0',
                                //   'requestcanceldate': '',
                                //   'requestcanceltime': '',
                                //   'requestsubmitdate': DateFormat('yyyy-MM-dd')
                                //       .format(currentdate)
                                //       .toString(),
                                //   'requestsubmittime':
                                //       currentTime.format(context).toString(),
                                // }).then((value) {
                                //   // Utils().toastMessage('Order Placed');
                                // }).onError((error, stackTrace) {
                                //   Utils().toastMessage(error.toString());
                                // });

                                // orderhistorref
                                //     .child(ids)
                                //     .child(orderID)
                                //     .update({
                                //   'Date': DateFormat('yyyy-MM-dd')
                                //       .format(selectedDate)
                                //       .toString(),
                                //   'Time':
                                //       selectedTime.format(context).toString(),
                                //   'Name': username.text.toString(),
                                //   'Address': useraddresss.text.toString(),
                                //   'ServiceName': widget.name.toString(),
                                //   'Imgpath': widget.imgpath.toString(),
                                //   'Price': price.toString(),
                                //   'OrderID': orderID.toString(),
                                //   'providerid': providerid.toString(),
                                //   'providername': providerName.toString(),
                                //   'UserID':
                                //       FirebaseAuth.instance.currentUser!.uid,
                                //   'Expert': widget.expert.toString().toString(),
                                //   'RequestSubmit': '1',
                                //   'RequestAccept': '0',
                                //   'workdone': '0',
                                //   'Workinprog': '0',
                                //   'bookingstatus': 'Pending',
                                //   'RequestAcceptedDate': '',
                                //   'RequestAcceptedTime': '',
                                //   'workprogresstime': '',
                                //   'workprogressdate': '',
                                //   'workdonetime': '',
                                //   'workdonedate': '',
                                //   'Requestcancel': '0',
                                //   'requestcanceldate': '',
                                //   'requestcanceltime': '',
                                //   'requestsubmitdate': DateFormat('yyyy-MM-dd')
                                //       .format(currentdate)
                                //       .toString(),
                                //   'requestsubmittime':
                                //       currentTime.format(context).toString(),
                                //   'PhoneNo': userphoneno.text.toString(),
                                // }).then((value) {
                                //   // Utils().toastMessage('Order Placed');
                                // }).onError((error, stackTrace) {
                                //   Utils().toastMessage(error.toString());
                                // });
                                // *********
                                // *******all orders

                                // dataBaseRef2.child(orderID).set({
                                //   'PhoneNo': userphoneno.text.toString(),
                                //   'Date': DateFormat('yyyy-MM-dd')
                                //       .format(selectedDate)
                                //       .toString(),
                                //   'Time':
                                //       selectedTime.format(context).toString(),
                                //   'Name': username.text.toString(),
                                //   'Address': useraddresss.text.toString(),
                                //   'ServiceName': widget.name.toString(),
                                //   'Imgpath': widget.imgpath.toString(),
                                //   'Price': price..toString(),
                                //   'OrderID': orderID.toString(),
                                //   'providerid': providerid.toString(),
                                //   'providername': providerName.toString(),
                                //   'UserID':
                                //       FirebaseAuth.instance.currentUser!.uid,
                                //   'Expert': widget.expert.toString().toString(),
                                //   'RequestSubmit': '1',
                                //   'RequestAccept': '0',
                                //   'workdone': '0',
                                //   'Workinprog': '0',
                                //   'bookingstatus': 'Pending',
                                //   'RequestAcceptedDate': '',
                                //   'RequestAcceptedTime': '',
                                //   'workprogresstime': '',
                                //   'workprogressdate': '',
                                //   'workdonetime': '',
                                //   'workdonedate': '',
                                //   'Requestcancel': '0',
                                //   'requestcanceldate': '',
                                //   'requestcanceltime': '',
                                //   'requestsubmitdate': DateFormat('yyyy-MM-dd')
                                //       .format(currentdate)
                                //       .toString(),
                                //   'requestsubmittime':
                                //       currentTime.format(context).toString(),
                                // }).then((value) {
                                //   // Utils().toastMessage('Order Placed');
                                // }).onError((error, stackTrace) {
                                //   Utils().toastMessage(error.toString());
                                // });

                                showConfirmationScreen(context, 'Order Placed');

                                // *********
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const ConfirmationScreen()));
                              }
                            }
                          },
                          child: const Text("Update Booking")),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackbar(int a) {
    if (a == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Service provider not selected"),
        ),
      );
    }
    if (a == 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking date not selected"),
        ),
      );
    }
    if (a == 3) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Booking time not selected yet"),
        ),
      );
    }
  }

  void showConfirmationScreen(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 160,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 88, 252, 222),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: const Center(
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
                      left: 35, top: 15, bottom: 30, right: 25),
                  child: Column(
                    // 1st column
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Your details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(fontSize: 13),
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    username.text,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(flex: 3, child: Text("Contact")),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(flex: 5, child: Text(userphoneno.text)),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      // Personal Details:
                      const Text(
                        "Service details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                  flex: 3,
                                  child: Text("Type",
                                      style: TextStyle(fontSize: 13))),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    widget.expert,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(fontSize: 13),
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    widget.name,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Price",
                                    style: TextStyle(fontSize: 13),
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    "Rs${widget.prices}",
                                    style: const TextStyle(fontSize: 13),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      // Provider Details
                      const Text(
                        "Provider details",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Name",
                                    style: TextStyle(fontSize: 13),
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    providerName,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Expanded(
                                  flex: 3,
                                  child: Text(
                                    "Rating",
                                    style: TextStyle(fontSize: 13),
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              const Expanded(flex: 2, child: Text(":")),
                              Expanded(
                                  flex: 5,
                                  child: Text(
                                    ratingss,
                                    style: const TextStyle(fontSize: 13),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      // details
                      const Text(
                        "Booking address",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  useraddresss.text,
                                  style: const TextStyle(fontSize: 13),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      //
                      const Text(
                        "Booking slot",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                "${DateFormat('yyyy-MM-dd').format(selectedDate)} ${selectedTime.format(context)}",
                                style: const TextStyle(fontSize: 13),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 238, 237, 237),
                                foregroundColor: const Color.fromARGB(255, 50,
                                    0, 119), // Change the button text color
                                textStyle: const TextStyle(
                                    fontSize:
                                        15), // Change the button text size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), // Change button border radius
                                ),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel")),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff9749ff),
                                // Change the button text color
                                textStyle: const TextStyle(
                                    fontSize:
                                        15), // Change the button text size
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      20), // Change button border radius
                                ),
                              ),
                              onPressed: () {
                                // *******

                                dataBaseRef
                                    .child(widget.userid)
                                    .child(widget.orderid)
                                    .update({
                                  'Date': DateFormat('yyyy-MM-dd')
                                      .format(selectedDate)
                                      .toString(),
                                  'Time':
                                      selectedTime.format(context).toString(),
                                  'Name': username.text.toString(),
                                  'Address': useraddresss.text.toString(),
                                  'PhoneNo': userphoneno.text.toString(),
                                  'providerid': providerid.toString(),
                                  'providername': providerName.toString(),
                                }).then((value) {
                                  // Utils().toastMessage('Order Placed');
                                  setState(() {
                                    loading = false;
                                  });
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                  setState(() {
                                    loading = false;
                                  });
                                });
                                // *********
                                // *******

                                dataBaseRef2.child(widget.orderid).update({
                                  'Date': DateFormat('yyyy-MM-dd')
                                      .format(selectedDate)
                                      .toString(),
                                  'Time':
                                      selectedTime.format(context).toString(),
                                  'Name': username.text.toString(),
                                  'Address': useraddresss.text.toString(),
                                  'PhoneNo': userphoneno.text.toString(),
                                  'providerid': providerid.toString(),
                                  'providername': providerName.toString(),
                                }).then((value) {
                                  // Utils().toastMessage('Order Placed');
                                  setState(() {
                                    loading = false;
                                  });
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                  setState(() {
                                    loading = false;
                                  });
                                });

                                orderHistoryRefrence
                                    .child(desired)
                                    .child(widget.orderid)
                                    .update({
                                  'Date': DateFormat('yyyy-MM-dd')
                                      .format(selectedDate)
                                      .toString(),
                                  'Time':
                                      selectedTime.format(context).toString(),
                                  'Name': username.text.toString(),
                                  'Address': useraddresss.text.toString(),
                                  'PhoneNo': userphoneno.text.toString(),
                                  'providerid': providerid.toString(),
                                  'providername': providerName.toString(),
                                }).then((value) {
                                  Utils().toastMessage('Booking Updated');
                                  setState(() {
                                    loading = false;
                                  });
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(error.toString());
                                  setState(() {
                                    loading = false;
                                  });
                                });

                                // showConfirmationScreen(
                                //     context, 'Order Updated');

                                // *********
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostScreen()));
                              },
                              child: const Text("Confirm")),
                        ],
                      )
                    ], // 1st column bracket
                  ),
                )
              ],
            ),
          ],
        );
      },
    );

    // Future.delayed(Duration(seconds: 2), () {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) =>
    //               PostScreen())); // Close the confirmation screen
    // }
    // );
  }
}
