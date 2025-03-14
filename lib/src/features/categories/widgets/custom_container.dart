import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Color bordercolor;
  final Color color;
  final VoidCallback ontap;
  const CustomContainer(
      {super.key,
      required this.bordercolor,
      required this.color,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 30,
        width: 30,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: bordercolor),
        ),
        child: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
      ),
    );
  }
}
