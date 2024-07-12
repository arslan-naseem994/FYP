import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/user/auth/forgot_password.dart';
import 'package:sahulatapp/admin/auth/login_with_phone_number.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/user/auth/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:sahulatapp/user/homebottom.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahulatapp/ui/posts/user_login_signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final databaseReference = FirebaseDatabase.instance.ref('User');
  bool passwordVisible = false;
  bool isEmailVerified = false;
  bool cancelResendEmail = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _setingVerification(String uids) {
    final verificationupdate =
        FirebaseDatabase.instance.ref('User').child(uids);
    verificationupdate.update({'verified': 'true'});
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

  void login() {
    setState(() {
      loading = true;
    });

    _auth
        .signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text.toString())
        .then((value) {
      if (value.user!.emailVerified) {
        String userId = value.user!.uid;
        _setingVerification(userId);
        final userRef =
            FirebaseDatabase.instance.ref('User').child(userId).child('Role');
        userRef.once().then((DatabaseEvent event) {
          String roles = 'empty';
          DataSnapshot snapshot = event.snapshot;
          roles = snapshot.value.toString();

          return roles;
        }).then((roles) {
          if (roles == "user") {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PostScreen()));
            final snackBar = SnackBar(
              content: Text('Successfully Login'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
              return const LoginRegScreen();
            },
          ),
        );
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
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
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 75),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TopAnimation(
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                              color: Color.fromARGB(255, 219, 99, 255),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: size.height * 0.03),
                      TopAnimation(
                        child: SvgPicture.asset(
                          "assets/icons/login.svg",
                          height: size.height * 0.22,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            RightAnimation(
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: emailController,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 219, 99, 255)),
                                cursorColor: Color.fromARGB(255, 219, 99, 255),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 219, 99, 255)
                                      .withOpacity(.04),
                                  hintText: 'Email',
                                  // helperText:
                                  //     'Enter email as e.g john@gmail.com',
                                  prefixIcon: const Icon(Icons.alternate_email,
                                      color: Color.fromARGB(255, 219, 99, 255)),
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
                            LeftAnimation(
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
                                  builder: (context) => ForgotPasswordScreen(),
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
                            if (_formkey.currentState!.validate()) {
                              login();
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
                                      return const SignUpScreen();
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
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 219, 99, 255)),
                                ),
                              )),
                        ],
                      ),
                      if (isEmailVerified)
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
