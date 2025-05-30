import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/categories/controller/sort_controller.dart';
import 'package:whole_selle_x_application/src/features/categories/model/model.dart';
import 'package:whole_selle_x_application/src/features/categories/widgets/custom_bottom_sheet.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class ItemScreenPage extends StatelessWidget {
  final List<ProductModel> products;
  const ItemScreenPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        actions: [Icon(Icons.search_outlined), SizedBox(width: 15)],
      ),
      body: products.isEmpty
          ? const Center(child: Text("No products available"))
          : Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    products[0].subCategory,
                    style: txtTheme(context).displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  ),
                  SizedBox(height: 15),
                  SizedBox(
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: colorScheme(context).surface,
                            ),
                            child: Center(
                              child: Text(
                                products[index].subCategory,
                                style: txtTheme(context)
                                    .headlineSmall
                                    ?.copyWith(
                                        color: colorScheme(context).onPrimary),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 10);
                        },
                        itemCount: products.length),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          context.pushNamed(AppRoute.filterpage);
                        },
                        child: SizedBox(
                          width: 70,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(AppIcons.filter),
                              Text("Filter",
                                  style: txtTheme(context)
                                      .headlineMedium
                                      ?.copyWith(
                                          color: colorScheme(context).surface)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 160,
                        child: Row(
                          children: [
                            SvgPicture.asset(AppIcons.data),
                            SizedBox(width: 7),
                            Consumer<SortProvider>(
                                builder: (context, sortProvider, child) {
                              return Text(sortProvider.selectedSort,
                                  style: txtTheme(context)
                                      .headlineMedium
                                      ?.copyWith(
                                          color: colorScheme(context).surface));
                            }),
                          ],
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CustomBottomSheet();
                              },
                            );
                          },
                          child: SvgPicture.asset(AppIcons.view))
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      itemCount: products.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: 0.7, crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Consumer<FavoritesProvider>(
                          builder: (context, favoritesProvider, child) {
                            final isFavorite = favoritesProvider
                                .isFavorite(products[index].id);
                            return Padding(
                              padding: EdgeInsets.all(2),
                              child: Card(
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        final selectedItemProvider =
                                            Provider.of<SelectedItemProvider>(
                                                context,
                                                listen: false);
                                        selectedItemProvider
                                            .setSelectedItem(myItems[index]);

                                        context.pushNamed(
                                          AppRoute.detailpage,
                                          extra: products[index].id,
                                        );
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: Colors.white,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CachedNetworkImage(
                                              imageUrl:
                                                  products[index].imageUrl!,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      Icons.error,
                                                      color: Colors.red),
                                              fit: BoxFit.cover,
                                              height: 130,
                                              width: double.infinity,
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      ...myItems[index].star,
                                                      SizedBox(width: 5),
                                                      Text(
                                                        products[index]
                                                            .rating
                                                            .toString(),
                                                        style: txtTheme(context)
                                                            .bodyLarge
                                                            ?.copyWith(
                                                                color: colorScheme(
                                                                        context)
                                                                    .surface
                                                                    .withOpacity(
                                                                        0.5)),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(height: 5),
                                                  Text(
                                                    products[index].title,
                                                    style: txtTheme(context)
                                                        .headlineMedium
                                                        ?.copyWith(
                                                            color: colorScheme(
                                                                    context)
                                                                .surface),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "PKR ${products[index].price.toString()}",
                                                        style: txtTheme(context)
                                                            .headlineMedium
                                                            ?.copyWith(
                                                                color: colorScheme(
                                                                        context)
                                                                    .surface),
                                                      ),
                                                      GestureDetector(
                                                          onTap: () {
                                                            context.pushNamed(
                                                                AppRoute
                                                                    .chatUsers);
                                                          },
                                                          child: myItems[index]
                                                              .chatIcon),
                                                      SizedBox(width: 15),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: GestureDetector(
                                        onTap: () async {
                                          try {
                                            await favoritesProvider
                                                .toggleFavorite(
                                                    products[index].id);
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      'Error toggling favorite: $e')),
                                            );
                                          }
                                        },
                                        child: CircleAvatar(
                                          backgroundColor:
                                              colorScheme(context).onPrimary,
                                          radius: 15,
                                          child: Icon(
                                            isFavorite
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 15,
                                            color: isFavorite
                                                ? Colors.red
                                                : colorScheme(context)
                                                    .surface
                                                    .withOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
