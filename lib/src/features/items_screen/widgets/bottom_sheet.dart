import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';

class CustomBottom extends StatelessWidget {
  const CustomBottom({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedItemProvider = Provider.of<SelectedItemProvider>(context);
    final item = selectedItemProvider.selectedItem;
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.45,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Select Size",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.13,
                width: MediaQuery.of(context).size.width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: item!.availableSizes.length,
                  itemBuilder: (context, index) {
                    String size = item.availableSizes[index];
                    bool isSelected = selectedItemProvider.selectedSize == size;
                    return GestureDetector(
                      onTap: () {
                        selectedItemProvider.selectSize(size);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: isSelected
                                ? colorScheme(context).primary
                                : Colors.black.withOpacity(0.5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            size,
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              ListTile(
                title: Text("Size Info",
                    style: txtTheme(context).headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface)),
                trailing: Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              ),
              SizedBox(height: 10),
              Consumer<SelectedItemProvider>(
                builder: (context, sizeProvider, child) {
                  return CustomGradientButton(
                    onPressed: () {
                      String? selectedSize = sizeProvider.selectedSize;
                      if (selectedSize != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            "Added $selectedSize to cart",
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).primary),
                          )),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                            "Please select a size",
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).primary),
                          )),
                        );
                      }
                    },
                    buttonText: "ADD TO CART",
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
