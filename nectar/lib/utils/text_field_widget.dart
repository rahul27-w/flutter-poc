import 'package:flutter/material.dart';
import 'package:nectar/resources/colors.dart';
import 'package:nectar/resources/text_styles.dart';

class TextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final bool obscureText;
  final Widget suffixIcon;
  final bool enabled;

  TextFieldWidget(
      {required this.controller,
      required this.obscureText,
      required this.labelText,
      required this.hintText,
      required this.prefixIcon,
      required this.suffixIcon,
      required this.enabled});

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      maxLines: 1,
      enabled: widget.enabled,
      cursorColor: ColorStyles.primaryColor,
      obscureText: widget.obscureText,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorStyles.white,
        labelStyle: TextStyle(color: Colors.black, fontSize: 18),
        hintText: widget.hintText,
        hintStyle: TextStyles.greyBold14Text,
        prefixIcon: widget.prefixIcon,
        suffix: widget.suffixIcon,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyles.primaryColor),
          borderRadius: BorderRadius.circular(10.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorStyles.white),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
