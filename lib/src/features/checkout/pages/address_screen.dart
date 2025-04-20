import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/checkout/widgets/custom_textfiled_container.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Adding Shipping Address",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextfiledContainer(
                  controller: addressController,
                  text1: "Address",
                  type: TextInputType.text),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                  controller: cityController,
                  text1: "City",
                  type: TextInputType.text),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                  controller: stateController,
                  text1: "State/Province/Region",
                  type: TextInputType.text),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                  controller: zipController,
                  text1: "Zip Code (Postal Code)",
                  type: TextInputType.number),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                  controller: countryController,
                  text1: "Country",
                  type: TextInputType.text),
              SizedBox(height: 200),
              CustomGradientButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.submitorderpage);
                  },
                  buttonText: "SAVE ADDRESS")
            ],
          ),
        ),
      ),
    );
  }
}
