import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/favorites/controller/favorit_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/select_color_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/size_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/bottom_sheet.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class DetailScreenItems extends StatefulWidget {
  const DetailScreenItems({super.key});

  @override
  State<DetailScreenItems> createState() => _DetailScreenItemsState();
}

class _DetailScreenItemsState extends State<DetailScreenItems> {
  @override
  Widget build(BuildContext context) {
    final selectedItemProvider = Provider.of<SelectedItemProvider>(context);
    final selectedColorpro = Provider.of<SelectedColorProvider>(context);
    final favoriteProvider = Provider.of<FavoritesProvider>(context);
    final item = selectedItemProvider.selectedItem;

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text(
          item!.itemName,
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  item.image,
                  cacheHeight: 200,
                  cacheWidth: 200,
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
                        border:
                            Border.all(color: Colors.black.withOpacity(0.4)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Consumer<SizeProvider>(
                            builder: (context, value, child) {
                              return Text(
                                value.selectedSize ?? "null",
                                style: txtTheme(context)
                                    .headlineSmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: colorScheme(context).surface),
                              );
                            },
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
                      border: Border.all(color: Colors.black.withOpacity(0.4)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        dropdownColor: colorScheme(context).onPrimary,
                        value: selectedColorpro.selecteColor,
                        items: colorOfItems,
                        onChanged: (value) {
                          selectedColorpro.setSelectedColor(value!);
                        },
                      ),
                    ),
                  ),
                  Consumer<FavoritesProvider>(
                    builder: (context, favoriteProvider, child) {
                      final isFavorite = favoriteProvider.isFavorite(item.id);
                      return GestureDetector(
                        onTap: () {
                          if (item != null) {
                            favoriteProvider.toggleFavorite(
                                item.id); // Ensure 'id' is an integer
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
                  )
                ],
              ),
              SizedBox(height: 15),
              customRow(item.itemName, item.price),
              Text(
                item.brandName,
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface.withOpacity(0.5)),
              ),
              GestureDetector(
                onTap: () {
                  final selectedItemProvider =
                      Provider.of<SelectedItemProvider>(context, listen: false);
                  selectedItemProvider.setSelectedItem(item);
                  context.pushNamed(AppRoute.ratingpage);
                },
                child: Row(
                  children: [
                    ...item.star,
                    SizedBox(width: 5),
                    Text(
                      item.numberOfIcons,
                      style: txtTheme(context).bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme(context).surface.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
              Text(
                item.comment,
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface.withOpacity(0.6)),
              ),
              SizedBox(height: 10),
              CustomGradientButton(onPressed: () {}, buttonText: "ADD TO CART"),
              SizedBox(height: 15),
              customTile(
                  "Shipping info",
                  Icon(Icons.arrow_forward_ios,
                      size: 15, color: colorScheme(context).surface)),
              SizedBox(height: 10),
              customTile(
                  "Support",
                  Icon(Icons.arrow_forward_ios,
                      size: 15, color: colorScheme(context).surface)),
              SizedBox(height: 15),
              customRow("You can also like this", "12 items"),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myItems.length,
                  itemBuilder: (context, index) {
                    final isFavorite = favoriteProvider.isFavorite(index);
                    return Padding(
                      padding: EdgeInsets.all(2),
                      child: Card(
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    myItems[index].image,
                                    cacheHeight: 140,
                                    cacheWidth: 152,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ...myItems[index].star,
                                            SizedBox(width: 5),
                                            Text(
                                              myItems[index].numberOfIcons,
                                              style: txtTheme(context)
                                                  .bodyLarge
                                                  ?.copyWith(
                                                      color: colorScheme(
                                                              context)
                                                          .surface
                                                          .withOpacity(0.5)),
                                            )
                                          ],
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          myItems[index].brandName,
                                          style: txtTheme(context)
                                              .bodyLarge
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .surface
                                                      .withOpacity(0.3)),
                                        ),
                                        Text(
                                          myItems[index].itemName,
                                          style: txtTheme(context)
                                              .headlineMedium
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .surface),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              myItems[index].price,
                                              style: txtTheme(context)
                                                  .headlineMedium
                                                  ?.copyWith(
                                                      color:
                                                          colorScheme(context)
                                                              .surface),
                                            ),
                                            SizedBox(width: 15),
                                            myItems[index].chatIcon,
                                            SizedBox(width: 15),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  favoriteProvider.toggleFavorite(index);
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
                ),
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
        icon
      ],
    );
  }
}
