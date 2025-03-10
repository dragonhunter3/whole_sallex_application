import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});

  @override
  State<MainCategoryPage> createState() => _MainCategoryPageState();
}

class _MainCategoryPageState extends State<MainCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        backgroundColor: colorScheme(context).onPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorScheme(context).surface),
          backgroundColor: colorScheme(context).onPrimary,
          title: Text(
            "Category",
            style: txtTheme(context).displayMedium?.copyWith(
                  color: colorScheme(context).surface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          bottom: const TabBar(
            isScrollable: true,
            unselectedLabelColor: Colors.black,
            dividerColor: Color.fromARGB(255, 236, 234, 234),
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: "Men"),
              Tab(text: "Women"),
              Tab(text: "Children"),
              Tab(text: "Electronics"),
              Tab(text: "Furniture & Home Decor"),
              Tab(text: "Health & Beauty"),
              Tab(text: "Pharmaceuticals & Medical Supplies"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            Center(child: Text("Women Category")),
            Center(child: Text("Children Category")),
            Center(child: Text("Electronics Category")),
            Center(child: Text("Furniture & Home Decor Category")),
            Center(child: Text("Health & Beauty Category")),
            Center(child: Text("Pharmaceuticals & Medical Supplies Category")),
          ],
        ),
      ),
    );
  }
}
