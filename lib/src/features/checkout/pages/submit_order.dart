import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/checkout/widgets/add_card_bottom_sheet.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class SubmitOrderScreen extends StatefulWidget {
  const SubmitOrderScreen({super.key});

  @override
  State<SubmitOrderScreen> createState() => _SubmitOrderScreenState();
}

class _SubmitOrderScreenState extends State<SubmitOrderScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        centerTitle: true,
        title: Text(
          "Checkout",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Shipping Address",
                style: txtTheme(context)
                    .headlineSmall
                    ?.copyWith(color: colorScheme(context).surface),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "3 Newbridge Court \nChino Hills, CA 91709, United States",
                      style: txtTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface),
                    ),
                    TextButton(
                        onPressed: () {
                          context.pushNamed(AppRoute.editaddress);
                        },
                        child: Text(
                          "Change",
                          style: txtTheme(context).headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).primary),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment",
                      style: txtTheme(context).headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface)),
                  TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return CustomBottomSheetCard(
                              nameController: nameController,
                              cvvController: cvvController,
                              expireController: expireController,
                              numberController: numberController,
                            );
                          },
                        );
                      },
                      child: Text(
                        "Change",
                        style: txtTheme(context).headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).primary),
                      ))
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 100,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Image.asset(
                      AppImages.mastercard1,
                      cacheHeight: 40,
                      cacheWidth: 50,
                    )),
                  ),
                  SizedBox(width: 50),
                  Text(
                    "***** ***** **** 3333",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text(
                "Delivery method",
                style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customContrainer(AppImages.fedex, "2-3 days"),
                  customContrainer(AppImages.usps, "2-3 days"),
                  customContrainer(AppImages.dhl, "2-3 days"),
                ],
              ),
              customRow("Order", "\$112"),
              SizedBox(height: 10),
              customRow("Dilivery", "\$15"),
              SizedBox(height: 10),
              customRow("Summery", "\$127"),
              SizedBox(height: 20),
              CustomGradientButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.completeorder);
                  },
                  buttonText: "SUBMIT ORDER")
            ],
          ),
        ),
      ),
    );
  }

  Widget customContrainer(String image, String text) {
    return Container(
      height: 95,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            cacheHeight: 60,
            cacheWidth: 80,
          ),
          SizedBox(height: 10),
          Text(
            text,
            style: txtTheme(context).headlineSmall?.copyWith(
                color: colorScheme(context).surface.withOpacity(0.4)),
          )
        ],
      ),
    );
  }

  Widget customRow(String text, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: txtTheme(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme(context).surface.withOpacity(0.3)),
        ),
        Text(
          price,
          style: txtTheme(context).headlineSmall?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        )
      ],
    );
  }
}
