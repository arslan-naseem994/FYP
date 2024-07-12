import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahulatapp/utils/utils.dart';

class BookingDetailsScreenSP extends StatefulWidget {
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

  const BookingDetailsScreenSP({
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
  State<BookingDetailsScreenSP> createState() => _BookingDetailsScreenSPState();
}

class _BookingDetailsScreenSPState extends State<BookingDetailsScreenSP> {
  String provideremail = '';
  String providercontactnumber = '';
  String updatestatus = '';
  final providerreference = FirebaseDatabase.instance.ref('Provider');
  String isSWITCHES = '0';
  late String isinprog;
  late String isincomp;
  @override
  void initState() {
    super.initState();
    donebutton = widget.workdone;
    inprogbutton = widget.workInProgress;
    fetchUsersWithAge2();
    isinprog = widget.workInProgress;
    isincomp = widget.workdone;
  }

  void _updatedata(String newMessage) {
    setState(() {
      isinprog = newMessage;
    });
  }

  void _updatedata2(String newMessage) {
    setState(() {
      isincomp = newMessage;
    });
  }

  String donebutton = '12';
  String inprogbutton = "12";

  // void inprogfun() {
  //   setState(() {
  //     inprogbutton = !inprogbutton;
  //   });
  //   debugPrint(inprogbutton.toString());
  // }

  // void donefun() {
  //   setState(() {
  //     donebutton = !donebutton;
  //   });
  //   debugPrint(donebutton.toString());
  // }

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
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (widget.bookingstatus == 'Completed' ||
                      widget.bookingstatus == 'In progress')
                    Text(
                      "Update status",
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  if (widget.bookingstatus == 'Completed' ||
                      widget.bookingstatus == 'In progress')
                    Row(
                      children: [
                        Transform.scale(
                            scale: 1,
                            child: Switch(
                              onChanged: toggleSwitchs,
                              value: isSWITCHES == '1',
                              activeColor: Colors.green,
                              activeTrackColor:
                                  Color.fromARGB(255, 189, 139, 255),
                              inactiveThumbColor:
                                  Color.fromARGB(255, 76, 76, 76),
                              inactiveTrackColor:
                                  Color.fromARGB(255, 189, 139, 255),
                            )),
                      ],
                    ),
                ],
              )),
            )
          ],
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
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Booking",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff9749ff),
              ),
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
                          widget.workinprogtime, isinprog),
                    if (widget.bookingstatus != 'Canceled')
                      TaskBubble("Work Completed", widget.workdonedate,
                          widget.workdonetime, isincomp),
                  ],
                ),
              ),
              // widget.review == '0'
              if (widget.bookingstatus == 'Confirmed' || isSWITCHES == '1')
                Container(
                    height: 45,
                    width: 160,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 88, 252, 222),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Update Status ',
                            style: TextStyle(
                                color: Color.fromARGB(255, 50, 0, 119),
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                            // textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )),

              if (widget.bookingstatus == 'Confirmed' || isSWITCHES == '1')
                Padding(
                  padding: const EdgeInsets.only(left: 35, top: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SwitchScreen(widget.userid, widget.workInProgress,
                          widget.OrderID, _updatedata),
                      SizedBox(width: 2),
                      SwitchScreen2(
                          widget.userid,
                          widget.workdone,
                          widget.OrderID,
                          widget.Address,
                          widget.ProviderName,
                          widget.CustomerName,
                          widget.Price,
                          widget.ServiceName,
                          _updatedata2),
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

  void toggleSwitchs(bool value) {
    debugPrint("$value");
    setState(() {
      isSWITCHES = value ? '1' : '0';
      debugPrint(isSWITCHES);
    });
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

class SwitchScreen extends StatefulWidget {
  final String userid;
  final String workinprog;
  final String bookingid;
  final Function(String) updatedata;
  SwitchScreen(this.userid, this.workinprog, this.bookingid, this.updatedata);

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final allnotificationreference =
      FirebaseDatabase.instance.ref('AllNotification');
  final orderhistoryreference = FirebaseDatabase.instance.ref('OrderHistory');
  late String isSwitched; // Declare as late

  @override
  void initState() {
    super.initState();
    isSwitched = widget.workinprog; // Initialize in initState
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value ? '1' : '0';
    });
    if (value) widget.updatedata("1");
    if (value)
      ref.child(widget.bookingid).update({
        'bookingstatus': 'In progress',
        'Workinprog': isSwitched,
        'workprogressdate':
            DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'workprogresstime': selectedTime.format(context).toString(),
      });
    if (value)
      orderhistoryreference
          .child(widget.userid)
          .child(widget.bookingid)
          .update({
        'bookingstatus': 'In progress',
        'Workinprog': isSwitched,
        'workprogressdate':
            DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'workprogresstime': selectedTime.format(context).toString(),
      });
    if (value)
      orderhistoryreference
          .child(widget.userid)
          .child(widget.bookingid)
          .update({'review': '0'});

    if (value)
      allnotificationreference.child(widget.bookingid).update({
        // 'notificationid': widget.bookingid.toString(),
        // 'notificationname': widget.servicename.toString(),
        // 'subject': widget.address.toString(),
        'notificationtype': 'Order Work In Progress',
        // 'userid': widget.userid.toString(),
        // 'image': widget.image.toString(),
        // 'price': widget.price.toString(),
        // 'providerid': widget.providername.toString(),
        'time': selectedTime.format(context).toString(),
        'date': DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'messageseen': '1',
        // 'type': 'order'
      });
    if (!value)
      ref.child(widget.bookingid).update({
        'bookingstatus': 'Confirmed',
        'Workinprog': isSwitched,
        'workprogressdate': '',
        'workprogresstime': '',
      });
    if (!value)
      orderhistoryreference
          .child(widget.userid)
          .child(widget.bookingid)
          .update({
        'bookingstatus': 'Confirmed',
        'Workinprog': isSwitched,
        'workprogressdate': '',
        'workprogresstime': '',
      });
    if (!value) widget.updatedata("0");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched == '1',
              activeColor: Colors.green,
              activeTrackColor: Color.fromARGB(255, 174, 174, 174),
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Color.fromARGB(255, 174, 174, 174),
            )),
        Text(
          "Work in progress",
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}

class SwitchScreen2 extends StatefulWidget {
  final String userid;
  final String workdone;
  final String bookingid;
  final String address;
  final String? providername;

  final String price;
  final String servicename;
  final String image;
  final Function(String) updatedata2;
  SwitchScreen2(
      this.userid,
      this.workdone,
      this.bookingid,
      this.address,
      this.providername,
      this.price,
      this.servicename,
      this.image,
      this.updatedata2);

  @override
  State<SwitchScreen2> createState() => _SwitchScreen2State();
}

class _SwitchScreen2State extends State<SwitchScreen2> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  final ref = FirebaseDatabase.instance.ref('AllOrders');
  final allnotificationreference =
      FirebaseDatabase.instance.ref('AllNotification');

  late String isSwitched; // Declare as late
  final orderhistoryreference = FirebaseDatabase.instance.ref('OrderHistory');

  @override
  void initState() {
    super.initState();
    isSwitched = widget.workdone; // Initialize in initState
  }

  void toggleSwitch(bool value) {
    setState(() {
      isSwitched = value ? '1' : '0';
    });
    if (value) widget.updatedata2("1");
    if (value)
      ref.child(widget.bookingid).update({
        'bookingstatus': 'Completed',
        'workdone': isSwitched,
        'workdonedate':
            DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'workdonetime': selectedTime.format(context).toString(),
      });

    if (value)
      orderhistoryreference
          .child(widget.userid)
          .child(widget.bookingid)
          .update({
        'bookingstatus': 'Completed',
        'workdone': isSwitched,
        'workdonedate':
            DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'workdonetime': selectedTime.format(context).toString(),
      });
    if (value)
      orderhistoryreference
          .child(widget.userid)
          .child(widget.bookingid)
          .update({'review': '0'});
    if (value)
      allnotificationreference.child(widget.bookingid).update({
        // 'notificationid': widget.bookingid.toString(),
        // 'notificationname': widget.servicename.toString(),
        // 'subject': widget.address.toString(),
        'notificationtype': 'Order Completed',
        // 'userid': widget.userid.toString(),
        // 'image': widget.image.toString(),
        // 'price': widget.price.toString(),
        // 'providerid': widget.providername.toString(),
        'time': selectedTime.format(context).toString(),
        'date': DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'messageseen': '1',
        // 'type': 'order'
      });
    // .then((value) {
    //   Utils().toastMessage('');
    // }).onError((error, stackTrace) {
    //   Utils().toastMessage(error.toString());
    // });
    if (!value) widget.updatedata2("0");
    if (!value)
      ref.child(widget.bookingid).update({
        'bookingstatus': 'In progress',
        'workdone': isSwitched,
        'workdonedate': '',
        'workdonetime': '',
      });
    if (!value)
      orderhistoryreference
          .child(widget.userid)
          .child(widget.bookingid)
          .update({
        'bookingstatus': 'In progress',
        'workdone': isSwitched,
        'workdonedate': '',
        'workdonetime': '',
      });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
            scale: 1,
            child: Switch(
              onChanged: toggleSwitch,
              value: isSwitched == '1',
              activeColor: Colors.green,
              activeTrackColor: Color.fromARGB(255, 174, 174, 174),
              inactiveThumbColor: Colors.black,
              inactiveTrackColor: Color.fromARGB(255, 174, 174, 174),
            )),
        Text(
          "Work completed",
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}

// class SwitchScreenCheck extends StatefulWidget {
//   SwitchScreenCheck();

//   @override
//   State<SwitchScreenCheck> createState() => _SwitchScreenCheckState();
// }

// class _SwitchScreenCheckState extends State<SwitchScreenCheck> {
//   DateTime selectedDate = DateTime.now();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   final ref = FirebaseDatabase.instance.ref('AllOrders');
//   final allnotificationreference =
//       FirebaseDatabase.instance.ref('AllNotification');
//   final orderhistoryreference = FirebaseDatabase.instance.ref('OrderHistory');
//   String isSwitched = '0'; // Declare as late

//   @override
//   void initState() {
//     super.initState();
//     // Initialize in initState
//   }

//   void toggleSwitch(bool value) {
//     setState(() {
//       isSwitched = value ? '1' : '0';
//     });
//     // if (value)

//     // if (!value)
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Transform.scale(
//             scale: 1,
//             child: Switch(
//               onChanged: toggleSwitch,
//               value: isSwitched == '1',
//               activeColor: Colors.green,
//               activeTrackColor: Color.fromARGB(255, 174, 174, 174),
//               inactiveThumbColor: Colors.black,
//               inactiveTrackColor: Color.fromARGB(255, 174, 174, 174),
//             )),
//       ],
//     );
//   }
// }
