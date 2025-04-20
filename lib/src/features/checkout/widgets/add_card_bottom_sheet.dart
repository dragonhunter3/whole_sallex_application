import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_textform_filed.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class CustomBottomSheetCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController numberController;
  final TextEditingController expireController;
  final TextEditingController cvvController;
  const CustomBottomSheetCard(
      {super.key,
      required this.nameController,
      required this.cvvController,
      required this.expireController,
      required this.numberController});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: colorScheme(context).onPrimary,
              borderRadius: BorderRadius.circular(20)),
          child: ListView(
            children: [
              SizedBox(height: 15),
              Center(
                child: Text(
                  "Add New Card",
                  style: txtTheme(context).headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomTextFormField(
                  controller: nameController,
                  hint: "Name on card",
                  hintColor: colorScheme(context).surface.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomTextFormField(
                    controller: numberController,
                    hint: "Card number",
                    keyboardType: TextInputType.number,
                    hintColor: colorScheme(context).surface.withOpacity(0.4),
                    suffixIcon: Icon(Icons.credit_card,
                        color: colorScheme(context).primary)),
              ),
              SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomTextFormField(
                  controller: expireController,
                  hint: "Expire date ",
                  hintColor: colorScheme(context).surface.withOpacity(0.4),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: CustomTextFormField(
                  controller: cvvController,
                  hint: "CVV",
                  hintColor: colorScheme(context).surface.withOpacity(0.4),
                  suffixIcon: Icon(Icons.help_outline,
                      color: colorScheme(context).primary),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (value) {},
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Set as default payment method",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  )
                ],
              ),
              SizedBox(height: 20),
              CustomGradientButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.addresspage);
                  },
                  buttonText: "ADD CARD")
            ],
          ),
        );
      },
    );
  }
}
