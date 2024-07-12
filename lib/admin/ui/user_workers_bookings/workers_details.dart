import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/pendingregis/image.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/id_card_details.dart';
import 'package:sahulatapp/admin/ui/user_workers_bookings/workerbooking.dart';
import 'package:sahulatapp/ui/posts/selectProvider/all_reviews.dart';

class WorkersDetailsScreen extends StatefulWidget {
  final String name;
  final String address;
  final String phone;
  final String email;
  final String image;
  final String cnic;
  final String expertise;
  final String idcardfront;
  final String idcardback;
  final String isverified;
  final String providerid;

  const WorkersDetailsScreen(
      {super.key,
      required this.name,
      required this.address,
      required this.phone,
      required this.email,
      required this.image,
      required this.cnic,
      required this.expertise,
      required this.idcardback,
      required this.idcardfront,
      required this.isverified,
      required this.providerid});

  @override
  State<WorkersDetailsScreen> createState() => _WorkersDetailsScreenState();
}

class _WorkersDetailsScreenState extends State<WorkersDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding:
            const EdgeInsets.only(left: 35, top: 50, bottom: 30, right: 25),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 0),
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color(0xff9749ff),
                    ),
                    onPressed: () {
                      Navigator.pop(context);

                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (context) => const SplashScreen3()));
                    },
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ImageViewScreen(
                      imageUrl: widget.image.toString(),
                    ),
                  ),
                );
              },
              child: SizedBox(
                width: 150,
                height: 150,
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 191, 141, 255),
                      )),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: NetworkImage(widget.image.toString()),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("Name")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(flex: 4, child: Text(widget.name)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("Address")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(flex: 4, child: Text(widget.address)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("Contact Number")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(flex: 4, child: Text(widget.phone)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("Email")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(flex: 4, child: Text(widget.email)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("Verified")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    if (widget.isverified == 'true')
                      Expanded(flex: 4, child: Text("Yes")),
                    if (widget.isverified != 'true')
                      Expanded(flex: 4, child: Text("No")),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("Expertise")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(flex: 4, child: Text(widget.expertise)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("CNIC#")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(flex: 4, child: Text(widget.cnic)),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(flex: 4, child: Text("ID Card")),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                        flex: 2,
                        child: Text(
                          ":",
                          style: TextStyle(
                            color: Color.fromARGB(255, 153, 76, 255),
                          ),
                        )),
                    Expanded(
                        flex: 4,
                        child: ElevatedButton(
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
                                    builder: (context) => IdCardDetailsScreen(
                                        front: widget.idcardfront,
                                        back: widget.idcardback),
                                  ));
                            },
                            child: Text("View"))),
                  ],
                ),

                SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 238, 237, 237),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WorkerBookingDetails(
                                        providerid: widget.providerid,
                                      )));
                        },
                        child: const Text("Bookings")),
                    SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 238, 237, 237),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AllReviewsScreen(
                                        providerid: widget.providerid,
                                      )));
                        },
                        child: const Text("Reviews")),
                  ],
                )
                // Row(
                //   children: [
                //     ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor:
                //               const Color.fromARGB(255, 238, 237, 237),
                //           foregroundColor: const Color.fromARGB(
                //               255, 50, 0, 119), // Change the button text color
                //           textStyle: const TextStyle(
                //               fontSize: 15), // Change the button text size
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(
                //                 20), // Change button border radius
                //           ),
                //         ),
                //         onPressed: () {
                // Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => UserOrderDetails(
                //                         userid: widget.userid,
                //                       )));
                //         },
                //         child: const Text("Bookings")),
                //     SizedBox(
                //       width: 10,
                //     ),
                //     ElevatedButton(
                //         style: ElevatedButton.styleFrom(
                //           backgroundColor:
                //               const Color.fromARGB(255, 238, 237, 237),
                //           foregroundColor: const Color.fromARGB(
                //               255, 50, 0, 119), // Change the button text color
                //           textStyle: const TextStyle(
                //               fontSize: 15), // Change the button text size
                //           shape: RoundedRectangleBorder(
                //             borderRadius: BorderRadius.circular(
                //                 20), // Change button border radius
                //           ),
                //         ),
                //         onPressed: () {
                //           Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                   builder: (context) => UserMessageScreen(
                //                         userid: widget.userid,
                //                       )));
                //         },
                //         child: const Text("Messages")),
                //   ],
                // )
              ],
            ),
          ],
        ),
      )),
    );
  }
}
