import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:sahulatapp/user/homebottom.dart';

class ChatScreen extends StatefulWidget {
  final String userid;
  final String providerid;
  final String role;
  const ChatScreen(
      {super.key,
      required this.providerid,
      required this.role,
      required this.userid});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final reference = FirebaseDatabase.instance.ref('chats');
  final reference2 = FirebaseDatabase.instance.ref('mychat');
  TextEditingController _messageController = TextEditingController();
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Chat",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xff9749ff),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: <Widget>[
          // Text('Arslan'),
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildMessageComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _messageController,
                onChanged: (text) {
                  // You can implement live feedback or validation here
                },
                onSubmitted: _handleSubmitted,
                decoration:
                    InputDecoration.collapsed(hintText: 'Send a message'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(
                  Icons.send,
                  color: Color(0xff9749ff),
                ),
                onPressed: () => _handleSubmitted(_messageController.text),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    String orderID = DateTime.now().millisecondsSinceEpoch.toString();
    if (text.isNotEmpty) {
      _messageController.clear();
      ChatMessage message = ChatMessage(
        text: text,
        isuser: widget.role,
        // Add sender information here if needed
      );
      // setState(() {
      //   _messages.insert(0, message);
      // });
      reference
          .child(widget.providerid)
          .child(widget.userid)
          .child(orderID)
          .set({
        'aaauserid': widget.userid,
        'text': message.text,
        'role': widget.role,

        // Store other message properties if necessary
      });
      reference2
          .child(widget.userid)
          .child(widget.providerid)
          .child(orderID)
          .set({
        'aaauserid': widget.providerid,
        'text': message.text,
        'role': widget.role,

        // Store other message properties if necessary
      });
    }
  }

  @override
  void initState() {
    super.initState();
    reference
        .child(widget.providerid)
        .child(widget.userid)
        .onChildAdded
        .listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'

        if (userList != null && userList['text'] != null) {
          var message = ChatMessage(
            isuser: userList['role'],
            text: userList['text'],
            // Extract sender and other message properties if stored
          );
          setState(() {
            _messages.insert(0, message);
          });
        }
      }
    });
    reference2
        .child(widget.providerid)
        .child(widget.userid)
        .onChildAdded
        .listen((event) {
      final dataSnapshot = event.snapshot;
      final userList = dataSnapshot.value ?? {};

      if (userList is Map<dynamic, dynamic>) {
        // Filter the userList to get only the entries where 'bookingstatus' is 'Pending'

        if (userList != null && userList['text'] != null) {
          var message = ChatMessage(
            isuser: userList['role'],
            text: userList['text'],
            // Extract sender and other message properties if stored
          );
          setState(() {
            _messages.insert(0, message);
          });
        }
      }
    });
    // reference.onChildAdded.listen((event) {
    //   var value = event.snapshot.value as Map<String,
    //       dynamic>?; // Cast the value to Map<String, dynamic> or nullable type
    //   if (value != null && value['text'] != null) {
    //     var message = ChatMessage(
    //       text: value['text'],
    //       // Extract sender and other message properties if stored
    //     );
    //     setState(() {
    //       _messages.insert(0, message);
    //     });
    //   }
    // });
  }
}

class ChatMessage extends StatelessWidget {
  final String text;
  final String isuser;

  const ChatMessage({super.key, required this.text, required this.isuser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Align(
        alignment:
            isuser == 'user' ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: isuser == 'user'
                ? Colors.blue
                : Colors
                    .green, // You can set different colors for provider and user messages
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
