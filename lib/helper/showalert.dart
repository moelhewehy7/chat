import 'package:flutter/material.dart';

Future<void> showAlert(
  BuildContext context,
  String title,
  String content,
  String buttonText,
) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          title,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        content: Text(content),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              buttonText,
              style: TextStyle(fontSize: 13, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            style: ElevatedButton.styleFrom(
              fixedSize: Size(85, 14),
              backgroundColor: const Color.fromARGB(255, 29, 29, 29),
            ),
          ),
        ],
      );
    },
  );
}
