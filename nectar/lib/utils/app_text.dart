import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle textStyle;

  const AppText(
      {Key? key,
      required this.text,
      required this.textAlign,
      required this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign == null ? null : TextAlign.center,
      style: textStyle,
    );
  }
}
