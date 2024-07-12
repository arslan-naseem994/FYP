import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/admin/auth/verify_code.dart';
import 'package:sahulatapp/ui/serviceprovider/user_and_service.dart';
import 'package:sahulatapp/user/auth/signup_screen.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahulatapp/ui/posts/user_login_signup.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final phoneNumberController = TextEditingController();
  final codeController = TextEditingController();
  final databaseReference = FirebaseDatabase.instance.ref('User');
  bool passwordVisible = false;
  final auth = FirebaseAuth.instance;
  final ref2 = FirebaseDatabase.instance.ref('Admin').child('Phone');
  final ref = FirebaseDatabase.instance.ref('Admin').child('Key');

  @override
  void dispose() {
    super.dispose();
    phoneNumberController.dispose();
    codeController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void login(String id, String id2) {
    setState(() {
      loading = true;
    });

    ref.once().then((DatabaseEvent event) {
      String key = 'empty';
      DataSnapshot snapshot = event.snapshot;
      key = snapshot.value.toString();

      return key;
    }).then((key) {
      if (key == id) {
        ///////////////////////////////
        ///

        ref2.once().then((DatabaseEvent event) {
          String phone = 'empty';
          DataSnapshot snapshot = event.snapshot;
          phone = snapshot.value.toString();

          return phone;
        }).then((phone) {
          if (phone == id2) {
            ///////////////////////////////
            auth.verifyPhoneNumber(
                phoneNumber: phoneNumberController.text,
                verificationCompleted: (_) {
                  setState(() {
                    loading = false;
                  });
                },
                verificationFailed: (e) {
                  setState(() {
                    loading = false;
                  });
                  Utils().toastMessage(e.toString());
                },
                codeSent: (String verificationid, int? token) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VerifyCodeScreen(
                              verificationid: verificationid)));
                  setState(() {
                    loading = false;
                  });
                },
                codeAutoRetrievalTimeout: (e) {
                  Utils().toastMessage(e.toString());
                  setState(() {
                    loading = false;
                  });
                });

            ///////////////////////////////////
          } else {
            final snackBar = SnackBar(
              content: Text('Invalid User'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          setState(() {
            loading = false;
          });
        }).onError((error, stackTrace) {
          debugPrint(error.toString());
          Utils().toastMessage(error.toString());
          setState(() {
            loading = false;
          });
        });

        ///
        ///
        ///
        ///
        ///////////////////////////////////
      } else {
        final snackBar = SnackBar(
          content: Text('Invalid User'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
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
            context, MaterialPageRoute(builder: (context) => UserService()));
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Stack(
              // alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                    "assets/images/main_top.png",
                    width: size.width * 0.3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 120,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TopAnimation(
                        child: const Text(
                          "ADMIN LOGIN",
                          style: TextStyle(
                              color: Color.fromARGB(255, 219, 99, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      Image(
                        image: AssetImage("assets/images/admin.jpg"),
                      ),
                      // TopAnimation(
                      //   child: SvgPicture.asset(
                      //     "assets/icons/login.svg",
                      //     height: size.height * 0.22,
                      //   ),
                      // ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            RightAnimation(
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9+]')),
                                ],
                                maxLength: 13,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 219, 99, 255),
                                ),
                                cursorColor: Color.fromARGB(255, 219, 99, 255),
                                controller: phoneNumberController,
                                decoration: InputDecoration(
                                  // prefixText: '+92',
                                  counterText: '',
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 219, 99, 255)
                                      .withOpacity(.04),

                                  // helperText:
                                  //     'Enter email as e.g john@gmail.com',
                                  prefixIcon: const Icon(Icons.phone,
                                      color: Color.fromARGB(255, 219, 99, 255)),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255)
                                          .withOpacity(.8)),
                                  labelText: 'Enter Phone#',
                                  hintText: '+92######',
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
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
                                // onChanged: (value) {
                                //   // Update the controller while excluding the plus sign
                                //   phoneNumberController.text =
                                //       '+' + value.replaceAll('+', '');
                                // },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Phone Number';
                                  }
                                  if (value.length < 13) {
                                    return 'Phone Number must be at least 13 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            LeftAnimation(
                              child: TextFormField(
                                maxLength: 8,
                                keyboardType: TextInputType.phone,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9]')),
                                ],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 219, 99, 255)),
                                cursorColor: Color.fromARGB(255, 219, 99, 255),
                                controller: codeController,
                                obscureText: passwordVisible,
                                decoration: InputDecoration(
                                  counterText: '',
                                  fillColor: Color.fromARGB(255, 219, 99, 255)
                                      .withOpacity(.07),
                                  filled: true,
                                  // hintText: '8 Digit Code',
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
                                      color: Color.fromARGB(255, 219, 99, 255),
                                      passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255)
                                          .withOpacity(.8)),
                                  labelText: 'Enter 8 Digit Code',
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
                                    return 'Enter Code';
                                  }
                                  if (value.length < 8) {
                                    return 'Code must be at least 8 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      TopAnimation(
                        child: RoundButton(
                          width: 450,
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(255, 208, 184, 255),
                                spreadRadius: 0,
                                blurRadius: 13,
                                offset: Offset(0, 13),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff9749ff),
                          ),
                          title: 'Login',
                          loading: loading,
                          ontap: () {
                            // String currentText =
                            //     "+92${phoneNumberController.text}";
                            // debugPrint("Hi $currentText");
                            if (_formkey.currentState!.validate()) {
                              login(codeController.text.toString(),
                                  phoneNumberController.text.toString());
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // InkWell(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) =>
                      //                 const LoginWithPhoneNumber()));
                      //   },
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //         borderRadius: BorderRadius.circular(50),
                      //         border: Border.all(color: Colors.black)),
                      //     height: 50,
                      //     child:
                      //         const Center(child: Text('Login with Phone')),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image.asset(
                    "assets/images/sslogin_bottom.png",
                    width: size.width * 0.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
