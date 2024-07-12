// class ChatMessage extends StatelessWidget {
//   final String text;
//   final bool isUser; // Add this parameter

//   ChatMessage({super.key, required this.text, required this.isUser});

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//       alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
//         padding: EdgeInsets.all(12.0),
//         decoration: BoxDecoration(
//           color: isUser ? Color(0xff9749ff) : Colors.grey, // Set different colors for user and provider messages
//           borderRadius: BorderRadius.circular(8.0),
//         ),
//         child: Text(
//           text,
//           style: TextStyle(color: Colors.white), // Set text color for messages
//         ),
//       ),
//     );
//   }
// }
