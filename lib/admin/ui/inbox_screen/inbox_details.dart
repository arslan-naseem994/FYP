import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sahulatapp/utils/utils.dart';

class DetailScreen extends StatefulWidget {
  final String message;
  final String name;
  final String title;
  final String date;
  final String imagePath;
  final String sender;
  final String supporid;
  final String userImage;
  final String type;
  final bool reply;

  const DetailScreen({
    super.key,
    required this.message,
    required this.name,
    required this.title,
    required this.date,
    required this.imagePath,
    required this.sender,
    required this.supporid,
    required this.reply,
    required this.userImage,
    required this.type,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController _messageController = TextEditingController();
    final replyRef = FirebaseDatabase.instance.ref('AllNotification');
    final replyUpdateRef = FirebaseDatabase.instance.ref('Allsupport');
    TimeOfDay selectedTime = TimeOfDay.now();
    void _clearMessage() {
      setState(() {
        _messageController.clear();
      });
    }

    void _showReplyDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(
                "Reply",
                style: TextStyle(
                  color: Color(0xff9749ff),
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _messageController,
                    maxLines: 5,
                    maxLength: 200,
                    decoration: InputDecoration(
                      hintText: "Enter your message (max 200 characters)",
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: _clearMessage,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      elevation: 10,
                      minimumSize: Size(80, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Cancel"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff9749ff),
                      elevation: 12,
                      minimumSize: Size(80, 30),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      replyUpdateRef
                          .child(widget.supporid.toString())
                          .update({'Reply': true});
// all notification on reply message;
                      replyRef.child(widget.supporid.toString()).set({
                        'notificationid': widget.supporid.toString(),
                        'userid': widget.sender.toString(),
                        'notificationtype': 'Admin Message',
                        'date': widget.date.toString(),
                        'time': selectedTime.format(context).toString(),
                        'notificationname': widget.name.toString(),
                        'image': widget.imagePath.toString(),
                        'usermessage': widget.message.toString(),
                        'subject': _messageController.text.toString(),
                        'messageseen': '1',
                        'type': 'message',
                      }).then((value) {
                        Utils().toastMessage('Message Sent');
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString());
                      });
                      Navigator.of(context).pop();
                    } else {
                      Utils().toastMessage('Message cannot be empty');
                    }
                  },
                  child: Text("Send"),
                ),
              ],
            ),
          );
        },
      );
    }

    // void awin() {
    //   userRef.once().then((DatabaseEvent event) {
    //     String Name = 'empty';
    //     DataSnapshot snapshot = event.snapshot;
    //     Name = snapshot.value.toString();

    //     return Name;
    //   }).then((Name) {
    //     if (Name == "null") {
    //       // Navigator.push(
    //       //     context,
    //       //     MaterialPageRoute(
    //       //         builder: (context) => const ProfileScreen()));
    //     } else {}
    //   });
    // }

    void dispose() {
      replyRef.onValue.drain();
      _messageController.dispose();
      super.dispose();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: GestureDetector(
              child: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff9749ff),
                size: 22,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        automaticallyImplyLeading: false,
        title: Text(
          "Message",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 32,
              top: 30,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(widget.imagePath.toString()),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: Text(
                      "${widget.name}",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      widget.date,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    )),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 20),
            child: Text(
              "Finished the part of UX",
              style: TextStyle(
                  color: Color(0xff9749ff),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 30, top: 10, bottom: 5),
            child: Text(
              "User Message",
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 30, top: 10, bottom: 20),
            child: Text(
              "${widget.message}",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 14,
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 30, top: 10, bottom: 5),
            child: ElevatedButton(
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
                onPressed: _showReplyDialog,
                child: Text("Reply")),
          ),
          if (widget.reply == true)
            Padding(
              padding:
                  const EdgeInsets.only(left: 34, right: 30, top: 0, bottom: 5),
              child: Row(
                children: [
                  Text(
                    "Replied",
                    style: TextStyle(fontSize: 10),
                  ),
                  Icon(Icons.done_rounded, size: 10)
                ],
              ),
            ),
        ],
      ),
    );
  }
}
