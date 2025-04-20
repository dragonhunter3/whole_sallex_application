import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/checkout_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

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
              child: ListView.builder(
                itemCount: checkoutController.checkoutItems.length,
                itemBuilder: (context, index) {
                  int itemIndex = checkoutController.checkoutItems[index];
                  if (itemIndex < -1 || itemIndex >= myItems.length) {
                    return Text("Invalid item index: $itemIndex");
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My ${myItems[itemIndex].itemName}",
                        style: txtTheme(context).headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).surface),
                      ),
                      SizedBox(height: 10),
                      Card(
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
                                  SizedBox(height: 20),
                                  Row(
                                    children: [
                                      Text(
                                        myItems[itemIndex].itemName,
                                        style: txtTheme(context)
                                            .headlineSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colorScheme(context)
                                                    .surface),
                                      ),
                                      SizedBox(width: 100),
                                      GestureDetector(
                                        onTap: () => showDialog(
                                          context: context,
                                          builder: (context) => Dialog(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              height: 100,
                                              width: 150,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "Add to Favourit",
                                                    style: txtTheme(context)
                                                        .headlineSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: colorScheme(
                                                                    context)
                                                                .surface),
                                                  ),
                                                  SizedBox(height: 15),
                                                  Text(
                                                    "Delete From The List",
                                                    style: txtTheme(context)
                                                        .headlineSmall
                                                        ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: colorScheme(
                                                                    context)
                                                                .surface),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        child: Icon(Icons.more_vert,
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            size: 20),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Size : ${myItems[itemIndex].selectedSize}",
                                        style: txtTheme(context)
                                            .headlineSmall
                                            ?.copyWith(color: Colors.black),
                                      ),
                                      SizedBox(width: 40),
                                      Text(
                                        "Color : ${myItems[itemIndex].selectedColor}",
                                        style: txtTheme(context)
                                            .headlineSmall
                                            ?.copyWith(color: Colors.black),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.remove,
                                          size: 15,
                                          color: colorScheme(context).surface,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        "1",
                                        style: txtTheme(context)
                                            .headlineMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colorScheme(context)
                                                    .surface),
                                      ),
                                      SizedBox(width: 10),
                                      CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.add,
                                          size: 15,
                                          color: colorScheme(context).surface,
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                      Text(
                                        myItems[itemIndex].price,
                                        style: txtTheme(context)
                                            .headlineSmall
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: colorScheme(context)
                                                    .surface),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            CustomGradientButton(
                onPressed: () {
                  context.pushNamed(AppRoute.addpayment);
                },
                buttonText: "CHECK OUT")
          ],
        ),
      ),
    );
  }
}
