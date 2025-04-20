import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});

  @override
  State<MainCategoryPage> createState() => _MainCategoryPageState();
}

class _MainCategoryPageState extends State<MainCategoryPage> {
  final List<String> categories = [
    "Men",
    "Women",
    "Children",
    "Electronics",
    "Furniture & Home Decor",
    "Health & Beauty",
    "Pharmaceuticals & Medical Supplies"
  ];

  final Map<String, List<String>> categoryItems = {
    "Men": ["New", "Shoes", "Clothes", "Accessories"],
    "Women": ["Dresses", "Handbags", "Jewelry", "Makeup"],
    "Children": ["Toys", "Clothing", "School Supplies", "Games"],
    "Electronics": ["Smartphones", "Power Banks", "Earphones", "Smartwatches"],
    "Furniture & Home Decor": ["Sofa", "Bed", "Dining Tables", "Office Chairs"],
    "Health & Beauty": ["Skincare", "Hair Care", "Makeup", "Wellness"],
    "Pharmaceuticals & Medical Supplies": [
      "Medical Equipment",
      "Medicines",
      "First Aid",
      "Health Monitoring"
    ]
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: colorScheme(context).onPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorScheme(context).surface),
          backgroundColor: colorScheme(context).onPrimary,
          centerTitle: true,
          title: Text(
            "Category",
            style: txtTheme(context).displayMedium?.copyWith(
                  color: colorScheme(context).surface,
                  fontWeight: FontWeight.bold,
                ),
          ),
          actions: [
            GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.itemsScreen);
                },
                child: Icon(Icons.search_outlined)),
            SizedBox(width: 20),
          ],
          bottom: TabBar(
            isScrollable: true,
            dividerColor: colorScheme(context).onPrimary,
            unselectedLabelColor: Colors.black,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            tabs: categories.map((category) => Tab(text: category)).toList(),
          ),
        ),
        body: TabBarView(
          children: categories
              .map((category) => _buildCategoryView(categoryItems[category]!))
              .toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryView(List<String> items) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            width: MediaQuery.of(context).size.width,
            color: colorScheme(context).primary,
            child: Center(
              child: Text(
                "Summer Sales",
                style: txtTheme(context).displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).onPrimary,
                    ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => context.pushNamed(AppRoute.itempage),
                  child: Card(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.white,
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            items[index],
                            style: txtTheme(context).displayMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: colorScheme(context).surface,
                                ),
                          ),
                          Image.asset(
                            AppImages.aution,
                            cacheHeight: 70,
                            cacheWidth: 70,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
