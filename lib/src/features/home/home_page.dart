import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_textform_filed.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List items = [
    Container(
      height: 200,
      width: 400,
      color: Colors.amberAccent,
    ),
    Container(
      height: 200,
      width: 400,
      color: Colors.green,
    ),
    Container(
      height: 200,
      width: 400,
      color: Colors.deepOrange,
    ),
    Container(
      height: 200,
      width: 400,
      color: Colors.purple,
    ),
  ];
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
            SizedBox(
              height: 70,
              width: 250,
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                  // backgroundImage: AssetImage(AppImages.facebook),
                  backgroundColor: colorScheme(context).primary,
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
              ),
            ),
            Spacer(),
            Badge(
              child: Icon(
                Icons.notifications,
                color: colorScheme(context).surface,
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
                CarouselSlider(
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
                Row()
              ],
            ),
          ),
        ));
  }
}
