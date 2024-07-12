import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sahulatapp/admin/ui/inbox_screen/inbox_details.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/profileupdate.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/profile/editprofile.dart';

class UserMessageScreen extends StatefulWidget {
  final String userid;
  const UserMessageScreen({super.key, required this.userid});

  @override
  State<UserMessageScreen> createState() => _UserMessageScreenState();
}

class _UserMessageScreenState extends State<UserMessageScreen> {
  final ref = FirebaseDatabase.instance.ref('Allsupport');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xff9749ff),
              size: 22,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Messages",
            style: TextStyle(
              // fontWeight: FontWeight.bold,
              color: Color(0xff9749ff),
            ),
          ),
          elevation: 1,
          automaticallyImplyLeading: false,
          shadowColor: Colors.white,
          bottomOpacity: 10,
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: StreamBuilder(
              stream:
                  ref.orderByChild('senderid').equalTo(widget.userid).onValue,
              builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                if (snapshot.hasData &&
                    snapshot.data!.snapshot.value != null &&
                    snapshot.data!.snapshot.value is Map<dynamic, dynamic>) {
                  Map<dynamic, dynamic> map =
                      snapshot.data!.snapshot.value as dynamic;
                  List<dynamic> list = [];

                  list = map.values.toList();
                  return ListView.builder(
                    itemCount: snapshot.data!.snapshot.children.length,
                    itemBuilder: ((context, index) {
                      final imgPath = list[index]['userImage'];
                      return GestureDetector(
                        onTap: () {
                          // Navigate to new screen with selected item's data
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(
                                  reply: list[index]['Reply'],
                                  supporid: list[index]['SupporID'],
                                  message: list[index]['Message'],
                                  name: list[index]['Name'],
                                  title: list[index]['Title'],
                                  date: list[index]['Date'],
                                  userImage: list[index]['userImage'],
                                  imagePath: imgPath,
                                  type: list[index]['Type'],
                                  sender: list[index]['senderid']),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          width: 50,
                          height: 90,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 208, 184, 255),
                                spreadRadius: 0,
                                blurRadius: 10,
                                offset: Offset(0, 2),
                              ),
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: imgPath != null
                                          ? NetworkImage(imgPath!)
                                              as ImageProvider<Object>?
                                          : AssetImage(
                                              'assets/images/message.jpg'),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          list[index]['Name'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                          ),
                                        ),
                                        Text(list[index]['Title']),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Expanded(
                                    child: Text(
                                      list[index]['Date'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
                  );
                } else {
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(height: 20),
                          Text(
                            "There is no new message",
                            style: TextStyle(fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                  );
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
