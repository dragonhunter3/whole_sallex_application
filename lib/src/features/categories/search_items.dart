import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({super.key});

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  List mylist = [
    "Tops",
    "Shirts & Blouses",
    "Cardigans & Sweaters",
    "Cardigans & Sweaters",
    "Cardigans & Sweaters",
    "Cardigans & Sweaters",
    "Cardigans & Sweaters",
    "Cardigans & Sweaters",
    "Cardigans & Sweaters"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorScheme(context).onPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: colorScheme(context).surface),
          backgroundColor: colorScheme(context).onPrimary,
          title: Text("Categories"),
          centerTitle: true,
          titleTextStyle: txtTheme(context).displayMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
          actions: [Icon(Icons.search_outlined), SizedBox(width: 20)],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              CustomGradientButton(
                  onPressed: () {}, buttonText: "VIEW ALL ITEMS"),
              SizedBox(height: 15),
              Text(
                "Categories",
                style: txtTheme(context).headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface.withOpacity(0.5)),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: mylist.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        color: const Color.fromARGB(255, 243, 239, 239),
                        child: ListTile(
                          onTap: () {
                            context.pushNamed(AppRoute.itempage);
                          },
                          contentPadding: EdgeInsets.only(left: 16),
                          title: Text(
                            mylist[index],
                            style: txtTheme(context).headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: colorScheme(context).surface),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
