import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

class IntroductionOneScreen extends StatefulWidget {
  const IntroductionOneScreen({super.key});

  @override
  State<IntroductionOneScreen> createState() => _IntroductionOneScreenState();
}

class _IntroductionOneScreenState extends State<IntroductionOneScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: colorScheme(context).primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: height * 0.12,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Skip",
                style: txtTheme(context).headlineMedium?.copyWith(
                    color: colorScheme(context).onPrimary,
                    fontWeight: FontWeight.bold),
              )),
          Container(
            height: height * 0.8,
            width: width,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: colorScheme(context).onPrimary,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(149))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 50),
                Center(
                  child: Image.asset(
                    AppImages.introduction,
                    cacheHeight: 200,
                  ),
                ),
                SizedBox(height: 10),
                Text("Shop From your favorite store & application",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface)),
                SizedBox(height: 10),
                Text(
                    "Discover a world of convenience and endless choices  Get ready to experience the best of online shopping right at your fingertips ",
                    style: txtTheme(context)
                        .bodyLarge
                        ?.copyWith(color: colorScheme(context).surface)),
                SizedBox(height: 70),
                GestureDetector(
                  onTap: () {},
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          color: colorScheme(context).primary,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.arrow_forward,
                        color: colorScheme(context).onPrimary,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
