import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:sahulatapp/user/user_profile_screens/profile.dart';
import 'package:sahulatapp/ui/posts/recent_orders.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

import '../../ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? uploadedImageUrl;
  bool uploadingImage = false;
  double uploadProgress = 0.0;
  final auth = FirebaseAuth.instance;
  final ids = FirebaseAuth.instance.currentUser!.uid;
  final fullname = TextEditingController();
  final addresss = TextEditingController();
  final phoneno = TextEditingController();

  bool loading = false;
  final dataBaseRef = FirebaseDatabase.instance.ref('User');
  final _formkey = GlobalKey<FormState>();
  final imageUrls = FirebaseStorage.instance.ref('User').child('image');
  String imageUrl = '';
  String role = 'user';
  final storage = FirebaseStorage.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final databaseReference = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid);

  final databaseReference2 = FirebaseDatabase.instance
      .ref('User')
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child('image');

  @override
  void initState() {
    databaseReference.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final value = event.snapshot.value as Map<dynamic, dynamic>;
        final name = value['Name'] as String;
        final address = value['Address'] as String;
        final phone = value['Phone'] as String;

        fullname.text = name;
        addresss.text = address;
        phoneno.text = phone;
      }
    });
    hi();
    super.initState();
  }

  void hi() {
    setState(() {
      databaseReference2.once().then((DatabaseEvent event) {
        String Image = 'empty';
        DataSnapshot snapshot = event.snapshot;
        Image = snapshot.value.toString();

        return Image;
      }).then((Image) {
        if (Image != null) {
          setState(() {
            uploadedImageUrl = Image;
          });
        } else {
          setState(() {
            uploadedImageUrl = 'assets/logo/camera.jpg';
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(top: 50, bottom: 50, left: 40, right: 40),
            child: Column(children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 0),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Color.fromARGB(255, 191, 141, 255),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const PostScreen()));
                      },
                    ),
                  ),
                ],
              ),
              // Add a boolean flag to track the image upload status

              // Add a boolean flag to track the image upload status

              // Add a boolean flag to track the image upload status
              // Add a variable to store the upload progress

              // Add a boolean flag to track the image upload status// Add a variable to store the upload progress

              // Add a variable to store the upload progress
              // Add a variable to store the uploaded image URL

              Stack(
                alignment:
                    Alignment.bottomRight, // Align elements to the bottom right
                children: [
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 191, 141, 255),
                        )),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: uploadedImageUrl != null
                          ? NetworkImage(uploadedImageUrl!)
                              as ImageProvider<Object>?
                          : AssetImage('assets/logo/camera.jpg'),
                    ),
                  ),
                  Positioned(
                    right: 5,
                    bottom: 5,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 191, 141, 255)
                                .withOpacity(0.5),
                            offset: Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Color.fromARGB(255, 191, 141, 255),
                        ),
                        onPressed: () async {
                          ImagePicker imagePicker = ImagePicker();
                          XFile? file = await imagePicker.pickImage(
                              source: ImageSource.gallery);
                          print('${file?.path}');
                          if (file == null) return;

                          setState(() {
                            uploadingImage =
                                true; // Set the flag to indicate image upload is in progress
                          });

                          Reference referenceRoot =
                              FirebaseStorage.instance.ref();
                          Reference referenceDirImages =
                              referenceRoot.child('images');

                          Reference referenceImageToUpload = referenceDirImages
                              .child(FirebaseAuth.instance.currentUser!.uid);
                          try {
                            UploadTask uploadTask = referenceImageToUpload
                                .putFile(File(file.path)); //put!
                            uploadTask.snapshotEvents
                                .listen((TaskSnapshot snapshot) {
                              double progress = snapshot.bytesTransferred /
                                  snapshot.totalBytes;
                              setState(() {
                                uploadProgress =
                                    progress; // Update the upload progress
                              });
                            });
                            await uploadTask;

                            uploadedImageUrl =
                                await referenceImageToUpload.getDownloadURL();
                          } catch (error) {
                            // Handle the error appropriately
                          }

                          setState(() {
                            uploadingImage =
                                false; // Set the flag to indicate image upload is completed
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              if (uploadingImage) // Display progress bar only when uploadingImage is true
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    LinearProgressIndicator(
                      value: uploadProgress,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Uploading: ${(uploadProgress * 100).toStringAsFixed(1)}%',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 20),
              Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    // Declare the TextEditingController

                    // Declare the TextEditingController

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 191, 141, 255)
                                .withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        maxLength: 35,
                        controller: fullname,
                        onChanged: (value) {
                          setState(
                              () {}); // Update the widget state to refresh the suffixIcon
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          prefixIcon: const Icon(Icons.person_2_outlined,
                              color: Color.fromARGB(255, 191, 141, 255)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 141, 255),
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 141,
                                  255), // Set the color of the outline border
                              width:
                                  0, // Adjust the width to make the outline border bold
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 141, 255),
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          labelText: 'Full Name',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: fullname.text.isNotEmpty
                              ? Icon(Icons.check, color: Colors.green)
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                        ),
                        // validator
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Name';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ), // Declare the TextEditingController

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 191, 141, 255)
                                .withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        maxLength: 50,
                        controller: addresss,
                        onChanged: (value) {
                          setState(
                              () {}); // Update the widget state to refresh the suffixIcon
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          prefixIcon: const Icon(Icons.location_on_outlined,
                              color: Color.fromARGB(255, 191, 141, 255)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(
                                  0.5), // Set the color of the outline border
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 141, 255),
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          hintText: '123 Main St, Sahiwal',
                          labelText: 'Address',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: addresss.text.isNotEmpty
                              ? Icon(Icons.check, color: Colors.green)
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                        ),
                        // validator
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Address';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // Declare the TextEditingController

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 191, 141, 255)
                                .withOpacity(0.5),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: TextFormField(
                        maxLength: 11,
                        controller: phoneno,
                        onChanged: (value) {
                          setState(
                              () {}); // Update the widget state to refresh the suffixIcon
                        },
                        decoration: InputDecoration(
                          counterText: '',
                          prefixIcon: const Icon(Icons.phone_outlined,
                              color: Color.fromARGB(255, 191, 141, 255)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Colors.grey.withOpacity(
                                  0.5), // Set the color of the outline border
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(100),
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 191, 141, 255),
                              width:
                                  1.5, // Adjust the width to make the outline border bold
                            ),
                          ),
                          hintText: 'Phone No',
                          labelText: 'Phone No',
                          labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          suffixIcon: phoneno.text.isNotEmpty
                              ? Icon(Icons.check, color: Colors.green)
                              : null,
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 16, horizontal: 16),
                        ),
                        // validator
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Number';
                          }
                          return null;
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    //Round Button
                    Center(
                      child: RoundButton(
                          width: 200,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 191, 141, 255)
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(
                                      0, 10), // changes position of shadow
                                ),
                              ],
                              color: Color(0xff9749ff),
                              border: Border.all(color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(30)),
                          title: 'Update',
                          loading: loading,
                          ontap: () {
                            // if (imageUrl.isEmpty) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(content: Text("please Upload Image")));
                            //   return;
                            // }
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              // String orderID =
                              //     DateTime.now().millisecondsSinceEpoch.toString();
                              dataBaseRef.child(ids).update({
                                'Role': role.toString(),
                                'Name': fullname.text.toString(),
                                'Email': FirebaseAuth
                                    .instance.currentUser!.email
                                    .toString(),
                                'Phone': phoneno.text.toString(),
                                'Address': addresss.text.toString(),
                                'UserID': ids.toString(),
                                'image': uploadedImageUrl.toString(),
                              }).then((value) {
                                Utils().toastMessage('Profile Updated');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ProfileTwo()));
                                setState(() {
                                  loading = false;
                                });
                              }).onError((error, stackTrace) {
                                Utils().toastMessage(error.toString());
                                setState(() {
                                  loading = false;
                                });
                              });
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
