import 'package:flutter/material.dart';
import 'package:nectar/resources/text_styles.dart';


class ButtonContainer extends StatefulWidget {
  final String buttonText;
  final double buttonWidth;
  final double buttonHeight;
  final double borderRadius;
  final Color buttonColor;
  final VoidCallback onTap;
  ButtonContainer({required this.buttonText, required this.buttonWidth,
    required this.buttonHeight, required this.borderRadius, required this
        .buttonColor, required this.onTap});
  @override
  _ButtonContainerState createState() => _ButtonContainerState();
}

class _ButtonContainerState extends State<ButtonContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        height: widget.buttonHeight,
        width: widget.buttonWidth,
        decoration: BoxDecoration(
          color: widget.buttonColor,
          borderRadius: widget.borderRadius == null ? BorderRadius.circular(10.0) : BorderRadius.circular(widget.borderRadius),
        ),
        child: Center(
            child: Text(
              widget.buttonText,
              style: TextStyles.whiteBold16Text,
            )),
      ),
    );
  }
}
