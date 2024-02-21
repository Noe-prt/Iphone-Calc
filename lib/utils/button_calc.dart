import 'package:flutter/material.dart';

class CalcButton extends StatelessWidget {
  final String buttonText;
  final double buttonHeight;
  final double buttonWidth;
  final Color buttonColor;
  final double fontSize;
  final Color textColor;
  final IconData? buttonIcon;

  CalcButton({
    required this.buttonText,
    required this.buttonColor,
    required this.fontSize,
    required this.buttonHeight,
    required this.buttonWidth,
    required this.textColor,
    this.buttonIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            color: buttonColor),
        height: buttonHeight,
        width: buttonWidth,
        child: Center(
          child: buttonIcon != null
              ? Icon(
              buttonIcon,
              size: fontSize,
              color: textColor,
          )
              : Text(
                  buttonText,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: 'San Francisco',
                    color: textColor,
                  ),
                  textAlign: TextAlign.start,
                ),
        ),
      ),
    );
  }
}
