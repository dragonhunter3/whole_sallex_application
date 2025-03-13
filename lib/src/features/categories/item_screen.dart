import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/categories/controller/sort_controller.dart';
import 'package:whole_selle_x_application/src/features/categories/widgets/custom_bottom_sheet.dart';

class ItemScreenPage extends StatefulWidget {
  const ItemScreenPage({super.key});

  @override
  State<ItemScreenPage> createState() => _ItemScreenPageState();
}

class _ItemScreenPageState extends State<ItemScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        actions: [Icon(Icons.search_outlined), SizedBox(width: 15)],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Women’s tops",
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
                          "T-shirts",
                          style: txtTheme(context)
                              .headlineSmall
                              ?.copyWith(color: colorScheme(context).onPrimary),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 10);
                  },
                  itemCount: 6),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(AppIcons.filter),
                      Text("Filter",
                          style: txtTheme(context)
                              .headlineMedium
                              ?.copyWith(color: colorScheme(context).surface)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: Row(
                    children: [
                      SvgPicture.asset(AppIcons.data),
                      SizedBox(width: 7),
                      Consumer<SortProvider>(
                          builder: (context, SortProvider, child) {
                        return Text(SortProvider.selectedSort,
                            style: txtTheme(context).headlineMedium?.copyWith(
                                color: colorScheme(context).surface));
                      })
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
                itemCount: 6,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7, crossAxisCount: 2),
                itemBuilder: (context, index) {
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
                                  AppImages.photo,
                                  cacheHeight: 140,
                                  cacheWidth: 152,
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Icon(
                                      Icons.star,
                                      color: colorScheme(context)
                                          .primary
                                          .withOpacity(0.5),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: colorScheme(context)
                                          .primary
                                          .withOpacity(0.5),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: colorScheme(context)
                                          .primary
                                          .withOpacity(0.5),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: colorScheme(context)
                                          .primary
                                          .withOpacity(0.5),
                                      size: 15,
                                    ),
                                    Icon(
                                      Icons.star_outline,
                                      size: 15,
                                    ),
                                    SizedBox(width: 5),
                                    Text(
                                      "(3)",
                                      style: txtTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .surface
                                                  .withOpacity(0.3)),
                                    )
                                  ],
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "Mango",
                                      style: txtTheme(context)
                                          .bodyLarge
                                          ?.copyWith(
                                              color: colorScheme(context)
                                                  .surface
                                                  .withOpacity(0.3)),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Text(
                                      "T-Shirt SPANISH",
                                      style: txtTheme(context)
                                          .headlineMedium
                                          ?.copyWith(
                                              color:
                                                  colorScheme(context).surface),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "PKR 500",
                                      style: txtTheme(context)
                                          .headlineMedium
                                          ?.copyWith(
                                              color:
                                                  colorScheme(context).surface),
                                    ),
                                    SizedBox(width: 15),
                                    Icon(
                                      Icons.chat_outlined,
                                      size: 20,
                                      color: colorScheme(context)
                                          .surface
                                          .withOpacity(0.3),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                              backgroundColor: colorScheme(context).onPrimary,
                              radius: 15,
                              child: Center(
                                child: Icon(
                                  Icons.favorite_outline,
                                  size: 15,
                                  color: colorScheme(context)
                                      .surface
                                      .withOpacity(0.3),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
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
