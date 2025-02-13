import 'package:flutter/material.dart';

class CustomGradientButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final double? width;
  final double? height;
  final double? fontSize;
  final double borderRadius;
  final Color borderColor;
  final Color textColor;
  final List<Color>? buttonColors;

  const CustomGradientButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.width,
    this.fontSize = 16,
    this.height,
    this.borderRadius = 10.0,
    this.borderColor = Colors.transparent,
    this.textColor = Colors.white,
    this.buttonColors,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: buttonColors ??
              [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.secondary,
              ],
          begin: Alignment.topRight,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: borderColor),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize:
              Size(width ?? MediaQuery.of(context).size.width, height ?? 50),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
