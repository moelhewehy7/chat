import 'package:flutter/material.dart';

class SigninChoicesContainer extends StatelessWidget {
  const SigninChoicesContainer({
    Key? key,
    required this.height,
    required this.width,
    required this.text,
    required this.image,
  }) : super(key: key);

  final double height;
  final double width;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {}),
      child: Container(
        height: height * 0.06,
        width: width * .35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffcbcecf),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              scale: 30,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
