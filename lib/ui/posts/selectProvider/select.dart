import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/ui/posts/selectProvider/selected_user_detail_screen.dart';

class selectionScreen extends StatefulWidget {
  final String expert;
  const selectionScreen({
    super.key,
    required this.expert,
  });

  @override
  State<selectionScreen> createState() => _selectionScreenState();
}

class _selectionScreenState extends State<selectionScreen> {
  final ref = FirebaseDatabase.instance.ref('Provider');
  final uids = FirebaseAuth.instance.currentUser!.uid;
  int selectedProvider = 0;

  @override
  Widget build(BuildContext constext) {
    Stream<List<Map<dynamic, dynamic>>> fetchUsersWithAge(int rat) {
      final query =
          ref.orderByChild('Expertise').equalTo(widget.expert.toString());

      return query.onValue.map((event) {
        final dataSnapshot = event.snapshot;
        final userList = dataSnapshot.value ?? {};
//  || userData['AddressVerification'] != 'null' ||
        if (userList is Map<dynamic, dynamic>) {
          // Filter the userList to get only the entries where 'AddressVerification' is not null
          if (rat == 0) {
            final filteredList = userList.values
                .where((userData) => userData['AddressVerification'] != 'null')
                .toList();
            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (rat == 1) {
            final filteredList = userList.values
                .where((userData) =>
                    userData['AddressVerification'] != 'null' &&
                        userData['rating'] == '1.0' ||
                    userData['rating'] == '1.5')
                .toList();
            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (rat == 2) {
            final filteredList = userList.values
                .where((userData) =>
                    userData['AddressVerification'] != 'null' &&
                        userData['rating'] == '2.0' ||
                    userData['rating'] == '2.5')
                .toList();
            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (rat == 3) {
            final filteredList = userList.values
                .where((userData) =>
                    userData['AddressVerification'] != 'null' &&
                        userData['rating'] == '3.0' ||
                    userData['rating'] == '3.5')
                .toList();
            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (rat == 4) {
            final filteredList = userList.values
                .where((userData) =>
                    userData['AddressVerification'] != 'null' &&
                        userData['rating'] == '4.0' ||
                    userData['rating'] == '4.5')
                .toList();
            return filteredList.cast<Map<dynamic, dynamic>>();
          }
          if (rat == 5) {
            final filteredList = userList.values
                .where((userData) =>
                    userData['AddressVerification'] != 'null' &&
                    userData['rating'] == '5.0')
                .toList();
            return filteredList.cast<Map<dynamic, dynamic>>();
          }
        }

        return [];
      });
    }

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
          "Service Providers",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5.0,
              children: List.generate(5, (index) {
                final rating = index + 1;
                final isSelected = selectedProvider == rating;

                return FilterChip(
                  label: Text('Rating $rating'),
                  selected: isSelected,
                  onSelected: (isSelected) {
                    if (isSelected) {
                      setState(() {
                        selectedProvider = rating;
                        debugPrint("Selected Rating: $selectedProvider");
                      });
                    } else {
                      setState(() {
                        selectedProvider = 0;

                        debugPrint("unselected Rating: $selectedProvider");
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
              stream: fetchUsersWithAge(selectedProvider),
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
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      final userData = userList[index];
                      final imgPath = userData['image'] as String?;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SelectedUserDetailScreen(
                                  userData: userData,
                                  averageRating: userData['rating']),
                            ),
                          ).then((userData) {
                            if (userData != null) {
                              Navigator.pop(context, userData);
                              setState(() {});
                              // Update UI with the selected fruit data
                            }
                          });
                          // Navigator.pop(context, userData);
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 13, vertical: 12),
                          width: 50,
                          height: 80,
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
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10),
                              Expanded(
                                flex: 2,
                                child: CircleAvatar(
                                    radius: 35,
                                    backgroundImage: imgPath != null
                                        ? NetworkImage(imgPath.toString())
                                        : const NetworkImage(
                                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png")),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userData['Name'],
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(userData['Address']),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                  flex: 3,
                                  child: Row(
                                    children: [
                                      userData['rating'] != null
                                          ? Text("${userData['rating']}")
                                          : Text(
                                              'no rating',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                        size: 18,
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        color: Color(0xff9749ff),
                                      )
                                    ],
                                  )),
                              // SizedBox(width: 5),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 20),
                          Text(
                            "Sorry, There is no provider yet",
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
