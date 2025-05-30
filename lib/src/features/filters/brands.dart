import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/brand_controller.dart';
import 'package:whole_selle_x_application/src/features/filters/controllers/filter_controller.dart';

class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  TextEditingController controller = TextEditingController();
  List brandlist = [
    "Adidas",
    "adidas Orignal",
    "Blend",
    "Boutique Moschino",
    "Champion",
    "Diesel",
    "Jack & Jones",
    "Naf Naf",
    "Red Valentino",
    "s.Oliver"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Brands",
          style: txtTheme(context).displayMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              height: MediaQuery.of(context).size.height * 0.06,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: txtTheme(context).headlineSmall?.copyWith(
                        color: colorScheme(context).surface.withOpacity(0.5)),
                    prefixIcon: Icon(
                      Icons.search_outlined,
                      color: Colors.black.withOpacity(0.6),
                    )),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Consumer<FilterController>(
                builder: (context, brandProvider, child) {
                  return ListView.builder(
                    itemCount: brandlist.length,
                    itemBuilder: (context, index) {
                      final brand = brandlist[index];
                      final isSelected = brandProvider.isSelected(brand);

                      return Card(
                        child: InkWell(
                          onTap: () => brandProvider.toggleBrand(brand),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white, // Change color when selected
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(brand,
                                    style: txtTheme(context)
                                        .headlineSmall
                                        ?.copyWith(
                                            color: isSelected
                                                ? colorScheme(context).primary
                                                : colorScheme(context)
                                                    .surface)),
                                Checkbox(
                                  value: isSelected,
                                  onChanged: (value) =>
                                      brandProvider.toggleBrand(brand),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 40,
                    width: 130,
                    child: CustomGradientButton(
                        onPressed: () {
                          context.pop();
                        },
                        buttonText: "Discard")),
                SizedBox(
                    height: 40,
                    width: 130,
                    child: CustomGradientButton(
                        onPressed: () {
                          final selectedBrands = Provider.of<BrandController>(
                                  context,
                                  listen: false)
                              .selectedBrands;
                          context.push('/nextScreen', extra: selectedBrands);
                        },
                        buttonText: "Apply")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
