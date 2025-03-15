import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

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
      body: favoritesProvider.favoriteItems.isEmpty
          ? Center(
              child: Text("No favorites yet!",
                  style: txtTheme(context).headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface)),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: favoritesProvider.favoriteItems.length,
                    itemBuilder: (context, index) {
                      int itemIndex = favoritesProvider.favoriteItems[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Container(
                              padding: EdgeInsets.all(16),
                              height: MediaQuery.of(context).size.height * 0.23,
                              width: MediaQuery.of(context).size.width * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    child: Image.asset(
                                      myItems[itemIndex].image,
                                      height: 110,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              myItems[itemIndex].itemName,
                                              style: txtTheme(context)
                                                  .headlineLarge
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          colorScheme(context)
                                                              .surface),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                favoritesProvider
                                                    .toggleFavorite(itemIndex);
                                              },
                                              child: Icon(
                                                Icons.close,
                                                size: 15,
                                                color: Colors.grey,
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          myItems[index].brandName,
                                          style: txtTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .surface
                                                      .withOpacity(0.5)),
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Color: blue",
                                                style: txtTheme(context)
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: colorScheme(
                                                                context)
                                                            .surface
                                                            .withOpacity(0.5))),
                                            Text("Size: L",
                                                style: txtTheme(context)
                                                    .bodyLarge
                                                    ?.copyWith(
                                                        color: colorScheme(
                                                                context)
                                                            .surface
                                                            .withOpacity(0.5))),
                                            SizedBox(width: 10)
                                          ],
                                        ),
                                        SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Text(
                                              "Price :${myItems[index].price}",
                                              style: txtTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme(context)
                                                              .surface),
                                            ),
                                            SizedBox(width: 30),
                                            ...myItems[index].star,
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: GestureDetector(
                                            child: CircleAvatar(
                                              maxRadius: 15,
                                              backgroundColor:
                                                  colorScheme(context).primary,
                                              child: Center(
                                                child: SvgPicture.asset(
                                                    AppIcons.card),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
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
