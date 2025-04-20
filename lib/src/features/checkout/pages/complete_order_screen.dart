import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class CompleteOrderScreen extends StatefulWidget {
  const CompleteOrderScreen({super.key});

  @override
  State<CompleteOrderScreen> createState() => _CompleteOrderScreenState();
}

class _CompleteOrderScreenState extends State<CompleteOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 90),
            Center(
              child: Image.asset(
                AppImages.bage,
                cacheHeight: 200,
                cacheWidth: 200,
              ),
            ),
            SizedBox(height: 10),
            Text("Success",
                style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface)),
            SizedBox(height: 15),
            Text(
              "Your order will be delivered soon.\nThank you for choosing our app!",
              style: txtTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).surface),
            ),
            Spacer(),
            CustomGradientButton(
                onPressed: () {
                  context.pushNamed(AppRoute.itempage);
                },
                buttonText: "CONTINUE SHOPPING")
          ],
        ),
      ),
    );
  }
}
