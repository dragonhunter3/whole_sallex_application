import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({super.key});

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Shipping Address",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.pushNamed(AppRoute.addresspage);
          },
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Icon(Icons.add, color: Colors.black)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            customAddressContainer(
                "3 Newbridge Court \nChino Hills, CA 91709, United States",
                true,
                () {}),
            SizedBox(height: 20),
            customAddressContainer(
                "3 Newbridge Court \nChino Hills, CA 91709, United States",
                false,
                () {}),
            SizedBox(height: 20),
            customAddressContainer(
                "3 Newbridge Court \nChino Hills, CA 91709, United States",
                false,
                () {})
          ],
        ),
      ),
    );
  }

  Widget customAddressContainer(
      String text1, bool value, VoidCallback finction) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                text1,
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              TextButton(
                  onPressed: finction,
                  child: Text(
                    "Edit",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).primary),
                  )),
            ],
          ),
          Row(
            children: [
              Checkbox(
                value: value,
                onChanged: (value) {},
              ),
              SizedBox(width: 30),
              Text(
                "Use as the shipping address",
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              )
            ],
          )
        ],
      ),
    );
  }
}
