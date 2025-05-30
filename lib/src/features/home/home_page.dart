import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_textform_filed.dart';
import 'package:whole_selle_x_application/src/features/home/model/category_list.dart';
import 'package:whole_selle_x_application/src/features/home/widgets/widgetlist.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  CarouselSliderController _carouselSliderController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScheme(context).onPrimary,
        appBar: AppBar(
          backgroundColor: colorScheme(context).onPrimary,
          actions: [
            SizedBox(width: 16),
            GestureDetector(
              onTap: () {},
              child: SizedBox(
                height: 70,
                width: 250,
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    backgroundImage: AssetImage(AppImages.ahmadpic),
                    radius: 20,
                  ),
                  subtitle: Text(
                    "Muhammad Shahid",
                    style: txtTheme(context).headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  ),
                  title: Text(
                    "Hello",
                    style: txtTheme(context)
                        .headlineSmall
                        ?.copyWith(color: colorScheme(context).surface),
                  ),
                  onTap: () => context.pushNamed(AppRoute.profilescreen),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoute.notificationscreen),
              child: Badge(
                child: Icon(
                  Icons.notifications,
                  color: colorScheme(context).surface,
                ),
              ),
            ),
            SizedBox(width: 16)
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextFormField(
                  prefixIcon: Icon(
                    Icons.search,
                    color: colorScheme(context).surface,
                  ),
                  hint: "Search anything",
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(AppRoute.biddingmain);
                  },
                  child: CarouselSlider(
                    carouselController: _carouselSliderController,
                    items: items.map((item) => SizedBox(child: item)).toList(),
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    builsRowWidget(_currentIndex == 0
                        ? colorScheme(context).primary
                        : colorScheme(context).onPrimary),
                    builsRowWidget(_currentIndex == 1
                        ? colorScheme(context).primary
                        : colorScheme(context).onPrimary),
                    builsRowWidget(_currentIndex == 2
                        ? colorScheme(context).primary
                        : colorScheme(context).onPrimary),
                    builsRowWidget(_currentIndex == 3
                        ? colorScheme(context).primary
                        : colorScheme(context).onPrimary),
                  ],
                ),
                textinRow("Sales", "show all", () {}),
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: 4,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: AssetImage(AppImages.facebook),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          Text(
                            "Watches",
                            style: txtTheme(context).displaySmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "\$ 400",
                                style: txtTheme(context).displaySmall?.copyWith(
                                    color: colorScheme(context).primary),
                              ),
                              SizedBox(width: 30),
                              Icon(
                                Icons.chat,
                                color: colorScheme(context).primary,
                              )
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                textinRow("Catogery", "show all", () {
                  context.pushNamed(AppRoute.catogerypage);
                }),
                SizedBox(
                  height: 90,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: category.length,
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: CachedNetworkImage(
                          imageUrl: category[index],
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget builsRowWidget(Color color) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            shape: BoxShape.circle,
            color: color),
      ),
    );
  }

  Widget textinRow(String text1, String text2, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: txtTheme(context).displayMedium?.copyWith(
              color: colorScheme(context).surface, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            text2,
            style: txtTheme(context)
                .displaySmall
                ?.copyWith(color: colorScheme(context).primary),
          ),
        )
      ],
    );
  }
}
