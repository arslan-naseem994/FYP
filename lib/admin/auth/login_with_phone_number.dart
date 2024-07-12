import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/auth/verify_code.dart';
import 'package:sahulatapp/utils/utils.dart';

import '../../widgets/round_widget.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({super.key});

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  bool loading = false;
  final phoneNumberController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          color: Colors.white,
          height: size.height,
          width: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_top.png',
                  width: size.width * 0.5,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 200),
                    child: Column(
                      children: [
                        const Text(
                          "LOGIN",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 29),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        TextFormField(
                          maxLength: 13,
                          style: const TextStyle(color: Colors.blueAccent),
                          cursorColor: Colors.blueAccent,
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            fillColor: Colors.blueAccent.withOpacity(.07),
                            filled: true,
                            hintText: '+92 123 4567890',
                            labelStyle: TextStyle(
                                color: Colors.blueAccent.withOpacity(.8)),
                            labelText: 'Enter Phone#',
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueAccent.shade400),
                                borderRadius: BorderRadius.circular(30)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0),
                                        topLeft: const Radius.circular(0))),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(30)
                                    .copyWith(
                                        bottomRight: const Radius.circular(0),
                                        topLeft: const Radius.circular(0))),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        RoundButton(
                            width: 450,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.deepPurple),
                            title: 'Login',
                            loading: loading,
                            ontap: () {
                              setState(() {
                                loading = true;
                              });
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
                                  codeSent:
                                      (String verificationid, int? token) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyCodeScreen(
                                                    verificationid:
                                                        verificationid)));
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
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: Image.asset(
                  'assets/images/main_bottom.png',
                  width: size.width * 0.3,
                ),
              ),
            ],
          ),
        ));
  }
}
