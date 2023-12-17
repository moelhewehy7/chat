import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomConatiner extends StatelessWidget {
  const CustomConatiner({Key? key, this.text1, this.text2}) : super(key: key);
  final String? text1;
  final String? text2;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      height: 260,
      width: double.infinity,
      child: Stack(
        children: [
          const RiveAnimation.asset(
            "assets/images/onboard_animation.riv",
            fit: BoxFit.cover,
          ),
          Positioned(
              child: BackdropFilter(
                  filter: ImageFilter.blur(
                      sigmaX: 50,
                      sigmaY:
                          50), // blur to be applied horizontally and vertically
                  child:
                      const SizedBox())), //used as an empty placeholder to apply constraints to the BackdropFilter
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1!,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    text2!,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
