import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sahulatapp/chatscreen.dart';
import 'package:sahulatapp/ui/posts/selectProvider/all_reviews.dart';

class SelectedUserDetailScreen extends StatefulWidget {
  final Map<dynamic, dynamic> userData;
  final String? averageRating;
  const SelectedUserDetailScreen(
      {super.key, required this.userData, this.averageRating});

  @override
  State<SelectedUserDetailScreen> createState() =>
      _SelectedUserDetailScreenState();
}

class _SelectedUserDetailScreenState extends State<SelectedUserDetailScreen> {
  final ref = FirebaseDatabase.instance.ref('review');
  final uids = FirebaseAuth.instance.currentUser!.uid;

  Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho) {
    // final query = ref.child(desired).orderByChild('workdone').equalTo('0');

    final query = ref.child(pho);

    return query.onValue.map((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'AddressVerification' is not null
        final filteredList = userList.values
            // .where((userData) => userData['bookingstatus'] != 'Completed')
            .toList();

        return filteredList.cast<Map<dynamic, dynamic>>();
      }

      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(left: 10, top: 30),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff9749ff),
                size: 20,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        title: null,
        elevation: 0,
        automaticallyImplyLeading: false,
        shadowColor: Color(0xff9749ff),
        bottomOpacity: 10,
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 13, top: 30),
              child: Row(
                children: [
                  SizedBox(width: 5),
                  Text("${widget.averageRating}",
                      style: TextStyle(color: Colors.black)),
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 18,
                  ),
                  SizedBox(width: 5),
                ],
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 13,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: 165,
                  height: 165,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueGrey,
                          // offset: Offset(4, 7),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: Color(0xff9749ff),
                      radius: 45,
                      backgroundImage: widget.userData['image'].toString() ==
                              null
                          ? NetworkImage(
                              "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")
                          : NetworkImage(widget.userData['image'].toString()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  widget.userData['Name'],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            size: 17,
                          ),
                          Text('Pakistan'),
                        ],
                      )),
                      Expanded(
                        child: Text(''),
                      ),
                      if (widget.userData['commission'] == null)
                        Expanded(
                          child: Text(
                            "No commission set",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      if (widget.userData['commission'] != null)
                        Expanded(
                          child: Text(
                            "Rs${widget.userData['commission']}",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                            textAlign: TextAlign.right,
                          ),
                        ),
                    ],
                  )),
              SizedBox(
                height: 18,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  "Bio",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 7,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Icon(
                                Icons.phone,
                                size: 17,
                              ),
                              Text('+92${widget.userData['Phone']}'),
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Text(''),
                      ),
                      if (widget.userData['experience'] == null)
                        Expanded(
                          flex: 4,
                          child: Text(
                            "NO Experience",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      if (widget.userData['experience'] != null)
                        Expanded(
                          flex: 4,
                          child: Text(
                            "${widget.userData['experience']} Years Experience",
                            style: TextStyle(fontSize: 13, color: Colors.grey),
                            textAlign: TextAlign.right,
                          ),
                        ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 7,
                  right: 10,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.email,
                      size: 17,
                    ),
                    Text(widget.userData['email']),
                  ],
                ),
              ),
              SizedBox(
                height: 18,
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Review",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: Text(''),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AllReviewsScreen(
                                          providerid: widget.userData['UserID'],
                                        )));
                          },
                          child: Text(
                            "View All",
                            style: TextStyle(
                                // decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.black),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.only(
                  left: 7,
                  // right: 10,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 200,
                  child: StreamBuilder(
                    stream:
                        fetchUsersWithAge(widget.userData['UserID'].toString()),
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
                        final userList = snapshot.data!.take(10).toList();
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            // itemCount: userList.length,
                            itemCount: userList.length,
                            itemBuilder: ((context, index) {
                              final userData = userList[index];
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 12),
                                  width: 250,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      // boxShadow: const [
                                      //   BoxShadow(
                                      //     color: Colors.blueGrey,
                                      //     // spreadRadius: 2,
                                      //     blurRadius: 5,
                                      //     offset: Offset(
                                      //         0, 10), // changes position of shadow
                                      //   ),
                                      // ],
                                      color: Color.fromARGB(255, 169, 255, 239),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: AssetImage(
                                                    "assets/images/friend.jpg"),
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
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${userData['username']}",
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      SizedBox(width: 5),
                                                      Text(
                                                        "${userData['date']}",
                                                        style: const TextStyle(
                                                            fontSize: 7,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey),
                                                      ),
                                                      SizedBox(
                                                        width: 2,
                                                      ),
                                                      Text(
                                                        "${userData['time']}",
                                                        style: const TextStyle(
                                                            fontSize: 7,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.grey),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: <Widget>[
                                                      RatingBar.builder(
                                                        itemSize: 15,
                                                        ignoreGestures: true,
                                                        initialRating:
                                                            double.parse(
                                                          userData['rating'],
                                                        ),
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    0.5),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          // print(rating);
                                                        },
                                                      ),

                                                      // Text(
                                                      //   "Schedule:",
                                                      //   style: TextStyle(
                                                      //       fontSize: 12,
                                                      //       fontWeight:
                                                      //           FontWeight.bold),
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      // ),
                                                      // SizedBox(width: 12),
                                                      // Text(
                                                      //   userData['date'],
                                                      //   style: TextStyle(
                                                      //       fontSize: 12,
                                                      //       fontWeight:
                                                      //           FontWeight.bold),
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      // ),
                                                      // SizedBox(width: 3),
                                                      // Text(
                                                      //   userData['time'],
                                                      //   style: TextStyle(
                                                      //       fontSize: 12,
                                                      //       fontWeight:
                                                      //           FontWeight.bold),
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      // ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Text(
                                          "${userData['message']}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
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
                                  "There is no review",
                                  style: TextStyle(fontWeight: FontWeight.w900),
                                )
                              ],
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                  ),
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 10,
                              minimumSize: Size(60, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black),
                          )),
                      SizedBox(
                        width: 7,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff9749ff),
                              elevation: 12,
                              minimumSize: Size(180, 40),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            Navigator.pop(context, widget.userData);
                          },
                          child: Text("Book Now")),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatScreen(
                                        providerid: widget.userData['UserID'],
                                        role: 'user',
                                        userid: uids,
                                      )));
                        },
                        child: Icon(
                          Icons.chat,
                          color: Color(0xff9749ff),
                          size: 35,
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
