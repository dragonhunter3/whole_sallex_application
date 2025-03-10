import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/setting/controller/setting_controller.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  TextEditingController controller = TextEditingController(text: "Shahid Kah");
  TextEditingController oldController = TextEditingController();
  TextEditingController newControlleroller = TextEditingController();
  TextEditingController repControlleroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              "Settings",
              style: txtTheme(context)
                  .displayLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 15),
            Text(
              "Notifications",
              style: txtTheme(context)
                  .displayMedium
                  ?.copyWith(color: colorScheme(context).surface),
            ),
            customRow("Sales"),
            customRow("New arrivals"),
            customRow("Delivery status changes"),
            SizedBox(
              height: 20,
            ),
            Text(
              "Personal Information",
              style: txtTheme(context)
                  .displayMedium
                  ?.copyWith(color: colorScheme(context).surface),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "profile",
                  style: txtTheme(context)
                      .headlineMedium
                      ?.copyWith(color: colorScheme(context).surface),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Set profile",
                    style: txtTheme(context).headlineMedium?.copyWith(
                        color: colorScheme(context).surface.withOpacity(0.5)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Password",
                  style: txtTheme(context)
                      .displayMedium
                      ?.copyWith(color: colorScheme(context).surface),
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => CustomBottomSheet(),
                    );
                  },
                  child: Text(
                    "Chage",
                    style: txtTheme(context).headlineMedium?.copyWith(
                        color: colorScheme(context).surface.withOpacity(0.5)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.only(left: 10),
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text(
                    "Passsword",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        color: colorScheme(context).surface,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                    child: TextField(
                      controller: controller,
                      style: txtTheme(context)
                          .headlineMedium
                          ?.copyWith(color: colorScheme(context).surface),
                      obscureText: true,
                      enabled: false,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.visibility),
                          suffixIconColor: colorScheme(context).surface),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customRow(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: txtTheme(context)
              .headlineMedium
              ?.copyWith(color: colorScheme(context).surface),
        ),
        Consumer<SettingController>(
          builder: (context, switchProvider, child) {
            return SizedBox(
              child: Transform.scale(
                scale: 0.7,
                child: Switch(
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  value: switchProvider.isSwitchOn(text),
                  onChanged: (value) {
                    switchProvider.toggleSwitch(text, value);
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget CustomBottomSheet() {
    return BottomSheet(
      onClosing: () {},
      // isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 400,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: colorScheme(context).onPrimary,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
          child: ListView(
            children: [
              SizedBox(height: 20),
              Text(
                "Password Change",
                style: txtTheme(context).displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(left: 10),
                color: Colors.white,
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: txtTheme(context)
                      .headlineMedium
                      ?.copyWith(color: colorScheme(context).surface),
                  controller: oldController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your old Text",
                      hintStyle: txtTheme(context)
                          .headlineMedium
                          ?.copyWith(color: colorScheme(context).surface)),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Forgot Password",
                  style: txtTheme(context)
                      .headlineLarge
                      ?.copyWith(color: colorScheme(context).surface),
                ),
              ),
              SizedBox(height: 15),
              Container(
                color: Colors.white,
                height: 50,
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: txtTheme(context)
                      .headlineMedium
                      ?.copyWith(color: colorScheme(context).surface),
                  controller: newControlleroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your New Password",
                      hintStyle: txtTheme(context)
                          .headlineMedium
                          ?.copyWith(color: colorScheme(context).surface)),
                ),
              ),
              SizedBox(height: 15),
              Container(
                color: Colors.white,
                height: 50,
                padding: EdgeInsets.only(left: 10),
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  style: txtTheme(context)
                      .headlineMedium
                      ?.copyWith(color: colorScheme(context).surface),
                  controller: repControlleroller,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter Your New Password again",
                      hintStyle: txtTheme(context)
                          .headlineMedium
                          ?.copyWith(color: colorScheme(context).surface)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
