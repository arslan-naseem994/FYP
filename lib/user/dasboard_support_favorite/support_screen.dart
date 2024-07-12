import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/user/dasboard_support_favorite/home_screen.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  final imgPath = 'assets/images/message.jpg';
  final auth = FirebaseAuth.instance;
  final ids = FirebaseAuth.instance.currentUser!.uid;
  bool loading = false;
  final dataBaseRef = FirebaseDatabase.instance.ref('support');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('Allsupport');
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  final emailController = TextEditingController();
  final titleController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final imageRefrence = FirebaseDatabase.instance.ref('User');
  String? imagess = '';
  final databaseReference = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);
  @override
  void initState() {
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final value = event.snapshot.value as Map<dynamic, dynamic>;
        final name = value['Name'] as String;
        final address = value['Email'] as String;
        final phone = value['Phone'] as String;

        nameController.text = name;
        emailController.text = address;
        phoneController.text = phone;
      }
    });
    _getImage();
    super.initState();
  }

  void _getImage() {
    imageRefrence.child(ids).child('image').once().then((DatabaseEvent event) {
      if (event.snapshot.value != null) {
        String image = 'empty';
        DataSnapshot snapshot = event.snapshot;
        image = snapshot.value.toString();
        imagess = image;
        return image;
      }
    });
  }

  String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  String getEmailValue() {
    String email = emailController.text.trim();
    if (email.isNotEmpty) {
      email += '@gmail.com';
    }
    return email;
  }

  String getphoneValue() {
    String phone = phoneController.text.trim();
    if (phone.isNotEmpty) {
      phone = '+92$phone';
    }
    return phone;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        /*leading: Padding(
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
         */
        automaticallyImplyLeading: false,
        title: const Text(
          'Get in touch',
          style: TextStyle(
            color: Color(0xff9749ff),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text("Get in touch",
              //     style: TextStyle(color: Color(0xff9749ff), fontSize: 30)),
              //sizedbox
              const SizedBox(
                height: 35,
              ),

              // Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: "Name",
                    counterText: '',
                  ),
                  maxLength: 30,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(
                        r'[A-Za-z ]')), // Allow alphabetic characters and spaces
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Divider(
                thickness: 1.0,
                height: 10,
                color: Colors.black,
              ),

              //sizedbox
              const SizedBox(
                height: 20,
              ),
              // timecontainer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Email"),
                      // suffixText: "@gmail.com",
                      counterText: '',
                    ),
                    maxLength: 25,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Email';
                      }
                      return null;
                    }),
              ),

              const Divider(
                thickness: 1.0,
                height: 10,
                color: Colors.black,
              ),

              const SizedBox(
                height: 20,
              ),
              // timecontainer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Phone"),
                      counterText: '',
                      prefixText: "+92",
                    ),
                    maxLength: 10,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // Only allow numeric input
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Phone#';
                      }
                      return null;
                    }),
              ),

              const Divider(
                thickness: 1.0,
                height: 10,
                color: Colors.black,
              ),

              const SizedBox(
                height: 20,
              ),
              // timecontainer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      label: Text("Title"),
                      counterText: '',
                    ),
                    maxLength: 20,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(
                          r'[A-Za-z ]')), // Allow alphabetic characters and spaces
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Title';
                      }
                      return null;
                    }),
              ),

              const Divider(
                thickness: 1.0,
                height: 10,
                color: Colors.black,
              ),

              // ****
              const SizedBox(
                height: 18,
              ),
              // timecontainer
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                    controller: messageController,
                    decoration: const InputDecoration(
                        border: InputBorder.none, label: Text("Message")),
                    maxLines: 3,
                    maxLength: 250,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Message';
                      }
                      return null;
                    }),
              ),

              const Divider(
                thickness: 1.0,
                height: 10,
                color: Colors.black,
              ),

              //SizedBox
              const SizedBox(
                height: 27,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Send',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 8.0),
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        String currentDate = getCurrentDate();
                        String emails = getEmailValue();
                        String phones = getphoneValue();
                        // ***********
                        String supporID =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        dataBaseRef.child(ids).child(supporID).set({
                          'Title': titleController.text.toString(),
                          'Name': nameController.text.toString(),
                          'Email': emails,
                          'Phone': phones,
                          'Message': messageController.text.toString(),
                          'SupporID': supporID.toString(),
                          'Date': currentDate,
                          'messageseen': '1',
                          'senderid': ids.toString(),
                          'Reply': false,
                          'Image': imgPath.toString(),
                          'Type': 'message',
                          'userImage': imagess.toString(),
                        }).then((value) {
                          Utils().toastMessage('Message has sent');
                          setState(() {
                            loading = false;
                          });
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });

                        // ************
                        // ***********
                        String supporID2 =
                            DateTime.now().millisecondsSinceEpoch.toString();
                        dataBaseRef2.child(supporID2).set({
                          'Title': titleController.text.toString(),
                          'Name': nameController.text.toString(),
                          'Email': emails,
                          'Phone': phones,
                          'Message': messageController.text.toString(),
                          'SupporID': supporID2.toString(),
                          'Date': currentDate,
                          'messageseen': '1',
                          'senderid': ids.toString(),
                          'Reply': false,
                          'Image': imgPath.toString(),
                          'Type': 'message',
                          'userImage': imagess.toString(),
                        }).then((value) {
                          Utils().toastMessage('Message has sent');
                          setState(() {
                            loading = false;
                          });
                        }).onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                          setState(() {
                            loading = false;
                          });
                        });
                        // ************
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostScreen()));
                      }

                      // Handle the onTap event here
                    },
                    borderRadius: BorderRadius.circular(28.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xff9749ff),
                      ),
                      padding: EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
