import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CustomConatiner extends StatelessWidget {
  const CustomConatiner({Key? key, this.text1, this.text2}) : super(key: key);
  final String? text1;
  final String? text2;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.centerLeft,
      height: screenHeight * .30,
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
                          15), // blur to be applied horizontally and vertically
                  child:
                      const SizedBox())), //used as an empty placeholder to apply constraints to the BackdropFilter
          Padding(
            padding: const EdgeInsets.only(top: 120, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text1!,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: screenWidth * .08,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(
                    text2!,
                    style: TextStyle(
                        fontSize: screenWidth * .04,
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
