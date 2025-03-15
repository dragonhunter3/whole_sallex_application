import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/categories/widgets/custom_container.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/filter_controller.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Color> colorsList = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
  ];
  List sizes = ["XS", "S", "M", "L", "XL"];
  List catogeries = ["All", "Women", "Men", "Boys", "Girls"];
  @override
  Widget build(BuildContext context) {
    FilterController setrange = Provider.of<FilterController>(context);
    final List<String> selectedBrands =
        GoRouterState.of(context).extra as List<String>? ?? [];

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text("Filters"),
        titleTextStyle: txtTheme(context).displayMedium?.copyWith(
            fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Price Range",
              style: txtTheme(context).headlineMedium?.copyWith(
                  color: colorScheme(context).surface,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${setrange.startPrice.toInt()}",
                  style: txtTheme(context)
                      .headlineMedium
                      ?.copyWith(color: colorScheme(context).surface),
                ),
                Text(
                  "\$${setrange.endPrice.toInt()}",
                  style: txtTheme(context)
                      .headlineMedium
                      ?.copyWith(color: colorScheme(context).surface),
                ),
              ],
            ),
            RangeSlider(
              values: RangeValues(setrange.startPrice, setrange.endPrice),
              min: setrange.minPrice,
              max: setrange.maxPrice,
              divisions: (setrange.maxPrice - setrange.minPrice).toInt(),
              labels: RangeLabels(
                "\$${setrange.startPrice.toInt()}",
                "\$${setrange.endPrice.toInt()}",
              ),
              onChanged: (RangeValues values) {
                setrange.updateRange(values.start, values.end);
              },
              activeColor: colorScheme(context).primary,
              inactiveColor: Colors.grey[300],
            ),
            Text(
              "Colors",
              style: txtTheme(context)
                  .headlineMedium
                  ?.copyWith(color: colorScheme(context).surface),
            ),
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Consumer<FilterController>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colorsList.length,
                      itemBuilder: (context, index) {
                        bool isSelected = index == value.selectedIndex;
                        return Padding(
                          padding: const EdgeInsets.all(8),
                          child: CustomContainer(
                            bordercolor: isSelected
                                ? colorScheme(context).primary
                                : Colors.grey,
                            color: colorsList[index],
                            ontap: () {
                              value.selectIndex(index);
                            },
                          ),
                        );
                      },
                    );
                  },
                )),
            SizedBox(height: 15),
            Text(
              "Sizes",
              style: txtTheme(context)
                  .headlineMedium
                  ?.copyWith(color: colorScheme(context).surface),
            ),
            SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: Consumer<FilterController>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sizes.length,
                      itemBuilder: (context, index) {
                        bool isSelected = value.selecIndex.contains(index);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              value.toggleSelection(index);
                            },
                            child: Container(
                              height: 50,
                              width: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                                color: isSelected
                                    ? colorScheme(context)
                                        .primary
                                        .withOpacity(0.8)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(sizes[index],
                                    style: txtTheme(context)
                                        .headlineSmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).surface)),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
            Text(
              "Category",
              style: txtTheme(context)
                  .headlineMedium
                  ?.copyWith(color: colorScheme(context).surface),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.18,
                width: MediaQuery.of(context).size.width,
                child: Consumer<FilterController>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      itemCount: catogeries.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 2),
                      itemBuilder: (context, index) {
                        bool isSelected =
                            value.selectedCategoryIndex.contains(index);

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              value.toggleCategory(index);
                            },
                            child: Container(
                              height: 50,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                                color: isSelected
                                    ? colorScheme(context)
                                        .primary
                                        .withOpacity(0.8)
                                    : Colors.white,
                              ),
                              child: Center(
                                child: Text(catogeries[index],
                                    style: txtTheme(context)
                                        .headlineSmall
                                        ?.copyWith(
                                            color:
                                                colorScheme(context).surface)),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                )),
            ListTile(
              onTap: () {
                context.pushNamed(AppRoute.brandpage);
              },
              title: Text(
                "Brand",
                style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              subtitle: Text(
                selectedBrands.isNotEmpty
                    ? selectedBrands.join(", ")
                    : "No brands selected",
                style: txtTheme(context).bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.black,
                size: 15,
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 40,
                    width: 130,
                    child: CustomGradientButton(
                        onPressed: () {}, buttonText: "Discard")),
                SizedBox(
                    height: 40,
                    width: 130,
                    child: CustomGradientButton(
                        onPressed: () {}, buttonText: "Apply")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
