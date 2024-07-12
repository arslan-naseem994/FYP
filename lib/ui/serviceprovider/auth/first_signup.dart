import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/Animation/bottom.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/service_signup_screen.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahulatapp/ui/posts/user_login_signup.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:sahulatapp/ui/serviceprovider/auth/service_login_screen.dart';

import '../service_login_signup.dart';

class FirstServiceSignUpScreen extends StatefulWidget {
  const FirstServiceSignUpScreen({super.key});

  @override
  State<FirstServiceSignUpScreen> createState() =>
      _FirstServiceSignUpScreenState();
}

class _FirstServiceSignUpScreenState extends State<FirstServiceSignUpScreen> {
  final _formkey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final cnicController = TextEditingController();
  final phoneController = TextEditingController();
  String? selectedOption; // Make selectedProfession nullable

  File? _selectedImage;
  UploadTask? _uploadTask;
  bool uploadingImage = false;
  bool uploadingImage2 = false;
  bool uploadingImage3 = false;
  double uploadProgress = 0.0;
  String? uploadedImageUrl;
  String? uploadedImageUrl2;
  String? uploadedImageUrl3;

  String role = 'user';
  String savedName = '';
  String savedAddress = '';
  String savedCNIC = '';
  String savedPhone = '';

  void loadSavedData() {
    nameController.text = savedName;
    addressController.text = savedAddress;
    cnicController.text = savedCNIC;
    phoneController.text = savedPhone;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    addressController.dispose();
    cnicController.dispose();
    phoneController.dispose();
    loadSavedData();
  }

  void saveFormData() {
    savedName = nameController.text;
    savedAddress = addressController.text;
    savedCNIC = cnicController.text;
    savedPhone = phoneController.text;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = Offset(1.0, 0.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
            pageBuilder: (context, animation, secondaryAnimation) {
              return ServiceLoginReg();
            },
          ),
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: LeftAnimation(
                      child: Image.asset(
                        "assets/images/main_top.png",
                        width: size.width * 0.22,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                            ),
                            SizedBox(height: 10),
                            // Image.asset('assets/images/sservicesignup.png',
                            //     height: 100),
                            const SizedBox(height: 40),
                            Form(
                              key: _formkey,
                              child: Column(
                                children: [
                                  RightAnimation(
                                    child: TextFormField(
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      cursorColor:
                                          Color.fromARGB(255, 219, 99, 255),
                                      controller: nameController,
                                      maxLength: 40,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp(
                                            r'[A-Za-z ]')), // Allow alphabetic characters and spaces
                                      ],
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 219, 99, 255)
                                                .withOpacity(.08),
                                        hintText: 'Name',
                                        counterText: '',
                                        prefixIcon: const Icon(
                                          Icons.perm_identity,
                                          color:
                                              Color.fromARGB(255, 219, 99, 255),
                                        ),
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 219, 99, 255)
                                                  .withOpacity(.8),
                                        ),
                                        labelText: 'Enter Name',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Name';
                                        }

                                        if (!RegExp(r'^[a-zA-Z\s]+$')
                                            .hasMatch(value)) {
                                          return 'Name should only contain alphabets and spaces';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RightAnimation(
                                    child: TextFormField(
                                      maxLength: 40,
                                      keyboardType: TextInputType.emailAddress,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      cursorColor:
                                          Color.fromARGB(255, 219, 99, 255),
                                      controller: addressController,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 219, 99, 255)
                                                .withOpacity(.08),
                                        hintText: 'Address',
                                        prefixIcon: const Icon(
                                          Icons.location_city,
                                          color:
                                              Color.fromARGB(255, 219, 99, 255),
                                        ),
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 219, 99, 255)
                                                  .withOpacity(.8),
                                        ),
                                        labelText: 'Enter Address',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Address';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RightAnimation(
                                    child: TextFormField(
                                      maxLength: 13,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .digitsOnly, // Only allow numeric input
                                      ],
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      cursorColor:
                                          Color.fromARGB(255, 219, 99, 255),
                                      controller: cnicController,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 219, 99, 255)
                                                .withOpacity(.08),
                                        hintText: 'CNIC',
                                        prefixIcon: const Icon(
                                          Icons.numbers,
                                          color:
                                              Color.fromARGB(255, 219, 99, 255),
                                        ),
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 219, 99, 255)
                                                  .withOpacity(.8),
                                        ),
                                        labelText: 'Enter CNIC',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter CNIC NUMBER';
                                        }
                                        if (!RegExp(r'^\d{13}$')
                                            .hasMatch(value)) {
                                          return 'Input should be 13 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  RightAnimation(
                                    child: TextFormField(
                                      maxLength: 10,
                                      maxLengthEnforcement:
                                          MaxLengthEnforcement.enforced,
                                      inputFormatters: [
                                        FilteringTextInputFormatter
                                            .digitsOnly, // Only allow numeric input
                                      ],
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      cursorColor:
                                          Color.fromARGB(255, 219, 99, 255),
                                      controller: phoneController,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        prefixText: "+92",
                                        filled: true,
                                        fillColor:
                                            Color.fromARGB(255, 219, 99, 255)
                                                .withOpacity(.08),
                                        hintText: 'Phone Number',
                                        prefixIcon: const Icon(
                                          Icons.phone,
                                          color:
                                              Color.fromARGB(255, 219, 99, 255),
                                        ),
                                        labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 219, 99, 255)
                                                  .withOpacity(.8),
                                        ),
                                        labelText: 'Enter Phone#',
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Color.fromARGB(
                                                  255, 219, 99, 255)),
                                          borderRadius:
                                              BorderRadius.circular(30)
                                                  .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Enter Phone#';
                                        }

                                        if (!RegExp(r'^\d{10}$')
                                            .hasMatch(value)) {
                                          return 'Input should be 10 digits';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  DropdownButtonFormField<String>(
                                    value: selectedOption,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedOption = newValue!;
                                      });
                                    },
                                    items: <String>[
                                      'Plumber',
                                      'Electrician',
                                      'Cleaner',
                                      'HVAC Technician'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      labelText: 'Expertise',
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select an option';
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 20),
                            //id card 1
                            Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: uploadedImageUrl != null
                                        ? Row(
                                            children: [
                                              Icon(Icons.verified),
                                              SizedBox(width: 2),
                                              LeftAnimation(
                                                child: Text("ID CARD Front",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            219,
                                                            99,
                                                            255))),
                                              )
                                            ],
                                          )
                                        : LeftAnimation(
                                            child: Text("ID CARD Front",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 219, 99, 255))),
                                          )),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 4,
                                  child: RightAnimation(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff9749ff),
                                          elevation: 12,
                                          minimumSize: Size(270, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      onPressed: () async {
                                        ImagePicker imagePicker = ImagePicker();
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.camera);
                                        print('${file?.path}');
                                        if (file == null) return;

                                        setState(() {
                                          uploadingImage =
                                              true; // Set the flag to indicate image upload is in progress
                                        });

                                        Reference referenceRoot =
                                            FirebaseStorage.instance.ref();
                                        Reference referenceDirImages =
                                            referenceRoot.child(
                                                'images/${DateTime.now()}.png');

                                        try {
                                          UploadTask uploadTask =
                                              referenceDirImages.putFile(
                                                  File(file.path)); //put!
                                          uploadTask.snapshotEvents
                                              .listen((TaskSnapshot snapshot) {
                                            double progress =
                                                snapshot.bytesTransferred /
                                                    snapshot.totalBytes;
                                            setState(() {
                                              uploadProgress =
                                                  progress; // Update the upload progress
                                            });
                                          });
                                          await uploadTask;

                                          uploadedImageUrl =
                                              await referenceDirImages
                                                  .getDownloadURL();
                                        } catch (error) {
                                          // Handle the error appropriately
                                        }

                                        setState(() {
                                          uploadingImage =
                                              false; // Set the flag to indicate image upload is completed
                                        });
                                      },
                                      child: Text('Select'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),

                            //id card 2
                            Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: uploadedImageUrl2 != null
                                        ? Row(
                                            children: [
                                              Icon(Icons.verified),
                                              SizedBox(width: 2),
                                              LeftAnimation(
                                                child: Text(
                                                  "ID CARD Back",
                                                  style: TextStyle(
                                                      color: Color.fromARGB(
                                                          255, 219, 99, 255)),
                                                ),
                                              )
                                            ],
                                          )
                                        : LeftAnimation(
                                            child: Text("ID CARD Back",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 219, 99, 255))),
                                          )),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 4,
                                  child: RightAnimation(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff9749ff),
                                          elevation: 12,
                                          minimumSize: Size(270, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      onPressed: () async {
                                        ImagePicker imagePicker = ImagePicker();
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.camera);
                                        print('${file?.path}');
                                        if (file == null) return;

                                        setState(() {
                                          uploadingImage =
                                              true; // Set the flag to indicate image upload is in progress
                                        });

                                        Reference referenceRoot =
                                            FirebaseStorage.instance.ref();
                                        Reference referenceDirImages =
                                            referenceRoot.child(
                                                'images/${DateTime.now()}.png');

                                        try {
                                          UploadTask uploadTask =
                                              referenceDirImages.putFile(
                                                  File(file.path)); //put!
                                          uploadTask.snapshotEvents
                                              .listen((TaskSnapshot snapshot) {
                                            double progress =
                                                snapshot.bytesTransferred /
                                                    snapshot.totalBytes;
                                            setState(() {
                                              uploadProgress =
                                                  progress; // Update the upload progress
                                            });
                                          });
                                          await uploadTask;

                                          uploadedImageUrl2 =
                                              await referenceDirImages
                                                  .getDownloadURL();
                                        } catch (error) {
                                          // Handle the error appropriately
                                        }

                                        setState(() {
                                          uploadingImage =
                                              false; // Set the flag to indicate image upload is completed
                                        });
                                      },
                                      child: Text('Select'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            //Profile Picture
                            Row(
                              children: [
                                Expanded(
                                    flex: 6,
                                    child: uploadedImageUrl3 != null
                                        ? Row(
                                            children: [
                                              Icon(Icons.verified),
                                              SizedBox(width: 2),
                                              LeftAnimation(
                                                child: Text("Profile Picture",
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255,
                                                            219,
                                                            99,
                                                            255))),
                                              )
                                            ],
                                          )
                                        : LeftAnimation(
                                            child: Text("Profile Picture",
                                                style: TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 219, 99, 255))),
                                          )),
                                SizedBox(width: 20),
                                Expanded(
                                  flex: 4,
                                  child: RightAnimation(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xff9749ff),
                                          elevation: 12,
                                          minimumSize: Size(270, 30),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30))),
                                      onPressed: () async {
                                        ImagePicker imagePicker = ImagePicker();
                                        XFile? file =
                                            await imagePicker.pickImage(
                                                source: ImageSource.camera);
                                        print('${file?.path}');
                                        if (file == null) return;

                                        setState(() {
                                          uploadingImage3 =
                                              true; // Set the flag to indicate image upload is in progress
                                        });

                                        Reference referenceRoot =
                                            FirebaseStorage.instance.ref();
                                        Reference referenceDirImages =
                                            referenceRoot.child(
                                                'images/${DateTime.now()}.png');

                                        try {
                                          UploadTask uploadTask =
                                              referenceDirImages.putFile(
                                                  File(file.path)); //put!
                                          uploadTask.snapshotEvents
                                              .listen((TaskSnapshot snapshot) {
                                            double progress =
                                                snapshot.bytesTransferred /
                                                    snapshot.totalBytes;
                                            setState(() {
                                              uploadProgress =
                                                  progress; // Update the upload progress
                                            });
                                          });
                                          await uploadTask;

                                          uploadedImageUrl3 =
                                              await referenceDirImages
                                                  .getDownloadURL();
                                        } catch (error) {
                                          // Handle the error appropriately
                                        }

                                        setState(() {
                                          uploadingImage3 =
                                              false; // Set the flag to indicate image upload is completed
                                        });
                                      },
                                      child: Text('Select'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2),
                            SizedBox(height: 5),
                            if (uploadingImage ||
                                uploadingImage2 ||
                                uploadingImage3) // Display progress bar only when uploadingImage is true
                              Column(
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
                            // end
                            SizedBox(height: 15),
                            BottomAnimation(
                              child: RoundButton(
                                width: 450,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Color(0xff9749ff),
                                ),
                                title: 'Next',
                                ontap: () {
                                  if (_formkey.currentState!.validate()) {
                                    if (uploadedImageUrl == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please select ID Front image.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    if (uploadedImageUrl2 == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Please select ID Back image.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    if (uploadedImageUrl3 == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'Profile image not selected.'),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      return;
                                    }
                                    saveFormData();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ServiceSignUpScreen(
                                          name: nameController.text.toString(),
                                          address:
                                              addressController.text.toString(),
                                          cnic: cnicController.text.toString(),
                                          phone:
                                              phoneController.text.toString(),
                                          expertises: selectedOption.toString(),
                                          img1: uploadedImageUrl.toString(),
                                          img2: uploadedImageUrl2.toString(),
                                          img3: uploadedImageUrl3.toString(),
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                LeftAnimation(
                                    child:
                                        const Text("Already have an account?")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilder(
                                          transitionDuration:
                                              Duration(milliseconds: 1000),
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = Offset(1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            return SlideTransition(
                                              position: animation.drive(tween),
                                              child: child,
                                            );
                                          },
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return ServiceLoginScreen();
                                          },
                                        ),
                                      );

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             const LoginScreen()));
                                    },
                                    child: RightAnimation(
                                      child: const Text(
                                        'Login',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 219, 99, 255),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: RightAnimation(
                      child: Image.asset(
                        "assets/images/sslogin_bottom.png",
                        width: size.width * 0.2,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
