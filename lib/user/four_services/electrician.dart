import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:sahulatapp/user/dasboard_support_favorite/favorite_screen.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/order_form.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ElectricianScreen extends StatefulWidget {
  const ElectricianScreen({super.key});

  @override
  State<ElectricianScreen> createState() => _ElectricianScreenState();
}

class _ElectricianScreenState extends State<ElectricianScreen> {
  final String name = 'LIGHTINGS';
  final String imgpath = 'assets/images/lights.jpg';
  final String prices = '10';
  final String name2 = 'SWITCHES';
  final String imgpath2 = 'assets/images/switch.jpg';
  final String prices2 = '15';
  final String name3 = 'SWITCHBOARD';
  final String imgpath3 = 'assets/images/DB.jpg';
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
    ref.child(uids).child('LIGHTINGS').onValue.listen((event) {
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
    ref.child(uids).child('SWITCHES').onValue.listen((event) {
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
    ref.child(uids).child('SWITCHBOARD').onValue.listen((event) {
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
            "ELECTRICIAN",
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
                          expert: 'Electrician'),
                    ),
                  );
                },
                child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            // gradient: LinearGradient(
                            //     // stops: [0.6, 0.5],

                            //     // begin: Alignment.topRight,
                            //     // end: Alignment.bottomLeft,
                            //     begin: FractionalOffset(0.0, 0.0),
                            //     end: FractionalOffset(1.0, 1.0),
                            //     colors: [
                            //       Color.fromARGB(255, 216, 187, 255),
                            //       Color.fromRGBO(145, 62, 255, 1),
                            //       // Color.fromARGB(255, 0, 255, 94),
                            //     ]),
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
                                'assets/images/light.png',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              'LIGHTINGS',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            const Spacer(),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (hasNewData == false) {
                                  ref.child(uids).child('LIGHTINGS').set({
                                    'Image': imgpath.toString(),
                                    'ServiceName': name.toString(),
                                    'Price': prices.toString(),
                                    'UserID': uids.toString(),
                                    'Expertise': 'Electrician',
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

                                  ref.child(uids).child('LIGHTINGS').remove();
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
                                color: Color.fromARGB(255, 0, 255, 8),
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
                            expert: 'Electrician'),
                      ));
                },
                child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //     // stops: [0.6, 0.5],

                        //     // begin: Alignment.topRight,
                        //     // end: Alignment.bottomLeft,
                        //     begin: FractionalOffset(0.0, 0.0),
                        //     end: FractionalOffset(1.0, 1.0),
                        //     colors: [
                        //       Color.fromARGB(255, 138, 247, 255),
                        //       Color.fromARGB(255, 0, 204, 255),
                        //       // Color.fromARGB(255, 0, 255, 94),
                        //     ]),
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
                                'assets/images/switch.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 20),
                            const Text(
                              'SWITCHES',
                              style: TextStyle(fontSize: 15),
                            ),
                            Spacer(),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (hasNewData2 == false) {
                                  ref.child(uids).child('SWITCHES').set({
                                    'Image': imgpath2.toString(),
                                    'ServiceName': name2.toString(),
                                    'Price': prices2.toString(),
                                    'UserID': uids.toString(),
                                    'Expertise': 'Electrician',
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

                                  ref.child(uids).child('SWITCHES').remove();
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
                                color: Color.fromARGB(255, 0, 255, 8),
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
                              expert: 'Electrician'),
                        ));
                  },
                  child: Container(
                    width: 360,
                    height: 100,
                    decoration: BoxDecoration(
                        // gradient: LinearGradient(
                        //     // stops: [0.6, 0.5],

                        //     // begin: Alignment.topRight,
                        //     // end: Alignment.bottomLeft,
                        //     begin: FractionalOffset(0.0, 0.0),
                        //     end: FractionalOffset(1.0, 1.0),
                        //     colors: [
                        //       Color.fromARGB(255, 138, 247, 255),
                        //       Color.fromARGB(255, 0, 204, 255),
                        //       // Color.fromARGB(255, 0, 255, 94),
                        //     ]),
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
                                'assets/images/DB.jpg',
                                width: 100,
                                height: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'SWITCHBOARD',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            SizedBox(width: 10),
                            GestureDetector(
                              onTap: () {
                                if (hasNewData3 == false) {
                                  ref.child(uids).child('SWITCHBOARD').set({
                                    'Image': imgpath3.toString(),
                                    'ServiceName': name3.toString(),
                                    'Price': prices3.toString(),
                                    'UserID': uids.toString(),
                                    'Expertise': 'Electrician',
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

                                  ref.child(uids).child('SWITCHBOARD').remove();
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
                                color: Color.fromARGB(255, 0, 255, 8),
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
