import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/checkoutprovider.dart';

class AddPaymentMethod extends StatefulWidget {
  const AddPaymentMethod({super.key});

  @override
  State<AddPaymentMethod> createState() => _AddPaymentMethodState();
}

class _AddPaymentMethodState extends State<AddPaymentMethod> {
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  final expireController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final checkoutProvider = Provider.of<CheckoutP>(context);

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme(context).onPrimary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Icon(Icons.add, color: Colors.black),
        onPressed: () {
          // showModalBottomSheet(
          //   isScrollControlled: true,
          //   context: context,
          //   builder: (context) {
          //     return CustomBottomSheetCard();
          //   },
          // );
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
      body: Padding(
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
            SizedBox(height: 16),
            _buildCardWithCheckbox(
              context: context,
              cardIndex: 0,
              imagePath: AppImages.card,
              controller: checkoutProvider,
            ),
            SizedBox(height: 16),
            _buildCardWithCheckbox(
              context: context,
              cardIndex: 1,
              imagePath: AppImages.card2,
              controller: checkoutProvider,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWithCheckbox({
    required BuildContext context,
    required int cardIndex,
    required String imagePath,
    required CheckoutP controller,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            controller.selectCard(cardIndex);
          },
          child: Card(
            elevation: 0.2,
            color: controller.isCardSelected(cardIndex)
                ? Colors.grey.shade300
                : Colors.white,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                value: controller.isCardSelected(cardIndex),
                activeColor: Colors.black,
                onChanged: (value) {
                  controller.selectCard(value == true ? cardIndex : null);
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
    );
  }
}
