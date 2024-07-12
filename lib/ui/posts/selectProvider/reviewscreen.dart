import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sahulatapp/ui/posts/order_history.dart';

class ReviewScreen extends StatefulWidget {
  final String customername;
  final String providerid;
  final String userid;
  final String orderids;
  final String image;
  const ReviewScreen(
      {super.key,
      required this.providerid,
      required this.customername,
      required this.userid,
      required this.orderids,
      required this.image});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  bool commentValid = true;
  final ref = FirebaseDatabase.instance.ref('review');
  final providerreference = FirebaseDatabase.instance.ref('Provider');
  final orderHistoryRefrence = FirebaseDatabase.instance.ref('OrderHistory');
  double _averageRating = 0.0;
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  double myrating = 3.0;
  TextEditingController commentController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      calculateAndUpdateAverageRating();
      ref.child(widget.providerid).child(widget.orderids.toString()).set({
        'date': DateFormat('yyyy-MM-dd').format(selectedDate).toString(),
        'time': selectedTime.format(context).toString(),
        'username': widget.customername.toString(),
        'message': commentController.text.toString(),
        'reviewid': widget.orderids.toString(),
        'rating': myrating.toString(),
        'image': widget.image.toString(),
      });

      orderHistoryRefrence
          .child(widget.userid)
          .child(widget.orderids)
          .update({'review': '1'});

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderHistory(),
          ));
      debugPrint("Hi");
    }
  }

  void _clearMessage() {
    setState(() {
      commentController.clear();
    });
  }
  // final query = ref.child(widget.providerid);

  void calculateAndUpdateAverageRating() async {
    debugPrint("hi");

    double totalRating = 0.0;
    int numberOfRatings = 0;

    final query = ref.child(widget.providerid);
    query.once().then((DatabaseEvent event) {
      DataSnapshot snapshot = event.snapshot;
      Map<dynamic, dynamic>? providerData =
          snapshot.value as Map<dynamic, dynamic>?;

      if (providerData != null) {
        providerData.forEach((key, value) {
          if (value is Map<dynamic, dynamic>) {
            // Check if the child node contains a "rating" key
            if (value.containsKey("rating") && value["rating"] is String) {
              double? ratingValue = double.tryParse(value["rating"]);
              if (ratingValue != null) {
                debugPrint("$ratingValue");
                totalRating += ratingValue;
                numberOfRatings++;
              }
            }
          }
        });

        if (numberOfRatings > 0) {
          _averageRating = totalRating / numberOfRatings;
          debugPrint("66");
          debugPrint("Average rating: $_averageRating");
          providerreference.child(widget.providerid).update({
            'rating': _averageRating.toString(),
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return AlertDialog(
        //             backgroundColor: Colors.grey.shade100,
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(20)),
        //             title: Text("Confirmation"),
        //             content: Text("Do you really want to clear all history?"),
        //             actions: [
        //               TextButton(
        //                 onPressed: () {
        //                   Navigator.of(context).pop();
        //                 },
        //                 child: Text(
        //                   "Cancel",
        //                   style: TextStyle(
        //                       color: Color(0xff9749ff),
        //                       fontWeight: FontWeight.bold),
        //                 ),
        //               ),
        //               // TextButton(
        //               //   onPressed: () {
        //               //     timer = Timer.periodic(
        //               //       Duration(seconds: 2),
        //               //       (timer) {
        //               //         final snackBar = SnackBar(
        //               //           content: Text('Deleted'),
        //               //           duration: Duration(seconds: 3),
        //               //         );
        //               //         ScaffoldMessenger.of(context)
        //               //             .showSnackBar(snackBar);
        //               //       },
        //               //     );
        //               //     ref.child(uids).remove();
        //               //     Navigator.of(context).pop();
        //               //   },
        //               //   child: Text(
        //               //     "Clear All",
        //               //     style: TextStyle(
        //               //         color: Colors.grey, fontWeight: FontWeight.bold),
        //               //   ),
        //               // ),
        //             ],
        //           );
        //         },
        //       );
        //     },
        //     icon: const Icon(
        //       Icons.delete,
        //       color: Color(0xff9749ff),
        //     ),
        //   )
        // ],
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(0xff9749ff),
            size: 22,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Write a review",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        elevation: 1,
        automaticallyImplyLeading: false,
        shadowColor: Colors.white,
        bottomOpacity: 10,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RatingBar.builder(
              initialRating: myrating,
              minRating: 1.0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                myrating = rating;
                debugPrint('Rating Updated: $rating');
              },
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      maxLines: 2,
                      maxLength: 100,
                      controller: commentController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: _clearMessage,
                        ),
                        labelText: 'Comment',
                        errorText:
                            commentValid ? null : 'Comment cannot be empty',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          setState(() {
                            commentValid = false;
                          });
                          return 'Comment cannot be empty';
                        }
                        setState(() {
                          commentValid = true;
                        });
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 15,
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
                      onPressed: _submitForm,
                      child: Text('Submit Review'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
