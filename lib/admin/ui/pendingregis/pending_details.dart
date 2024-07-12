import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sahulatapp/admin/ui/home_Screen.dart';
import 'package:sahulatapp/admin/ui/pendingregis/image.dart';

class PendingDetailsScreen extends StatefulWidget {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String id1;
  final String id2;
  final String code;
  final String userid;
  final String profilepicture;
  const PendingDetailsScreen(
      {required this.name,
      required this.email,
      required this.phone,
      required this.id1,
      required this.id2,
      required this.address,
      required this.code,
      required this.userid,
      required this.profilepicture,
      super.key});

  @override
  State<PendingDetailsScreen> createState() => _PendingDetailsScreenState();
}

class _PendingDetailsScreenState extends State<PendingDetailsScreen> {
  Timer? timer;
  Future<void> _generateAndSavePDF() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              pw.Text("Email: ${widget.email}"),
              pw.Text("Name: ${widget.name}"),
              pw.Text("Phone: ${widget.phone}"),
              pw.Text("Address: ${widget.address}"),
              pw.Text("Code: ${widget.code}"),
            ],
          ),
        );
      },
    ));

    final pdfBytes = await pdf.save();

    // Request external storage permission
    // if (await Permission.storage.request().isGranted) {
    final directoryPath = await FilePicker.platform.getDirectoryPath();
    Permission.storage.request();
    if (directoryPath != null) {
      final output = File('$directoryPath/${widget.email}.pdf');
      await output.writeAsBytes(pdfBytes);
      print('PDF saved to ${output.path}');
      ref.child(widget.userid).update({'verified': 'true'});
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AdminDashboardScreen()));
    }
    // } else {
    //   // Handle denied permission
    //   print('Permission denied');
    // }
  }

  final ref = FirebaseDatabase.instance.ref('Provider');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                        imageUrl: widget.profilepicture.toString(),
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  width: 100,
                  height: 100,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 191, 141, 255),
                        )),
                    child: CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          NetworkImage(widget.profilepicture.toString()),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                        imageUrl: widget.id1.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.id1),
                      fit: BoxFit.cover, // Adjust to your preference
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                        imageUrl: widget.id2.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: 400,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(widget.id2),
                      fit: BoxFit.cover, // Adjust to your preference
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Name: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Email: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.email,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Phone: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.phone,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      "Address: ",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 9,
                    child: Text(
                      widget.address,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Container(
                    width: 100, // Set the desired width
                    height: 50, // Set the desired height
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text("Confirmation"),
                              content: Text(
                                  "Do you really want to accept this registration?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    timer = Timer.periodic(
                                      Duration(seconds: 2),
                                      (timer) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Registration has been accepted'),
                                          duration: Duration(seconds: 3),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    );
                                    _generateAndSavePDF();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff9749ff),
                          elevation: 12,
                          minimumSize: const Size(200, 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      child: Text("Confirm"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 100, // Set the desired width
                    height: 50, // Set the desired height
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey.shade100,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              title: Text("Confirmation"),
                              content: Text(
                                  "Do you really want to cancel this registration?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    timer = Timer.periodic(
                                      Duration(seconds: 2),
                                      (timer) {
                                        final snackBar = SnackBar(
                                          content: Text(
                                              'Registration has been canceled'),
                                          duration: Duration(seconds: 3),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                    );
                                    ref.child(widget.userid).remove();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 238, 237, 237),
                        foregroundColor: Color.fromARGB(
                            255, 50, 0, 119), // Change the button text color
                        textStyle: TextStyle(
                            fontSize: 15), // Change the button text size
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20), // Change button border radius
                        ),
                      ),
                      child: Text("Cancel"),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
