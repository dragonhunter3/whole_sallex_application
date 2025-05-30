import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Order Detail Screens",
          style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface,
              ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Orders",
              style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface,
                  ),
            ),
            const SizedBox(height: 16),
            TabBar(
              controller: controller,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(
                    width: 4.0, color: Colors.red), // 👈 selected tab line
                insets: EdgeInsets.symmetric(horizontal: 16),
              ),
              indicatorSize: TabBarIndicatorSize.label,
              overlayColor:
                  MaterialStateProperty.all(colorScheme(context).onPrimary),
              tabs: [
                _buildTab(context, "Delivered"),
                _buildTab(context, "Processing"),
                _buildTab(context, "Cancel"),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: controller,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customContainer(
                            "Order №1947034",
                            "05-12-2019",
                            "Tracking number:",
                            "IW3475453455",
                            "Quantity:",
                            "3",
                            "Amount:",
                            "\$345",
                            "Details",
                            "Delivered", () {
                          context.pushNamed(AppRoute.selectedorder);
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customContainer(
                            "Order №1947034",
                            "05-12-2019",
                            "Tracking number:",
                            "IW3475453455",
                            "Quantity:",
                            "3",
                            "Amount:",
                            "\$345",
                            "Details",
                            "Processing", () {
                          context.pushNamed(AppRoute.selectedorder);
                        }),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: customContainer(
                            "Order №1947034",
                            "05-12-2019",
                            "Tracking number:",
                            "IW3475453455",
                            "Quantity:",
                            "3",
                            "Amount:",
                            "\$345",
                            "Details",
                            "Cancel", () {
                          context.pushNamed(AppRoute.selectedorder);
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(BuildContext context, String title) {
    return Tab(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            title,
            style: txtTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).surface,
                ),
          ),
        ),
      ),
    );
  }

  Widget customContainer(
      String title,
      String date,
      String tracking,
      String tarckingnum,
      String qut,
      String qutnum,
      String amount,
      String amountpri,
      String b1,
      String b2,
      VoidCallback function) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 200,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              Text(
                date,
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface.withOpacity(0.3)),
              )
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text(
                tracking,
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface.withOpacity(0.3)),
              ),
              SizedBox(width: 20),
              Text(tarckingnum,
                  style: txtTheme(context).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface))
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      qut,
                      style: txtTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface.withOpacity(0.3)),
                    ),
                    SizedBox(width: 20),
                    Text(qutnum,
                        style: txtTheme(context).headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).surface))
                  ],
                ),
              ),
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      amount,
                      style: txtTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface.withOpacity(0.3)),
                    ),
                    SizedBox(width: 20),
                    Text(amountpri,
                        style: txtTheme(context).headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).surface))
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: function,
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: colorScheme(context).surface),
                  ),
                  child: Center(
                      child: Text(b1,
                          style: txtTheme(context).headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: colorScheme(context).surface))),
                ),
              ),
              Text(b2,
                  style: txtTheme(context).headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.green))
            ],
          )
        ],
      ),
    );
  }
}
