import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/checkout/widgets/custom_textfiled_container.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  Future<void> _saveAddress() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('addresses').add({
          'address': addressController.text.trim(),
          'city': cityController.text.trim(),
          'state': stateController.text.trim(),
          'zipCode': zipController.text.trim(),
          'country': countryController.text.trim(),
          'addedAt': FieldValue.serverTimestamp(),
        });

        context.pushNamed(AppRoute.submitorderpage);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Address saved successfully!')),
        );

        addressController.clear();
        cityController.clear();
        stateController.clear();
        zipController.clear();
        countryController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving address: $e')),
        );
      }
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    cityController.dispose();
    stateController.dispose();
    zipController.dispose();
    countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).primary),
        title: Text(
          "Add Shipping Address",
          style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).primary,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextfiledContainer(
                controller: addressController,
                text1: "Address",
                type: TextInputType.text,
              ),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                controller: cityController,
                text1: "City",
                type: TextInputType.text,
              ),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                controller: stateController,
                text1: "State/Province/Region",
                type: TextInputType.text,
              ),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                controller: zipController,
                text1: "Zip Code (Postal Code)",
                type: TextInputType.number,
              ),
              SizedBox(height: 15),
              CustomTextfiledContainer(
                controller: countryController,
                text1: "Country",
                type: TextInputType.text,
              ),
              SizedBox(height: 30),
              CustomGradientButton(
                onPressed: _saveAddress,
                buttonText: "SAVE ADDRESS",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
