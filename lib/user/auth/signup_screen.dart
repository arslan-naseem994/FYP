import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/bottom.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/right.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/widgets/round_widget.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sahulatapp/utils/utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sahulatapp/ui/posts/user_login_signup.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final dataBaseRef = FirebaseDatabase.instance.ref('User');
  final dataBaseRef2 = FirebaseDatabase.instance.ref('Allusers');
  bool passwordVisible = false;

// new

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });

    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      String userId = value.user!.uid;

      // Save user data without email verification
      dataBaseRef.child(userId).set({
        'Role': 'user',
        'Name': '',
        'image': '',
        'verified': 'false',
      });
      dataBaseRef2.child(userId).set({
        'Role': 'user',
        'UserIDs': userId.toString(),
      });

      // Send email verification
      value.user!.sendEmailVerification().then((_) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        final snackBar = SnackBar(
          content: Text(
              'Account Created. Please check your email for verification.'),
          duration: Duration(seconds: 3),
        );
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
            // resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: LeftAnimation(
                  child: Image.asset(
                    "assets/images/signup_top.png",
                    width: size.width * 0.35,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, right: 30, bottom: 75),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TopAnimation(
                      child: const Text(
                        "SIGNUP",
                        style: TextStyle(
                            color: Color.fromARGB(255, 219, 99, 255),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TopAnimation(
                      child: SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: size.height * 0.24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          LeftAnimation(
                            child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 219, 99, 255)),
                              cursorColor: Color.fromARGB(255, 219, 99, 255),
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
                                      color: Color.fromARGB(255, 219, 99, 255)),
                                  borderRadius:
                                      BorderRadius.circular(30).copyWith(
                                    bottomRight: const Radius.circular(0),
                                    topLeft: const Radius.circular(0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color.fromARGB(255, 219, 99, 255)),
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
                                final alphabeticCharacters =
                                    value.replaceAll(RegExp(r'[^a-zA-Z]'), '');
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
                                        color:
                                            Color.fromARGB(255, 219, 99, 255)),
                                    borderRadius: BorderRadius.circular(30)
                                        .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0))),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 219, 99, 255)),
                                    borderRadius: BorderRadius.circular(30)
                                        .copyWith(
                                            bottomRight:
                                                const Radius.circular(0),
                                            topLeft: const Radius.circular(0))),
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
                      height: 30,
                    ),
                    BottomAnimation(
                      child: RoundButton(
                          width: 450,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xff9749ff),
                          ),
                          title: 'Sign up',
                          loading: loading,
                          ontap: () {
                            if (_formkey.currentState!.validate()) {
                              signUp();
                            }
                          }),
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
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return const LoginScreen();
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
                                    color: Color.fromARGB(255, 219, 99, 255),
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
                child: LeftAnimation(
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
}
