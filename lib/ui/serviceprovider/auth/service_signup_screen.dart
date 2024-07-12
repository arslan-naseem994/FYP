import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/bottom.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/first_signup.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahulatapp/ui/posts/user_login_signup.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/service_login_screen.dart';

import '../service_login_signup.dart';
import 'dart:math';

class ServiceSignUpScreen extends StatefulWidget {
  final String name;
  final String address;
  final String cnic;
  final String phone;
  final String expertises;
  final String img1;
  final String img2;
  final String img3;
  const ServiceSignUpScreen({
    super.key,
    required this.name,
    required this.address,
    required this.cnic,
    required this.phone,
    required this.expertises,
    required this.img1,
    required this.img2,
    required this.img3,
  });

  @override
  State<ServiceSignUpScreen> createState() => _ServiceSignUpScreenState();
}

class _ServiceSignUpScreenState extends State<ServiceSignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dataBaseRef = FirebaseDatabase.instance.ref('Provider');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('Allusers');
  final dataBaseRef3 = FirebaseDatabase.instance.ref('AddressVarification');
  bool passwordVisible = false;

  int generateRandomNumber() {
    Random random = Random();
    return random.nextInt(90000) +
        10000; // Generates a number between 10000 and 99999
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp(
    String name,
    String address,
    String cnic,
    String phone,
    String expertiseee,
    String img1,
    String img2,
    String img3,
  ) {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      int number = generateRandomNumber();
      String userId = value.user!.uid;
      dataBaseRef.child(userId).set({
        'Role': 'provider',
        'email': emailController.text.toString(),
        'Name': name.toString(),
        'Address': address.toString(),
        'CNIC': cnic.toString(),
        'Phone': phone.toString(),
        'Expertise': expertiseee.toString(),
        'UserID': userId.toString(),
        'AddressVerification': 'null',
        'IdCardFront': img1.toString(),
        'IdCardBack': img2.toString(),
        'commission': '0',
        'experience': '0',
        'image': img3.toString(),
        'rating': '0',
        //arslan made changes verified made comment
        // 'verify': 'null',
        'verified': 'false',
        'code': number.toString(),
      });
      //for restart app condition keep user login
      dataBaseRef2.child(userId).set({
        'Role': 'provider',
        'UserIDs': userId.toString(),
      });
      //address varification
      dataBaseRef3.child(userId).set({
        'RandomID': number.toString(),
        'Email': emailController.text.toString(),
        'Address': address.toString(),
        'UserIDs': userId.toString(),
        'Vattempts': 3,
      });
      value.user!.sendEmailVerification().then((_) {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => const ServiceLoginReg()),
        // );
        final snackBar = SnackBar(
          content: Text(
              'Account Created. Please check your email for verification.'),
          duration: Duration(seconds: 3),
        );
        showConfirmationScreen(context, 'Account Created');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          loading = false;
        });
      }).catchError((error) {
        Utils().toastMessage('Email verification failed: ${error.toString()}');
        setState(() {
          loading = false;
        });
      });
    }).catchError((error) {
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
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
              return FirstServiceSignUpScreen();
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
                        width: size.width * 0.3,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 85),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: TopAnimation(
                            child: const Text(
                              "Signup",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 219, 99, 255),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TopAnimation(
                          child: Image.asset('assets/images/sservicesignup.png',
                              height: 200),
                        ),
                        const SizedBox(height: 25),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              LeftAnimation(
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255)),
                                  cursorColor:
                                      Color.fromARGB(255, 219, 99, 255),
                                  controller: emailController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 219, 99, 255)
                                        .withOpacity(.08),
                                    hintText: 'Email',
                                    prefixIcon: const Icon(
                                      Icons.alternate_email,
                                      color: Color.fromARGB(255, 219, 99, 255),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255)
                                          .withOpacity(.8),
                                    ),
                                    labelText: 'Enter Email',
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      borderRadius:
                                          BorderRadius.circular(30).copyWith(
                                        bottomRight: const Radius.circular(0),
                                        topLeft: const Radius.circular(0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color.fromARGB(
                                              255, 219, 99, 255)),
                                      borderRadius:
                                          BorderRadius.circular(30).copyWith(
                                        bottomRight: const Radius.circular(0),
                                        topLeft: const Radius.circular(0),
                                      ),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Email';
                                    }
                                    // Check if the email is in the correct format
                                    if (!value.contains('@') ||
                                        !value.endsWith('@gmail.com')) {
                                      return 'Enter a valid Gmail address';
                                    }
                                    // Check if the email has at least 4 alphabetic characters
                                    final alphabeticCharacters = value
                                        .replaceAll(RegExp(r'[^a-zA-Z]'), '');
                                    if (alphabeticCharacters.length < 4) {
                                      return 'Email must have at least 4 alphabetic characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              RightAnimation(
                                child: TextFormField(
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255)),
                                  cursorColor:
                                      Color.fromARGB(255, 219, 99, 255),
                                  controller: passwordController,
                                  obscureText: passwordVisible,
                                  decoration: InputDecoration(
                                    fillColor: Color.fromARGB(255, 219, 99, 255)
                                        .withOpacity(.07),
                                    filled: true,
                                    hintText: 'Password',
                                    prefixIcon: const Icon(
                                      Icons.lock_open,
                                      color: Color.fromARGB(255, 219, 99, 255),
                                    ),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          passwordVisible = !passwordVisible;
                                        });
                                      },
                                      child: Icon(
                                        color:
                                            Color.fromARGB(255, 219, 99, 255),
                                        passwordVisible
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                    ),
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 219, 99, 255)
                                            .withOpacity(.8)),
                                    labelText: 'Enter Password',
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 99, 255)),
                                        borderRadius: BorderRadius.circular(30)
                                            .copyWith(
                                                bottomRight:
                                                    const Radius.circular(0),
                                                topLeft:
                                                    const Radius.circular(0))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 219, 99, 255)),
                                        borderRadius: BorderRadius.circular(30)
                                            .copyWith(
                                                bottomRight:
                                                    const Radius.circular(0),
                                                topLeft:
                                                    const Radius.circular(0))),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Password';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: () {
                            if (_formkey.currentState!.validate()) {
                              signUp(
                                widget.name.toString(),
                                widget.address.toString(),
                                widget.cnic.toString(),
                                widget.phone.toString(),
                                widget.expertises.toString(),
                                widget.img1.toString(),
                                widget.img2.toString(),
                                widget.img3.toString(),
                              );
                            }
                          },
                          child: BottomAnimation(
                            child: Container(
                              width: 450,
                              height: 50,
                              decoration: BoxDecoration(
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 208, 184, 255),
                                    spreadRadius: 0,
                                    blurRadius: 10,
                                    offset: Offset(0, 13),
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xff9749ff),
                              ),
                              child: Center(
                                  child: Text(
                                "Signup",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LeftAnimation(
                                child: const Text("Already have an account?")),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      transitionDuration:
                                          Duration(milliseconds: 1000),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        var begin = Offset(1.0, 0.0);
                                        var end = Offset.zero;
                                        var curve = Curves.ease;

                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
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
                                        color:
                                            Color.fromARGB(255, 219, 99, 255),
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: RightAnimation(
                      child: Image.asset(
                        "assets/images/main_bottom.png",
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

  void showConfirmationScreen(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 45,
                  width: 300,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: const Center(
                      child: Text(
                    'Address Varification',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )),
                ),
                Column(
                  // 1st column
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "For Security Purpose 5-Digit code sent\n to your home address for login into account\n",
                      style: TextStyle(fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 238, 237, 237),
                            foregroundColor: const Color.fromARGB(255, 50, 0,
                                119), // Change the button text color
                            textStyle: const TextStyle(
                                fontSize: 15), // Change the button text size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20), // Change button border radius
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ServiceLoginReg()));
                          },
                          child: Text('Okay'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                  ], // 1st column bracket
                )
              ],
            ),
          ],
        );
      },
    );

    // Future.delayed(const Duration(seconds: 10), () {
    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => const ServiceLoginReg()));
    // });
  }
}
