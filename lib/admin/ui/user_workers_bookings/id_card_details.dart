import 'package:flutter/material.dart';
import 'package:sahulatapp/admin/ui/pendingregis/image.dart';

class IdCardDetailsScreen extends StatefulWidget {
  final String front;
  final String back;
  const IdCardDetailsScreen(
      {super.key, required this.front, required this.back});

  @override
  State<IdCardDetailsScreen> createState() => _IdCardDetailsScreenState();
}

class _IdCardDetailsScreenState extends State<IdCardDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "ID Card",
          style: TextStyle(
            // fontWeight: FontWeight.bold,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Front",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                        imageUrl: widget.front.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            spreadRadius: 5)
                      ],
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(0)),
                  height: 200,
                  width: 325,
                  child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.front.toString())),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Back",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 3),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ImageViewScreen(
                        imageUrl: widget.back.toString(),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3, 3),
                            blurRadius: 3,
                            spreadRadius: 5)
                      ],
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(0)),
                  height: 200,
                  width: 325,
                  child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.back.toString())),
                ),
              ),
            ]),
      ),
    );
  }
}
