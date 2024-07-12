import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahulatapp/Animation/left.dart';
import 'package:sahulatapp/Animation/top.dart';
import 'package:sahulatapp/ui/serviceprovider/serviceprovider/UI/bottomnavigationbar.dart';
import 'package:sahulatapp/ui/serviceprovider/auth/service_login_screen.dart';
import 'package:sahulatapp/utils/utils.dart';

class AddressVarificationScreen extends StatefulWidget {
  const AddressVarificationScreen({super.key});

  @override
  State<AddressVarificationScreen> createState() =>
      _AddressVarificationScreenState();
}

class _AddressVarificationScreenState extends State<AddressVarificationScreen> {
  final auth = FirebaseAuth.instance;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final dataBaseRef = FirebaseDatabase.instance.ref('Provider');
  final dataBaseRef3 = FirebaseDatabase.instance.ref('AddressVarification');
  int attempts = 0;
  List<String> codeDigits = List.generate(5, (_) => '');
  List<TextEditingController> digitControllers =
      List.generate(5, (_) => TextEditingController());

  void updateCode(int index, String value) {
    setState(() {
      codeDigits[index] = value;
      if (value.isNotEmpty && index < 4) {
        FocusScope.of(context).nextFocus();
      }
    });
  }

  Future<void> _fetchAttemptsFromDatabase() async {
    final userRef = FirebaseDatabase.instance
        .ref('AddressVarification')
        .child(userId)
        .child('Vattempts');

    try {
      final userRef = FirebaseDatabase.instance
          .ref('AddressVarification')
          .child(userId)
          .child('Vattempts');

      userRef.once().then((DatabaseEvent event) {
        int Vattempts = 0;
        DataSnapshot snapshot = event.snapshot;
        Vattempts = snapshot.value as int; // Perform the type cast to 'int'

        return Vattempts;
      }).then((Vattempts) {
        setState(() {
          attempts = Vattempts;
        });
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
      });
    } catch (error) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    }
  }

  @override
  void initState() {
    _fetchAttemptsFromDatabase();
    super.initState();
  }

  void verifyCode() {
    String code = codeDigits.join();
    final userRef = FirebaseDatabase.instance
        .ref('AddressVarification')
        .child(userId)
        .child('RandomID');
    userRef.once().then((DatabaseEvent event) {
      String RandomID = 'empty';
      DataSnapshot snapshot = event.snapshot;
      RandomID = snapshot.value.toString();

      return RandomID;
    }).then((RandomID) {
///////////////////////////////////////////
///////////////////////////////////////////
      final userRef = FirebaseDatabase.instance
          .ref('AddressVarification')
          .child(userId)
          .child('Vattempts');

      userRef.once().then((DatabaseEvent event) {
        int Vattempts = 0;
        DataSnapshot snapshot = event.snapshot;
        Vattempts = snapshot.value as int; // Perform the type cast to 'int'

        return Vattempts;
      }).then((Vattempts) {
        if (Vattempts != 0) {
          Vattempts--;
          if (RandomID == code) {
            dataBaseRef
                .child(userId)
                .update({'AddressVerification': RandomID.toString()});
            ////////
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreens()),
            );
            final snackBar = SnackBar(
              content: Text('Welcome'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            //////////////////////////////////////////////////
            //////////////////////////////////////////////////
          } else {
            _fetchAttemptsFromDatabase();
            dataBaseRef3.child(userId).update({'Vattempts': Vattempts});
            final snackBar = SnackBar(
              content: Text('Invalid Code'),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
          //////////////////////////////
        } else {
          final snackBar = SnackBar(
            content: Text('You have exceeded the maximum number of attempts'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }).onError((error, stackTrace) {
        debugPrint(error.toString());
        Utils().toastMessage(error.toString());
      });

///////////////////////////////

      // else {
      //   Utils().toastMessage(value.user!.email.toString());
      // }
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
    }); // Replace this line with your verification logic
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Address Verification",
                  style: TextStyle(color: Color.fromARGB(255, 219, 99, 255)),
                ),
                TopAnimation(
                  child: Image.asset(
                    "assets/images/address.jpg",
                    height: size.height * 0.30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 5; i++)
                      LeftAnimation(
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(255, 219, 99, 255),
                            ),
                          ),
                          child: Center(
                            child: LeftAnimation(
                              child: TextFormField(
                                controller: digitControllers[i],
                                onChanged: (value) => updateCode(i, value),
                                maxLength: 1,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  counterText:
                                      '', // Hides the character counter
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 20),
                TopAnimation(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(200, 30),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Color(0xff9749ff)
                        // deeppurple when enabled, grey when disabled
                        ),
                    onPressed: verifyCode,
                    child: Text('Verify'),
                  ),
                ),
                SizedBox(height: 20),
                Text('Remaining Attempts: $attempts'),
                SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 238, 237, 237),
                    foregroundColor: const Color.fromARGB(
                        255, 50, 0, 119), // Change the button text color
                    textStyle: const TextStyle(
                        fontSize: 15), // Change the button text size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Change button border radius
                    ),
                  ),
                  onPressed: () {
                    auth.signOut().then((value) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ServiceLoginScreen()));
                      final snackBar = SnackBar(
                        content: Text('Logout'),
                        duration: Duration(seconds: 3),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  },
                  child: Text('Logout'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
