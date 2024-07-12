import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewScreen extends StatelessWidget {
  final String imageUrl;

  ImageViewScreen({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(
              left: 10,
            ),
            child: GestureDetector(
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 22,
              ),
              onTap: () {
                Navigator.pop(context);
              },
            )),
        automaticallyImplyLeading: false,
        // title: const Text(
        //   "Profile Picture",
        //   style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        // ),
        backgroundColor: Colors.black,
        elevation: 0.7,
      ),
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageUrl),
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
