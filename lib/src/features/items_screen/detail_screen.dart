import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/product_provider.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/bottom_sheet.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class DetailScreenItems extends StatefulWidget {
  final String productId;
  const DetailScreenItems({super.key, required this.productId});

  @override
  State<DetailScreenItems> createState() => _DetailScreenItemsState();
}

class _DetailScreenItemsState extends State<DetailScreenItems> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProController>(context, listen: false)
          .fetchProductById(widget.productId);
    });
  }

  Future<void> _addToCart(
      ProductModel product, String? selectedSize, String? selectedColor) async {
    try {
      await FirebaseFirestore.instance
          .collection('cardProduct')
          .doc(product.id)
          .set({
        ...product.toMap(),
        'selectedSize': selectedSize,
        'selectedColor': selectedColor,
        'addedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to add to cart: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProController>(context);
    final product = controller.product;
    final selectedItemProvider = Provider.of<SelectedItemProvider>(context);
    final item = selectedItemProvider.selectedItem;

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text(
          product?.title ?? '',
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: product == null
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CachedNetworkImage(
                        imageUrl: product.imageUrl!,
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error, color: Colors.red),
                        fit: BoxFit.cover,
                        height: 130,
                        width: double.infinity,
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return CustomBottom();
                              },
                            );
                          },
                          child: Container(
                            height: 40,
                            width: 100,
                            padding: EdgeInsets.only(left: 16, right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.4)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  selectedItemProvider
                                          .selectedItem?.selectedSize ??
                                      "L",
                                  style: txtTheme(context)
                                      .headlineSmall
                                      ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme(context).surface),
                                ),
                                Icon(
                                  Icons.arrow_drop_down_outlined,
                                  color: Colors.black.withOpacity(0.7),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 150,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.4)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: colorScheme(context).onPrimary,
                              value: selectedItemProvider
                                  .selecteColor, // Typo: should be selectedColor
                              isExpanded: true,
                              items: item!.availableColors.map((String color) {
                                return DropdownMenuItem<String>(
                                  value: color,
                                  child: Text(
                                    color,
                                    style: txtTheme(context)
                                        .headlineSmall
                                        ?.copyWith(
                                          color: colorScheme(context).surface,
                                        ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                selectedItemProvider.setSelectedColor(value!);
                              },
                            ),
                          ),
                        ),
                        Consumer<FavoritesProvider>(
                          builder: (context, favoritesProvider, child) {
                            final isFavorite =
                                favoritesProvider.isFavorite(product.id);
                            return GestureDetector(
                              onTap: () async {
                                try {
                                  await favoritesProvider
                                      .toggleFavorite(product.id);
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Error toggling favorite: $e')),
                                  );
                                }
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 20,
                                child: Center(
                                  child: Icon(
                                    isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: isFavorite
                                        ? Colors.red
                                        : Colors.black.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    customRow(product.title, "PKR ${product.price}"),
                    Text(
                      product.subCategory, // Replaced item.brandName
                      style: txtTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface.withOpacity(0.5)),
                    ),
                    GestureDetector(
                      onTap: () {
                        final selectedItemProvider =
                            Provider.of<SelectedItemProvider>(context,
                                listen: false);
                        selectedItemProvider.setSelectedItem(item);
                        context.pushNamed(AppRoute.ratingpage);
                      },
                      child: Row(
                        children: [
                          if (product.rating != null)
                            Row(
                              children: List.generate(
                                product.rating!,
                                (_) => Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.amber,
                                ),
                              ),
                            ),
                          SizedBox(width: 5),
                          Text(
                            product.rating?.toString() ?? '0',
                            style: txtTheme(context).bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context)
                                    .surface
                                    .withOpacity(0.5)),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      product.description,
                      style: txtTheme(context).headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface.withOpacity(0.6)),
                    ),
                    SizedBox(height: 10),
                    CustomGradientButton(
                      onPressed: () async {
                        try {
                          await _addToCart(
                            product,
                            selectedItemProvider.selectedItem?.selectedSize,
                            selectedItemProvider.selecteColor,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to cart!')),
                          );
                          context.pushNamed(AppRoute.checkoutpage);
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error adding to cart: $e')),
                          );
                        }
                      },
                      buttonText: "ADD TO CART",
                    ),
                    SizedBox(height: 15),
                    customTile(
                      "Shipping info",
                      Icon(Icons.arrow_forward_ios,
                          size: 15, color: colorScheme(context).surface),
                    ),
                    SizedBox(height: 10),
                    customTile(
                      "Support",
                      Icon(Icons.arrow_forward_ios,
                          size: 15, color: colorScheme(context).surface),
                    ),
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
        Text(
          text1,
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        Text(
          text2,
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
      ],
    );
  }

  Widget customTile(String text1, Icon icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text1,
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        icon,
      ],
    );
  }
}
