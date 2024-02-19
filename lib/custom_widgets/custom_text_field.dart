import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {Key? key,
      this.label,
      this.onchanged,
      this.validator,
      this.obscureText = false})
      : super(key: key);

  String? label;

  // it cant be Voidcallback becasue type is string
  Function(String)? onchanged;
  String? Function(String?)? validator;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText:
          obscureText!, // we can give it intial value in the constructor
      //which means it can accept nullable values. or The obscureText: obscureText ?? false line uses the null-aware operator (??) to assign a default value of false in case the obscureText value is null.
      onChanged: onchanged,
      validator: validator,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        label: Text(
          label!,
          style: TextStyle(
              color: Color.fromARGB(255, 45, 47, 47),
              fontWeight: FontWeight.w300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Color.fromARGB(255, 54, 55, 55),
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xffcbcecf),
            )),
      ),
    );
  }
}
