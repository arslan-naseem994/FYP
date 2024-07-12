import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final VoidCallback ontap;
  final String title;
  final BoxDecoration decoration;
  final bool loading;
  final double width;

  const RoundButton(
      {super.key,
      required this.width,
      required this.title,
      required this.decoration,
      required this.ontap,
      this.loading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: decoration,
        height: 50,
        width: width,
        child: Center(
          child: loading == true
              ? const CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                )
              : Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
