import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButon extends StatelessWidget {
  CustomButon(
      {required this.onpressed,
      required this.text}); // required means we shoud use it ,if we didnt add it so it's not neccisry to use the object
  VoidCallback? onpressed;
  String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w400),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 255, 233, 216),
            fixedSize: Size(450, 40), // Change the button size here
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))));
  }
}
