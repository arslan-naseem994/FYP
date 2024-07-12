import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/bottom.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/user/auth/forgot_password.dart';
import 'package:sahulatapp/admin/auth/login_with_phone_number.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/address_varification.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/first_signup.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/forgot_passwrod2.dart';
import 'package:sahulatapp/ui/serviceprovider/service_login_signup.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/user/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:sahulatapp/user/homebottom.dart';

class ServiceLoginScreen extends StatefulWidget {
  const ServiceLoginScreen({super.key});

  @override
  State<ServiceLoginScreen> createState() => _ServiceLoginScreenState();
}

class _ServiceLoginScreenState extends State<ServiceLoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref('Provider');
  bool passwordVisible = false;
  bool isEmailVerified = false;
  bool cancelResendEmail = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() {
        cancelResendEmail = false;
      });
      await Future.delayed(Duration(seconds: 5));
      setState(() {
        cancelResendEmail = true;
      });
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  void _setingVerification(String uids) {
    final verificationupdate =
        FirebaseDatabase.instance.ref('Provider').child(uids);
    verificationupdate.update({'verified': 'true'});
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) async {
      if (value.user!.emailVerified) {
        String userId = value.user!.uid;
        final userRef = FirebaseDatabase.instance
            .ref('Provider')
            .child(userId)
            .child('Role');
        userRef.once().then((DatabaseEvent event) {
          String roles = 'empty';
          DataSnapshot snapshot = event.snapshot;
          roles = snapshot.value.toString();

          return roles;
        }).then((roles) {
          if (roles == "provider") {
            ///////////////////////////////////////////////////////////
            final userRef = FirebaseDatabase.instance
                .ref('Provider')
                .child(userId)
                .child('AddressVerification');
            userRef.once().then((DatabaseEvent event) {
              String verfication = 'empty';
              DataSnapshot snapshot = event.snapshot;
              verfication = snapshot.value.toString();

              return verfication;
            }).then((verfication) {
              if (verfication == "null") {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const AddressVarificationScreen()));
                final snackBar = SnackBar(
                  content: Text('Please Insert Verification Code'),
                  duration: Duration(seconds: 3),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              } else {
                _setingVerification(userId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreens()));
              }
              // else {
              //   Utils().toastMessage(value.user!.email.toString());
              // }
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

            /////////////////////////////////////////////////////////////

            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => const HomeScreens()));
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => const AddressVarificationScreen()));
            // final snackBar = SnackBar(
            //   content: Text('Please Insert Verification Code'),
            //   duration: Duration(seconds: 3),
            // );
            // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            final snackBar = SnackBar(
              content: Text('Invalid User'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          // else {
          //   Utils().toastMessage(value.user!.email.toString());
          // }
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
      } else {
        setState(() {
          isEmailVerified = true;
        });
        final snackBar = SnackBar(
          content: Text('Please verify your email before logging in.'),
          duration: Duration(seconds: 3),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        setState(() {
          loading = false;
        });
      }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
    // onError((error, stackTrace) {
    //   debugPrint(error.toString());
    //   Utils().toastMessage(error.toString());
    //   setState(() {
    //     loading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var begin = const Offset(1.0, 0.0);
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
              return const ServiceLoginReg();
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
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: LeftAnimation(
                    child: Image.asset(
                      "assets/images/main_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 75),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopAnimation(
                        child: const Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 219, 99, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
                      TopAnimation(
                        child: Image.asset(
                          'assets/images/servicelogin.png',
                          height: 180,
                        ),
                      ),
                      // SizedBox(height: size.height * 0.02),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            LeftAnimation(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 219, 99, 255)),
                                cursorColor: Color.fromARGB(255, 219, 99, 255),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 219, 99, 255)
                                      .withOpacity(.08),
                                  hintText: 'Email',
                                  // helperText:
                                  //     'Enter email as e.g john@gmail.com',
                                  prefixIcon: const Icon(
                                    Icons.alternate_email,
                                    color: Color.fromARGB(255, 219, 99, 255),
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255)
                                          .withOpacity(.8)),
                                  labelText: 'Enter Email',
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
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter Email';
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
                                keyboardType: TextInputType.name,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 219, 99, 255)),
                                cursorColor: Color.fromARGB(255, 219, 99, 255),
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
                                      color: Color.fromARGB(255, 219, 99, 255),
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
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen2(),
                                ),
                              );
                            },
                            child: RightAnimation(
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BottomAnimation(
                        child: RoundButton(
                          width: 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xff9749ff),
                          ),
                          title: 'Login',
                          loading: loading,
                          ontap: () {
                            if (_formkey.currentState!.validate()) {
                              login();
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LeftAnimation(
                              child: const Text("Don't have an account?")),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration:
                                        const Duration(milliseconds: 1000),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      var begin = const Offset(1.0, 0.0);
                                      var end = Offset.zero;
                                      var curve = Curves.ease;

                                      var tween = Tween(begin: begin, end: end)
                                          .chain(CurveTween(curve: curve));
                                      return SlideTransition(
                                        position: animation.drive(tween),
                                        child: child,
                                      );
                                    },
                                    pageBuilder: (context, animation,
                                        secondaryAnimation) {
                                      return FirstServiceSignUpScreen();
                                    },
                                  ),
                                );

                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             const SignUpScreen()));
                              },
                              child: RightAnimation(
                                child: const Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 219, 99, 255),
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (isEmailVerified)
                        ElevatedButton(
                          onPressed: () {
                            if (cancelResendEmail == true) {
                              sendVerificationEmail();
                            }
                          },
                          child: Text('Resend Email'),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: RightAnimation(
                    child: Image.asset(
                      "assets/images/sslogin_bottom.png",
                      width: size.width * 0.4,
                    ),
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

/*Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        helperText: 'Enter email as e.g john@gmail.com',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock_open),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              RoundButton(
                title: 'Login',
                loading: loading,
                ontap: () {
                  if (_formkey.currentState!.validate()) {
                    login();
                  }
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpScreen()));
                      },
                      child: const Text(
                        'Sign up',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginWithPhoneNumber()));
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.black)),
                  height: 50,
                  child: const Center(child: Text('Login with Phone')),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PostScreen()));
                },
                child: Container(
                  height: 50,
                  width: 59,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      "ShortCut",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ), */