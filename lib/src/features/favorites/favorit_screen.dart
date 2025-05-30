import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';
import 'package:whole_selle_x_application/src/features/checkout/controller/checkout_controller.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  Future<List<ProductModel>> _fetchFavoriteProducts(
      List<String> favoriteIds) async {
    if (favoriteIds.isEmpty) return [];
    const chunkSize = 10;
    List<ProductModel> products = [];
    for (var i = 0; i < favoriteIds.length; i += chunkSize) {
      final chunk = favoriteIds.sublist(
          i,
          i + chunkSize > favoriteIds.length
              ? favoriteIds.length
              : i + chunkSize);
      final querySnapshot = await FirebaseFirestore.instance
          .collection('products')
          .where(FieldPath.documentId, whereIn: chunk)
          .get();
      products.addAll(querySnapshot.docs
          .map((doc) => ProductModel.fromMap({
                ...doc.data(),
                'id': doc.id,
              }))
          .toList());
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Favorites",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: Consumer<FavoritesProvider>(
        builder: (context, favoritesProvider, child) {
          if (favoritesProvider.favoriteIds.isEmpty) {
            return Center(
              child: Text(
                "No favorites yet!",
                style: txtTheme(context).headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
            );
          }
          return FutureBuilder<List<ProductModel>>(
            future: _fetchFavoriteProducts(favoritesProvider.favoriteIds),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error loading favorites: ${snapshot.error}",
                    style: txtTheme(context).bodyLarge?.copyWith(
                        color: colorScheme(context).surface.withOpacity(0.5)),
                  ),
                );
              }
              final products = snapshot.data ?? [];
              if (products.isEmpty) {
                return Center(
                  child: Text(
                    "No favorite products found.",
                    style: txtTheme(context).headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  ),
                );
              }
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: GestureDetector(
                        onTap: () {
                          context.pushNamed(
                            AppRoute.detailpage,
                            extra: product.id,
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(16),
                          height: MediaQuery.of(context).size.height * 0.23,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: CachedNetworkImage(
                                  imageUrl: product.imageUrl ?? '',
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error, color: Colors.red),
                                  height: 110,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 15),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            product.title,
                                            style: txtTheme(context)
                                                .headlineLarge
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: colorScheme(context)
                                                        .surface),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            try {
                                              await favoritesProvider
                                                  .toggleFavorite(product.id);
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                    content: Text(
                                                        'Error toggling favorite: $e')),
                                              );
                                            }
                                          },
                                          child: Icon(
                                            favoritesProvider
                                                    .isFavorite(product.id)
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 15,
                                            color: favoritesProvider
                                                    .isFavorite(product.id)
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      product.subCategory,
                                      style: txtTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .surface
                                                  .withOpacity(0.5)),
                                    ),
                                    SizedBox(height: 4),
                                    if (product.isBidding)
                                      Text(
                                        "Min: PKR ${product.minPrice ?? product.price}",
                                        style: txtTheme(context)
                                            .bodyLarge
                                            ?.copyWith(
                                                color: colorScheme(context)
                                                    .surface
                                                    .withOpacity(0.5)),
                                      ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Text(
                                          "PKR ${product.price}",
                                          style: txtTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .surface),
                                        ),
                                        SizedBox(width: 30),
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
                                      ],
                                    ),
                                    Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Consumer<CheckoutController>(
                                        builder: (context, checkoutController,
                                            child) {
                                          return GestureDetector(
                                            onTap: () {
                                              try {
                                                checkoutController
                                                    .toggleCheckout(
                                                        int.parse(product.id));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Added to cart!')),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                      content: Text(
                                                          'Error adding to cart: $e')),
                                                );
                                              }
                                            },
                                            child: CircleAvatar(
                                              maxRadius: 15,
                                              backgroundColor:
                                                  colorScheme(context).primary,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                    AppIcons.card),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
