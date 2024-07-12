import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/user/auth/login_screen.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/service_login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool _isButtonEnabled22 = true;
  final int _countdownDuration2 = 5; // 1 minute in seconds
  Timer? _countdownTimer2;
  int _remainingSeconds22 = 0;
  final String _prefs2KeyremainingSeconds2 = 'remainingSeconds2';
  final String _prefs2KeyisButtonEnabled2 = 'isButtonEnabled2';
  SharedPreferences? _prefs2;
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _loadTimerState();
  }

  @override
  void dispose() {
    _countdownTimer2?.cancel();
    _saveTimerState();
    super.dispose();
  }

  Future<void> _loadTimerState() async {
    _prefs2 = await SharedPreferences.getInstance();
    setState(() {
      _remainingSeconds22 = _prefs2?.getInt(_prefs2KeyremainingSeconds2) ?? 0;
      _isButtonEnabled22 = _prefs2?.getBool(_prefs2KeyisButtonEnabled2) ?? true;
    });

    // Resume the countdown timer if it was active
    if (!_isButtonEnabled22) {
      _startCountdownTimer();
    }
  }

  Future<void> _saveTimerState() async {
    await _prefs2?.setInt(_prefs2KeyremainingSeconds2, _remainingSeconds22);
    await _prefs2?.setBool(_prefs2KeyisButtonEnabled2, _isButtonEnabled22);
  }

  void _startCountdownTimer() {
    _countdownTimer2 = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds22--;
      });
      if (_remainingSeconds22 <= 0) {
        timer.cancel();
        setState(() {
          _isButtonEnabled22 = true;
        });
      }
    });
  }

  Future<void> _resetPassword(BuildContext context) async {
    setState(() {
      _isButtonEnabled22 = false;
      _remainingSeconds22 = _countdownDuration2;
    });

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Password Reset Email Sent"),
          content: Text("Please check your email to reset your password."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          backgroundColor: Colors.grey.shade100,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Error"),
          content: Text("Failed to send password reset email."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        ),
      );
    }

    _startCountdownTimer();
  }

  String _formatRemainingTime() {
    int minutes = _remainingSeconds22 ~/ 60;
    int seconds = _remainingSeconds22 % 60;
    String formattedTime =
        DateFormat('mm:ss').format(DateTime(0, 1, 1, 0, minutes, seconds));
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 28, left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff9749ff),
                  ),
                ),
              ),
            ],
          ),
          // title: Text(
          //   "Forgot Password",
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     color: Color(0xff9749ff),
          //   ),
          // ),
          elevation: 0,
          // automaticallyImplyLeading: false,
          // shadowColor: Color.fromARGB(255, 219, 99, 255),
          // bottomOpacity: 10,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TopAnimation(
                child: const Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: Color.fromARGB(255, 219, 99, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              TopAnimation(
                child: Image.asset(
                  "assets/images/forgotpass.jpg",
                  height: size.height * 0.30,
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TopAnimation(
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
                                  color: Color.fromARGB(255, 219, 99, 255)),
                              borderRadius: BorderRadius.circular(30).copyWith(
                                  bottomRight: const Radius.circular(0),
                                  topLeft: const Radius.circular(0))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 219, 99, 255)),
                              borderRadius: BorderRadius.circular(30).copyWith(
                                  bottomRight: const Radius.circular(0),
                                  topLeft: const Radius.circular(0))),
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
                    SizedBox(height: 16),
                    TopAnimation(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_isButtonEnabled22 &&
                              _formkey.currentState!.validate()) {
                            _resetPassword(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),

                          backgroundColor: _isButtonEnabled22
                              ? Color(0xff9749ff)
                              : Colors
                                  .grey, // deeppurple when enabled, grey when disabled
                        ),
                        child: Text("Reset Password"),
                      ),
                    ),
                    SizedBox(height: 16),
                    if (!_isButtonEnabled22)
                      Text(
                        "Please wait ${_formatRemainingTime()} before trying again.",
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
