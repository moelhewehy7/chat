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
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
        ),
        content: Text(content),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        actions: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1D1D1D),
              ),
              child: Text(
                buttonText,
                style: const TextStyle(fontSize: 13, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      );
    },
  );
}
