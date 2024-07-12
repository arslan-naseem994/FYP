import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/admin/ui/home_screen.dart';
import '../../utils/utils.dart';
import '../../widgets/round_widget.dart';

class VerifyCodeScreen extends StatefulWidget {
  final String verificationid;
  const VerifyCodeScreen({super.key, required this.verificationid});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
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
                  "OTP",
                  style: TextStyle(
                      color: Color.fromARGB(255, 219, 99, 255),
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              TopAnimation(
                child: Image.asset(
                  "assets/images/otp.jpg",
                  height: size.height * 0.30,
                ),
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    TopAnimation(
                      child: TextFormField(
                        maxLength: 6,
                        keyboardType: TextInputType.phone,
                        controller: verificationCodeController,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 219, 99, 255)),
                        cursorColor: Color.fromARGB(255, 219, 99, 255),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color.fromARGB(255, 219, 99, 255)
                              .withOpacity(.08),
                          hintText: '6 digit code',
                          counterText: '',

                          // helperText:
                          //     'Enter email as e.g john@gmail.com',
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Color.fromARGB(255, 219, 99, 255),
                          ),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 219, 99, 255)
                                  .withOpacity(.8)),
                          labelText: 'Enter OTP',
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
                            return 'Enter OTP';
                          }

                          if (value.length < 6) {
                            return 'Value must be at least 6';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    TopAnimation(
                        child: RoundButton(
                      width: 450,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xff9749ff),
                      ),
                      title: 'Verify',
                      loading: loading,
                      ontap: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });

                          final credential = PhoneAuthProvider.credential(
                            verificationId: widget.verificationid,
                            smsCode: verificationCodeController.text.toString(),
                          );

                          try {
                            // Await the sign-in attempt to get the result
                            await auth.signInWithCredential(credential);

                            // If sign-in is successful, navigate to AdminDashboardScreen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminDashboardScreen()),
                            );
                          } catch (e) {
                            setState(() {
                              loading = false;
                            });

                            // Handle sign-in failure here, for example, show a toast message
                            Utils().toastMessage(e.toString());
                          }
                        }
                      },
                    )

                        // child: ElevatedButton(
                        //   onPressed: () {
                        //     if (_isButtonEnabled22 &&
                        //         _formkey.currentState!.validate()) {
                        //       _resetPassword(context);
                        //     }
                        //   },
                        //   style: ElevatedButton.styleFrom(
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(20)),

                        //     backgroundColor: _isButtonEnabled22
                        //         ? Color(0xff9749ff)
                        //         : Colors
                        //             .grey, // deeppurple when enabled, grey when disabled
                        //   ),
                        //   child: Text("Reset Password"),
                        // ),
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
