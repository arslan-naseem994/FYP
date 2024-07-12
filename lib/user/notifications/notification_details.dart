import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

// Color(0xff9749ff),
class NotificationDetailsScreen extends StatefulWidget {
  final String type;
  final String date;
  final String time;
  final String image;
  final String subject;
  final String name;
  final String? price;
  final String allid;
  final String? usermessagge;
  final String? notificationtype;
  final String? providerid;
  const NotificationDetailsScreen({
    super.key,
    required this.type,
    required this.date,
    required this.time,
    required this.image,
    required this.subject,
    required this.name,
    required this.price,
    required this.allid,
    required this.usermessagge,
    required this.notificationtype,
    required this.providerid,
  });

  @override
  State<NotificationDetailsScreen> createState() =>
      _NotificationDetailsScreenState();
}

class _NotificationDetailsScreenState extends State<NotificationDetailsScreen> {
  String name = '';
  String address = '';
  String date = '';
  String time = '';
  String price = '';
  String phone = '';
  String providername = '';
  String expert = '';
  String servicename = '';
  String provideremail = '';
  String providercontactnumber = '';

  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final ref2 = FirebaseDatabase.instance.ref('Provider');

  void fetchUsersWithAge() {
    ref.child(widget.allid.toString()).once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        var userData = snapshot.value as Map<dynamic, dynamic>;

        var names = userData['Name'];
        var phoness = userData['PhoneNo'];
        var addressess = userData['Address'];
        var dates = userData['Date'];
        var times = userData['Time'];
        var pricess = userData['Price'];
        var providernamess = userData['providername'];
        var experts = userData['Expert'];
        var servicesnames = userData['ServiceName'];
        name = names;
        address = addressess;
        date = dates;
        time = times;
        price = pricess;
        providername = providernamess;
        phone = phoness;
        expert = experts;
        servicename = servicesnames;
        setState(() {});
      } else {}
    });
  }

  void fetchUsersWithAge2() {
    ref2.child(widget.providerid.toString()).once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        var userData = snapshot.value as Map<dynamic, dynamic>;

        var provideremails = userData['email'];
        var providercontactnumbers = userData['Phone'];
        var providername = userData['Name'];
        provideremail = provideremails;
        providercontactnumber = providercontactnumbers;
      } else {}
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUsersWithAge();
    fetchUsersWithAge2();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'message')
      return Scaffold(
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
            "Message",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff9749ff),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 32,
                top: 30,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/serviceprovider.jpg',
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 4,
                      child: Text(
                        "${widget.name}",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Text(
                        "${widget.date} ${widget.time}",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, right: 32, top: 20, bottom: 20),
              child: Text(
                "Finished the part of UX",
                style: TextStyle(
                    color: Color(0xff9749ff),
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, right: 30, top: 10, bottom: 5),
              child: Text(
                "Your Message",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, right: 30, top: 10, bottom: 20),
              child: Text(
                "${widget.usermessagge}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, right: 30, top: 10, bottom: 5),
              child: Text(
                "Admin Replied",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 32, right: 30, top: 10, bottom: 20),
              child: Text(
                "${widget.subject}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    else {
      fetchUsersWithAge();
      fetchUsersWithAge2();
      return Scaffold(
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
            "Notification",
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
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: widget.notificationtype == 'Order Canceled'
                                  ? Color.fromARGB(255, 255, 0, 0)
                                  : Color.fromARGB(255, 13, 185, 19)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('${widget.notificationtype}'),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(200),
                              color: Color.fromARGB(255, 148, 77, 255)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${widget.date} ${widget.time}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
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
                            Expanded(flex: 4, child: Text("${widget.allid}")),
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
                            Expanded(flex: 4, child: Text("$expert")),
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
                            Expanded(flex: 4, child: Text('$servicename')),
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
                            Expanded(flex: 4, child: Text('Rs$price/hour')),
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
                            Expanded(flex: 4, child: Text("$name")),
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
                            Expanded(flex: 4, child: Text("$phone")),
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
                            Expanded(flex: 4, child: Text("$providername")),
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
                            Text("$address"),
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
                            Text("$date, $time"),
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
      );
    }
  }
}
