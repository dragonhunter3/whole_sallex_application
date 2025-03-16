import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/select_color_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/size_controller.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/bottom_sheet.dart';
import 'package:whole_selle_x_application/src/features/items_screen/widgets/list_of_items.dart';

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    maxRadius: 20,
                    child: Center(
                      child: Icon(
                        Icons.favorite_outline,
                        color: Colors.black.withOpacity(0.4),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
