import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/checkout_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final checkoutController = Provider.of<CheckoutController>(context);

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text(
          "Checkout",
          style: txtTheme(context).headlineLarge?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
                // height: MediaQuery.of(context).size.height * 0.8,
                // width: MediaQuery.of(context).size.width,
                child: ListView.builder(
              itemCount: checkoutController.checkoutItems.length,
              itemBuilder: (context, index) {
                int itemIndex = checkoutController.checkoutItems[index];
                return Card(
                  child: Container(
                    decoration: BoxDecoration(
                        color: colorScheme(context).onPrimary,
                        borderRadius: BorderRadius.circular(15)),
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(myItems[itemIndex].image,
                            cacheHeight: 80, cacheWidth: 100),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  myItems[itemIndex].itemName,
                                  style: txtTheme(context)
                                      .headlineSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme(context).surface),
                                ),
                                Icon(Icons.more_vert,
                                    color: Colors.black.withOpacity(0.6),
                                    size: 20)
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Color : ${myItems[itemIndex].selectedSize}",
                                  style: txtTheme(context)
                                      .headlineSmall
                                      ?.copyWith(color: Colors.black),
                                ),
                                Text(
                                  "Price : ${myItems[itemIndex].price}",
                                  style: txtTheme(context)
                                      .headlineSmall
                                      ?.copyWith(color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
