import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/introduction_screes/controller/introduction_provider.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

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
    final provider = Provider.of<IntroductionProvider>(context);

    return Scaffold(
      backgroundColor: colorScheme(context).primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(height: height * 0.12),
          TextButton(
            onPressed: () => context.pushNamed(AppRoute.login),
            child: Text(
              "Skip",
              style: txtTheme(context).headlineMedium?.copyWith(
                  color: colorScheme(context).onPrimary,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: height * 0.8,
            width: width,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: colorScheme(context).onPrimary,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(149))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Center(
                    child: provider.index == 0
                        ? Image.asset(
                            AppImages.introduction,
                            cacheHeight: 200,
                          )
                        : provider.index == 1
                            ? Image.asset(
                                AppImages.introTwo,
                                cacheHeight: 200,
                              )
                            : Image.asset(
                                AppImages.introThree,
                                cacheHeight: 200,
                              )),
                const SizedBox(height: 10),
                Text(
                  "Shop From your favorite store & application",
                  style: txtTheme(context).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface),
                ),
                const SizedBox(height: 10),
                Text(
                  "Discover a world of convenience and endless choices  Get ready to experience the best of online shopping right at your fingertips ",
                  style: txtTheme(context)
                      .bodyLarge
                      ?.copyWith(color: colorScheme(context).surface),
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(3,
                            (i) => _buildIndicator(i, provider.index, context)),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        provider.nextIndex();
                        if (provider.index == 3) {
                          context.pushReplacementNamed(AppRoute.signup);
                        }
                      },
                      child: Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                            color: colorScheme(context).primary,
                            shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_forward,
                          color: colorScheme(context).onPrimary,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildIndicator(int i, int currentIndex, BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(
        color: i == currentIndex
            ? colorScheme(context).primary
            : colorScheme(context).onPrimary,
        border:
            Border.all(color: colorScheme(context).surface.withOpacity(0.3)),
        shape: BoxShape.circle,
      ),
    );
  }
}
