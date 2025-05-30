import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/app_colors.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

class StartBidding extends StatefulWidget {
  const StartBidding({super.key});

  @override
  State<StartBidding> createState() => _StartBiddingState();
}

class _StartBiddingState extends State<StartBidding> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: w * 0.6,
                width: w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 40),
                    SizedBox(
                      height: 95,
                      width: 250,
                      child: Center(
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(100, 5, 20, 30),
                              child: CircleAvatar(
                                backgroundColor: AppColor.grey,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(50, 10, 20, 30),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: AppColor.darkGrey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Icon(
                        Icons.fullscreen_outlined,
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: h * 0.7,
                width: w,
                child: Stack(
                  children: [
                    Container(
                      height: h * 0.2,
                      width: w,
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      decoration: BoxDecoration(
                        color: colorScheme(context).primary.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 5),
                          Text("Auction item name",
                              style: txtTheme(context).headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).surface)),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: AppColor.grey,
                              ),
                              SizedBox(width: 10),
                              Text("Owners name",
                                  style: txtTheme(context)
                                      .headlineMedium
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme(context).surface)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 90),
                      height: h * 0.45,
                      width: w,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 196, 197, 197),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: h * 0.15,
                            width: w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: w * 0.35,
                                  height: h * 1,
                                ),
                                Container(
                                  height: h * 0.1,
                                  width: w * 0.01,
                                  color: AppColor.grey,
                                ),
                                SizedBox(
                                  width: w * 0.35,
                                  height: h * 1, 
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
