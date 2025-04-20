import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_textform_filed.dart';

class CustomTextfiledContainer extends StatelessWidget {
  final TextEditingController controller;
  final String text1;
  final TextInputType type;

  const CustomTextfiledContainer(
      {super.key,
      required this.controller,
      required this.text1,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width,
      child: CustomTextFormField(
        controller: controller,
        hint: text1,
        hintColor: colorScheme(context).surface.withOpacity(0.4),
        keyboardType: type,
      ),
    );
  }
}
