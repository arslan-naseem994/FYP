
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class UserReviewsScreens extends StatefulWidget {
  final String providerid;
  const UserReviewsScreens({super.key, required this.providerid});

  @override
  State<UserReviewsScreens> createState() => _UserReviewsScreensState();
}

class _UserReviewsScreensState extends State<UserReviewsScreens> {
  final ref = FirebaseDatabase.instance.ref('review');
  int totalreviews = 0;
  int selectedRating = 0;
  @override
  void initState() {
    totalReview();
    super.initState();
  }

  void totalReview() {
    ref.child(widget.providerid).onValue.listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        if (selectedRating == 0) {
          final filteredList = userList.values.toList();
          setState(() {
            totalreviews = filteredList.length;
          });
          debugPrint("Length: $totalreviews");
        }
        if (selectedRating == 1) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '1.0' || userData['rating'] == '1.5')
              .toList();
          setState(() {
            totalreviews = filteredList.length;
          });
          debugPrint("Length: $totalreviews");
        }
        if (selectedRating == 2) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '2.0' || userData['rating'] == '2.5')
              .toList();
          setState(() {
            totalreviews = filteredList.length;
          });
          debugPrint("Length: $totalreviews");
        }
        if (selectedRating == 3) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '3.0' || userData['rating'] == '3.5')
              .toList();
          setState(() {
            totalreviews = filteredList.length;
          });
          debugPrint("Length: $totalreviews");
        }
        if (selectedRating == 4) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '4.0' || userData['rating'] == '4.5')
              .toList();
          setState(() {
            totalreviews = filteredList.length;
          });
          debugPrint("Length: $totalreviews");
        }
        if (selectedRating == 5) {
          final filteredList = userList.values
              .where((userData) => userData['rating'] == '5.0')
              .toList();
          setState(() {
            totalreviews = filteredList.length;
          });
          debugPrint("Length: $totalreviews");
        }
      }
    });
  }

  Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(String pho, int rat) {
    // final query = ref.child(desired).orderByChild('workdone').equalTo('0');

    final query = ref.child(pho);

    return query.onValue.map((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        if (rat == 0) {
          final filteredList = userList.values.toList();

          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (rat == 1) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '1.0' || userData['rating'] == '1.5')
              .toList();
          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (rat == 2) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '2.0' || userData['rating'] == '2.5')
              .toList();
          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (rat == 3) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '3.0' || userData['rating'] == '3.5')
              .toList();
          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (rat == 4) {
          final filteredList = userList.values
              .where((userData) =>
                  userData['rating'] == '4.0' || userData['rating'] == '4.5')
              .toList();
          return filteredList.cast<Map<dynamic, dynamic>>();
        }
        if (rat == 5) {
          final filteredList = userList.values
              .where((userData) => userData['rating'] == '5.0')
              .toList();
          return filteredList.cast<Map<dynamic, dynamic>>();
        }
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
          "Reviews",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Color(0xff9749ff),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                "Review Count: $totalreviews",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xff9749ff),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5.0,
              children: List.generate(5, (index) {
                final rating = index + 1;
                final isSelected = selectedRating == rating;

                return FilterChip(
                  label: Text('Rating $rating'),
                  selected: isSelected,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      setState(() {
                        selectedRating = rating;
                        debugPrint("Selected Rating: $selectedRating");
                        totalReview();
                      });
                    } else {
                      setState(() {
                        selectedRating = 0;
                        totalReview();
                        debugPrint("unselected Rating: $selectedRating");
                      });
                    }
                  },
                  selectedColor: Color.fromARGB(
                      255, 123, 255, 231), // Change to your preferred color
                  backgroundColor: Colors.grey[300],
                );
              }),
            ),
          ),

          //
          Expanded(
            child: StreamBuilder(
              stream: fetchUsersWithAge(
                  widget.providerid.toString(), selectedRating),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      width: 120,
                      child: LinearProgressIndicator(
                        minHeight: 5,
                        backgroundColor: Colors.black,
                        // strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  );
                } else if (snapshot.hasData &&
                    snapshot.data != null &&
                    (snapshot.data as List).isNotEmpty) {
                  final userList = snapshot.data!;
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      // itemCount: userList.length,
                      itemCount: userList.length,
                      itemBuilder: ((context, index) {
                        final userData = userList[index];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            width: 250,
                            height: 180,
                            decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xff9749ff),
                                    spreadRadius: 0.1,
                                    blurRadius: 3,
                                    // offset: Offset(0, 10), // changes position of shadow
                                  ),
                                ],
                                color: Color.fromARGB(255, 217, 235, 255),
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
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
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(width: 40),
                                                Text(
                                                  "${userData['date']}",
                                                  style: const TextStyle(
                                                      fontSize: 10,
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
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                RatingBar.builder(
                                                  itemSize: 14,
                                                  ignoreGestures: true,
                                                  initialRating: double.parse(
                                                    userData['rating'],
                                                  ),
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  itemCount: 5,
                                                  itemPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 0.3),
                                                  itemBuilder: (context, _) =>
                                                      Icon(
                                                    Icons.star,
                                                    color: Colors.amber,
                                                  ),
                                                  onRatingUpdate: (rating) {
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 12,
                                      right: 8,
                                    ),
                                    child: Text(
                                      "${userData['message']}",
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
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
        ],
      ),
    );
  }
}
