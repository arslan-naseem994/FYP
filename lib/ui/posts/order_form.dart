import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/selectProvider/select.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class ServiceOne extends StatefulWidget {
  final String name;
  final String imgpath;
  final String prices;
  final String expert;

  const ServiceOne(
      {super.key,
      required this.name,
      required this.imgpath,
      required this.prices,
      required this.expert});

  @override
  State<ServiceOne> createState() => _ServiceOneState();
}

class _ServiceOneState extends State<ServiceOne> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime currentdate = DateTime.now();
  TimeOfDay currentTime = TimeOfDay.now();
  final auth = FirebaseAuth.instance;
  final ids = FirebaseAuth.instance.currentUser!.uid;

  final dataBaseRef = FirebaseDatabase.instance.ref('OrderTable');
  final orderhistorref = FirebaseDatabase.instance.ref('OrderHistory');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('AllOrders');
  final dateController = TextEditingController();
  final timerController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final providerids = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final username = TextEditingController();
  final useraddresss = TextEditingController();
  final userphoneno = TextEditingController();
  String providerid = '';
  String providerName = '1';
  String price = '';
  String ratingss = '';
  String providercontactnumber = '';

  late DateTime logicDate = selectedDate;
  late TimeOfDay logictime = selectedTime;

  final databaseReference = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);

  @override
  void initState() {
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final value = event.snapshot.value as Map<dynamic, dynamic>;
        final name = value['Name'] as String;
        final address = value['Address'] as String;
        final phone = value['Phone'] as String;

        username.text = name;
        useraddresss.text = address;
        userphoneno.text = phone;
      }
    });
    super.initState();
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
          content: Text("Booking date not selected yet"),
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
                                  providerids.text = userData['Name'];
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
                        logicDate != selectedDate
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
                        logictime != selectedTime
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
                          if (logicDate != selectedDate)
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
                          if (logictime != selectedTime)
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
                            } else if (logicDate == selectedDate) {
                              _showSnackbar(2);
                            } else if (logictime == selectedTime) {
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
                          child: const Text("Book Now")),
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

  void showConfirmationScreen(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 42,
                    width: 160,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 88, 252, 222),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
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
                                Expanded(
                                    flex: 5, child: Text(userphoneno.text)),
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
                            Row(
                              children: [
                                const Expanded(
                                    flex: 3,
                                    child: Text(
                                      "Contact",
                                      style: TextStyle(fontSize: 13),
                                    )),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Expanded(flex: 2, child: Text(":")),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      "0$providercontactnumber",
                                      style: const TextStyle(fontSize: 13),
                                    )),
                              ],
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
                                  // ******* order table
                                  String orderID = DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString();
                                  dataBaseRef.child(ids).child(orderID).set({
                                    'PhoneNo': userphoneno.text.toString(),
                                    'Date': DateFormat('yyyy-MM-dd')
                                        .format(selectedDate)
                                        .toString(),
                                    'Time':
                                        selectedTime.format(context).toString(),
                                    'Name': username.text.toString(),
                                    'Address': useraddresss.text.toString(),
                                    'ServiceName': widget.name.toString(),
                                    'Imgpath': widget.imgpath.toString(),
                                    'Price': price.toString(),
                                    'OrderID': orderID.toString(),
                                    'providerid': providerid.toString(),
                                    'providername': providerName.toString(),
                                    'UserID':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'Expert':
                                        widget.expert.toString().toString(),
                                    'RequestSubmit': '1',
                                    'RequestAccept': '0',
                                    'workdone': '0',
                                    'Workinprog': '0',
                                    'bookingstatus': 'Pending',
                                    'RequestAcceptedDate': '',
                                    'RequestAcceptedTime': '',
                                    'workprogresstime': '',
                                    'workprogressdate': '',
                                    'workdonetime': '',
                                    'workdonedate': '',
                                    'Requestcancel': '0',
                                    'requestcanceldate': '',
                                    'requestcanceltime': '',
                                    'requestsubmitdate':
                                        DateFormat('yyyy-MM-dd')
                                            .format(currentdate)
                                            .toString(),
                                    'rating': ratingss.toString(),
                                    'requestsubmittime':
                                        currentTime.format(context).toString(),
                                  }).then((value) {
                                    // Utils().toastMessage('Order Placed');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });

                                  orderhistorref
                                      .child(ids)
                                      .child(orderID)
                                      .update({
                                    'Date': DateFormat('yyyy-MM-dd')
                                        .format(selectedDate)
                                        .toString(),
                                    'Time':
                                        selectedTime.format(context).toString(),
                                    'Name': username.text.toString(),
                                    'Address': useraddresss.text.toString(),
                                    'ServiceName': widget.name.toString(),
                                    'Imgpath': widget.imgpath.toString(),
                                    'Price': price.toString(),
                                    'OrderID': orderID.toString(),
                                    'providerid': providerid.toString(),
                                    'providername': providerName.toString(),
                                    'UserID':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'Expert':
                                        widget.expert.toString().toString(),
                                    'RequestSubmit': '1',
                                    'RequestAccept': '0',
                                    'workdone': '0',
                                    'Workinprog': '0',
                                    'bookingstatus': 'Pending',
                                    'RequestAcceptedDate': '',
                                    'RequestAcceptedTime': '',
                                    'workprogresstime': '',
                                    'workprogressdate': '',
                                    'workdonetime': '',
                                    'workdonedate': '',
                                    'Requestcancel': '0',
                                    'requestcanceldate': '',
                                    'requestcanceltime': '',
                                    'requestsubmitdate':
                                        DateFormat('yyyy-MM-dd')
                                            .format(currentdate)
                                            .toString(),
                                    'requestsubmittime':
                                        currentTime.format(context).toString(),
                                    'PhoneNo': userphoneno.text.toString(),
                                    'rating': ratingss.toString(),
                                  }).then((value) {
                                    // Utils().toastMessage('Order Placed');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });
                                  // *********
                                  // *******all orders

                                  dataBaseRef2.child(orderID).set({
                                    'PhoneNo': userphoneno.text.toString(),
                                    'Date': DateFormat('yyyy-MM-dd')
                                        .format(selectedDate)
                                        .toString(),
                                    'Time':
                                        selectedTime.format(context).toString(),
                                    'Name': username.text.toString(),
                                    'Address': useraddresss.text.toString(),
                                    'ServiceName': widget.name.toString(),
                                    'Imgpath': widget.imgpath.toString(),
                                    'Price': price..toString(),
                                    'OrderID': orderID.toString(),
                                    'providerid': providerid.toString(),
                                    'providername': providerName.toString(),
                                    'UserID':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'Expert':
                                        widget.expert.toString().toString(),
                                    'RequestSubmit': '1',
                                    'RequestAccept': '0',
                                    'workdone': '0',
                                    'Workinprog': '0',
                                    'bookingstatus': 'Pending',
                                    'RequestAcceptedDate': '',
                                    'RequestAcceptedTime': '',
                                    'workprogresstime': '',
                                    'workprogressdate': '',
                                    'workdonetime': '',
                                    'workdonedate': '',
                                    'Requestcancel': '0',
                                    'requestcanceldate': '',
                                    'requestcanceltime': '',
                                    'requestsubmitdate':
                                        DateFormat('yyyy-MM-dd')
                                            .format(currentdate)
                                            .toString(),
                                    'requestsubmittime':
                                        currentTime.format(context).toString(),
                                    'rating': ratingss.toString(),
                                  }).then((value) {
                                    // Utils().toastMessage('Booking Placed');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        title: Text("Order Placed"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Image.asset(
                                                  'assets/images/confirm.gif'),
                                              SizedBox(
                                                  height:
                                                      16), // Optional spacing
                                              Text(
                                                "Your order has been placed successfully!",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PostScreen()));
                                            },
                                            child: Text(
                                              "Okay",
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  // *********
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
          ),
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
