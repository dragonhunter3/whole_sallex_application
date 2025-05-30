import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

class SelectedOrderDetail extends StatefulWidget {
  const SelectedOrderDetail({super.key});

  @override
  State<SelectedOrderDetail> createState() => _SelectedOrderDetailState();
}

class _SelectedOrderDetailState extends State<SelectedOrderDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Detail Screen",
          style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface,
              ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              customRow("Order №1947034", "05-12-2019"),
              SizedBox(width: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text("Tracking Number",
                            style: txtTheme(context).headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context)
                                    .surface
                                    .withOpacity(0.3))),
                        SizedBox(width: 10),
                        Text("IW3475453455",
                            style: txtTheme(context).headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface)),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Text("Delivered",
                      style: txtTheme(context).headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
              SizedBox(width: 15),
              Text("3 Item",
                  style: txtTheme(context).headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                    itemCount: 3,
                    itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: customMyContainer(
                              AppImages.anothershirt,
                              "Pullover",
                              "Mango",
                              "Color:",
                              "Grey",
                              "size:",
                              "l",
                              "Unit",
                              "1",
                              "\$32"),
                        )),
              ),
              SizedBox(height: 10),
              Text("Order Information",
                  style: txtTheme(context).headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface)),
              SizedBox(height: 15),
              customRow("Shipping Address",
                  "3 Newbridge Court ,Chino Hills, \nCA 91709, United States"),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Payment method: ",
                      style: txtTheme(context).headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface)),
                  SizedBox(
                    child: Row(
                      children: [
                        Image.asset(
                          AppImages.mastercard1,
                          cacheHeight: 40,
                          cacheWidth: 50,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "**** **** **** 3947",
                          style: txtTheme(context).headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context)
                                  .surface
                                  .withOpacity(0.3)),
                        )
                      ],
                    ),
                  )
                ],
              ),
              customRow("Delivery method:", "FedEx, 3 days, \$15"),
              SizedBox(height: 10),
              customRow("Discount:", "10%, Personal promo code"),
              SizedBox(height: 10),
              customRow("Total Amount:", "\$33"),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget customRow(String text1, String text2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1,
            style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface)),
        Text(text2,
            style: txtTheme(context).headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface.withOpacity(0.3)))
      ],
    );
  }

  Widget customMyContainer(
      String image,
      String text1,
      String brand,
      String color,
      String colorg,
      String size,
      String sizl,
      String unit,
      String unitnum,
      String price) {
    return Container(
      color: Colors.white,
      height: 120,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Image.asset(
            image,
            cacheHeight: 120,
            cacheWidth: 150,
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(text1,
                  style: txtTheme(context).headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface)),
              SizedBox(height: 10),
              Text(brand,
                  style: txtTheme(context).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface.withOpacity(0.3))),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text("$color: ",
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context)
                                    .surface
                                    .withOpacity(0.3))),
                        Text(colorg,
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface)),
                      ],
                    ),
                  ),
                  SizedBox(width: 30),
                  SizedBox(
                    child: Row(
                      children: [
                        Text("$size: ",
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context)
                                    .surface
                                    .withOpacity(0.3))),
                        Text(sizl,
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface)),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Text("$unit: ",
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context)
                                    .surface
                                    .withOpacity(0.3))),
                        Text(unitnum,
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface)),
                      ],
                    ),
                  ),
                  SizedBox(width: 80),
                  Text(price,
                      style: txtTheme(context).headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface)),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
