import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class BiddingMainScreen extends StatelessWidget {
  const BiddingMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Autions",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        actions: [
          GestureDetector(
              onTap: () {}, child: Icon(Icons.history, color: Colors.black)),
          SizedBox(width: 10),
        ],
      ),
      body: Container(
          height: h,
          width: w,
          padding: EdgeInsets.all(16),
          color: const Color.fromARGB(255, 228, 227, 225),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(AppRoute.startbid);
                  },
                  child: Container(
                      height: h * 0.14,
                      width: w * 0.4,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(),
                          Text("New  ",
                              style: txtTheme(context).headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).surface)),
                          Image.asset(AppImages.assleries,
                              cacheHeight: 100, cacheWidth: 100)
                        ],
                      )),
                ),
              );
            },
          )),
    );
  }
}
