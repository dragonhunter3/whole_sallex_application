import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/checkout_controller.dart';
import 'package:whole_selle_x_application/src/features/checkout/widgets/add_card_bottom_sheet.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController expireController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final checkoutController = Provider.of<CheckoutController>(context);
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme(context).onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return CustomBottomSheetCard(
                  nameController: nameController,
                  cvvController: cvvController,
                  expireController: expireController,
                  numberController: numberController);
            },
          );
        },
      ),
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Payment Methods",
          style: txtTheme(context).headlineLarge?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Payment Card",
                style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              Card(
                elevation: 0.2,
                color: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(AppImages.card),
                          fit: BoxFit.cover)),
                ),
              ),
              Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    child: Checkbox(
                      value: checkoutController.iChecked,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        checkoutController.checkValue(value!);
                      },
                    ),
                  ),
                  Text(
                    "Use as default payment method",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  )
                ],
              ),
              Card(
                elevation: 0.2,
                color: Colors.white,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          image: AssetImage(AppImages.card2),
                          fit: BoxFit.cover)),
                ),
              ),
              Row(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      checkboxTheme: CheckboxThemeData(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(color: Colors.black, width: 2),
                        ),
                      ),
                    ),
                    child: Checkbox(
                      value: checkoutController.anisChecked,
                      activeColor: Colors.black,
                      onChanged: (value) {
                        checkoutController.ancheckValue(value!);
                      },
                    ),
                  ),
                  Text(
                    "Use as default payment method",
                    style: txtTheme(context).headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
