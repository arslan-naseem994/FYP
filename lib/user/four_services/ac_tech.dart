
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:sahulatapp/user/dasboard_support_favorite/favorite_screen.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VehicleCareScreen extends StatefulWidget {
  const VehicleCareScreen({super.key});

  @override
  State<VehicleCareScreen> createState() => _VehicleCareScreenState();
}

class _VehicleCareScreenState extends State<VehicleCareScreen> {
  final String name = 'AC Repair';
  final String imgpath = 'assets/images/Car Wash Services.jpg';
  final String prices = '10';
  final String name2 = 'AC Installation';
  final String imgpath2 = 'assets/images/Car Maintenance Services.jpg';
  final String prices2 = '15';
  final String name3 = 'AC Maintenance';
  final String imgpath3 = 'assets/images/Tire Services.jpg';
  final String prices3 = '20';

  bool hasNewData = false;
  bool hasNewData2 = false;
  bool hasNewData3 = false;
  final ref = FirebaseDatabase.instance.ref('favorite');
  final uids = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _listenForNewData();
    _listenForNewData2();
    _listenForNewData3();
  }

  void _listenForNewData() async {
    ref.child(uids).child('CAR WASH').onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      setState(() {
        if (dataSnapshot.value != null) {
          hasNewData = true;
        } else {
          hasNewData = false;
        }
      });
    });
  }

  void _listenForNewData2() async {
    ref.child(uids).child('MAINTENANCE').onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      setState(() {
        if (dataSnapshot.value != null) {
          hasNewData2 = true;
        } else {
          hasNewData2 = false;
        }
      });
    });
  }

  void _listenForNewData3() async {
    ref.child(uids).child('TIRE SERVICE').onValue.listen((event) {
      DataSnapshot dataSnapshot = event.snapshot;
      setState(() {
        if (dataSnapshot.value != null) {
          hasNewData3 = true;
        } else {
          hasNewData3 = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const PostScreen()));
        return true;
      },
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
            "AC SERVICE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xff9749ff),
            ),
          ),
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Color(0xff9749ff),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceOne(
                          name: name,
                          imgpath: imgpath,
                          prices: prices,
                          expert: 'HVAC Technician'),
                    ),
                  );
                },
                child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff9749ff),
                            spreadRadius: 0,
                            blurRadius: 3,
                            // offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/Car Wash Services.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              'AC REPAIR',
                              style: TextStyle(fontSize: 15),
                            ),
                            const Spacer(),
                            // Column(
                            //   children: [
                            //     Text(
                            //       'Price',
                            //       style: TextStyle(
                            //           color: Colors.grey.withOpacity(0.5),
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //     const SizedBox(height: 5),
                            //     Text(
                            //       '10\$',
                            //       style: TextStyle(
                            //           color: Colors.grey.withOpacity(0.5),
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (hasNewData == false) {
                                  ref.child(uids).child('CAR WASH').set({
                                    'Image': imgpath.toString(),
                                    'ServiceName': name.toString(),
                                    'Price': prices.toString(),
                                    'UserID': uids.toString(),
                                    'Expertise': 'HVAC Technician',
                                  }).then((value) {
                                    Utils().toastMessage('Done');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });
                                  setState(() {
                                    _listenForNewData();
                                  });
                                } else if (hasNewData == true) {
                                  setState(() {
                                    _listenForNewData();
                                  });

                                  ref.child(uids).child('CAR WASH').remove();
                                }

                                // ***********
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => FavoriteScreen()),
                                // );
                              },
                              child: Icon(
                                hasNewData
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_border,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ServiceOne(
                            name: name2,
                            imgpath: imgpath2,
                            prices: prices2,
                            expert: 'HVAC Technician'),
                      ));
                },
                child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff9749ff),
                            spreadRadius: 0,
                            blurRadius: 3,
                            // offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/Car Maintenance Services.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              'AC INSTALLATION',
                              style: TextStyle(fontSize: 15),
                            ),
                            Spacer(),
                            // Column(
                            //   children: [
                            //     Text(
                            //       'Price',
                            //       style: TextStyle(
                            //           color: Colors.grey.withOpacity(0.5),
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //     const SizedBox(height: 5),
                            //     Text(
                            //       '15\$',
                            //       style: TextStyle(
                            //           color: Colors.grey.withOpacity(0.5),
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.bold),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (hasNewData2 == false) {
                                  ref.child(uids).child('MAINTENANCE').set({
                                    'Image': imgpath2.toString(),
                                    'ServiceName': name2.toString(),
                                    'Price': prices2.toString(),
                                    'UserID': uids.toString(),
                                    'Expertise': 'HVAC Technician',
                                  }).then((value) {
                                    Utils().toastMessage('Done');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });
                                  setState(() {
                                    _listenForNewData2();
                                  });
                                } else if (hasNewData2 == true) {
                                  setState(() {
                                    _listenForNewData2();
                                  });

                                  ref.child(uids).child('MAINTENANCE').remove();
                                }

                                // ***********
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => FavoriteScreen()),
                                // );
                              },
                              child: Icon(
                                hasNewData2
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_border,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ServiceOne(
                              name: name3,
                              imgpath: imgpath3,
                              prices: prices3,
                              expert: 'HVAC Technician'),
                        ));
                  },
                  child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xff9749ff),
                            spreadRadius: 0,
                            blurRadius: 3,
                            // offset: Offset(0, 10), // changes position of shadow
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/Tire Services.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'AC MAINTENENCE',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            // Column(
                            //   children: [
                            //     Text(
                            //       'Price',
                            //       style: TextStyle(
                            //         color: Colors.grey.withOpacity(0.5),
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //     SizedBox(height: 5),
                            //     Text(
                            //       '10\$',
                            //       style: TextStyle(
                            //         color: Colors.grey.withOpacity(0.5),
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.bold,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (hasNewData3 == false) {
                                  ref.child(uids).child('TIRE SERVICE').set({
                                    'Image': imgpath3.toString(),
                                    'ServiceName': name3.toString(),
                                    'Price': prices3.toString(),
                                    'UserID': uids.toString(),
                                    'Expertise': 'HVAC Technician',
                                  }).then((value) {
                                    Utils().toastMessage('Done');
                                  }).onError((error, stackTrace) {
                                    Utils().toastMessage(error.toString());
                                  });
                                  setState(() {
                                    _listenForNewData3();
                                  });
                                } else if (hasNewData3 == true) {
                                  setState(() {
                                    _listenForNewData3();
                                  });

                                  ref
                                      .child(uids)
                                      .child('TIRE SERVICE')
                                      .remove();
                                }

                                // ***********
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => FavoriteScreen()),
                                // );
                              },
                              child: Icon(
                                hasNewData3
                                    ? Icons.favorite_sharp
                                    : Icons.favorite_border,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
