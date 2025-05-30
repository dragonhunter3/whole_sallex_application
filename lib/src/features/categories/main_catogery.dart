import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class MainCategoryPage extends StatefulWidget {
  const MainCategoryPage({super.key});

  @override
  State<MainCategoryPage> createState() => _MainCategoryPageState();
}

class _MainCategoryPageState extends State<MainCategoryPage> {
  late Future<Map<String, Map<String, List<ProductModel>>>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = fetchProductsByCategory();
  }

  Future<Map<String, Map<String, List<ProductModel>>>>
      fetchProductsByCategory() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('products').get();
      final allProducts = snapshot.docs
          .map((doc) {
            try {
              return ProductModel.fromMap(doc.data());
            } catch (e) {
              print('Error parsing document ${doc.id}: $e');
              return null;
            }
          })
          .whereType<ProductModel>()
          .toList();

      final Map<String, Map<String, List<ProductModel>>> grouped = {};

      for (var product in allProducts) {
        final category = product.category;
        final subCategory = product.subCategory;

        grouped.putIfAbsent(category, () => {});
        grouped[category]!.putIfAbsent(subCategory, () => []);
        grouped[category]![subCategory]!.add(product);
      }

      return grouped;
    } catch (e) {
      print('Error fetching products: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, Map<String, List<ProductModel>>>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(
              body: Center(child: Text("Error: ${snapshot.error}")));
        }

        final categoryMap = snapshot.data!;
        if (categoryMap.isEmpty) {
          return const Scaffold(
              body: Center(child: Text("No categories available")));
        }

        final categories = categoryMap.keys.toList();

        return DefaultTabController(
          length: categories.length,
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            appBar: AppBar(
              iconTheme:
                  IconThemeData(color: Theme.of(context).colorScheme.surface),
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              centerTitle: true,
              title: Text(
                "Category",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: [
                IconButton(
                    icon: const Icon(Icons.search_outlined),
                    onPressed: () {
                      context.pushNamed(AppRoute.itemsScreen);
                    }),
              ],
              bottom: TabBar(
                isScrollable: true,
                dividerColor: Theme.of(context).colorScheme.onPrimary,
                unselectedLabelColor: Colors.black,
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                tabs:
                    categories.map((category) => Tab(text: category)).toList(),
              ),
            ),
            body: TabBarView(
              children: categories.map((category) {
                final subCategoryMap = categoryMap[category]!;
                return _buildCategoryView(subCategoryMap);
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryView(Map<String, List<ProductModel>> subCategoryMap) {
    final subCategories = subCategoryMap.keys.toList();

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: subCategories.length,
      itemBuilder: (context, index) {
        final subCategory = subCategories[index];

        return Card(
          elevation: 2,
          color: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            title: Text(
              subCategory,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.surface,
                  ),
            ),
            trailing: Image.asset(
              AppImages.aution,
              height: 50,
              width: 50,
            ),
            onTap: () {
              final products = subCategoryMap[subCategory]!;
              context.pushNamed(AppRoute.itempage, extra: products);
            },
          ),
        );
      },
    );
  }
}
