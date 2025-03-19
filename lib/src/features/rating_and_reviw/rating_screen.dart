import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/features/items_screen/controller/items_controller.dart';
import 'package:whole_selle_x_application/src/features/rating_and_reviw/controller.dart/checking_controller.dart';
import 'package:whole_selle_x_application/src/features/rating_and_reviw/widgets/rating_bottom_sheet.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key});

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedItemProvider = Provider.of<SelectedItemProvider>(context);
    final item = selectedItemProvider.selectedItem;

    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        backgroundColor: colorScheme(context).onPrimary,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        title: Text(
          "Rating and Reviews",
          style: txtTheme(context).headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme(context).surface,
              ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return CustomRatingBottomSheet();
            },
          );
        },
        child: Container(
          height: 40,
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: colorScheme(context).primary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.edit, size: 20, color: colorScheme(context).onPrimary),
              Text(
                "Write a review",
                style: txtTheme(context)
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "4.3",
                      style: txtTheme(context).displayMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme(context).surface,
                          ),
                    ),
                    Text(
                      "23 ratings",
                      style: txtTheme(context).headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color:
                                colorScheme(context).surface.withOpacity(0.5),
                          ),
                    ),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(5, (index) {
                      int starCount = 5 - index;
                      return _buildStarProgressRow(starCount);
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${item!.commentlist.length} reviews",
                  style: txtTheme(context).headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface,
                      ),
                ),
                _buildPhotoFilterCheckbox(),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: item.commentlist.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      child: Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 25, left: 10),
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.all(16),
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.commentlist[index].name,
                                      style: txtTheme(context)
                                          .headlineMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  colorScheme(context).surface),
                                    ),
                                    Row(
                                      children: [
                                        ...item.commentlist[index].newstar,
                                        Spacer(),
                                        Text(
                                          item.commentlist[index].date,
                                          style: txtTheme(context)
                                              .headlineSmall
                                              ?.copyWith(
                                                  color: colorScheme(context)
                                                      .surface
                                                      .withOpacity(0.5)),
                                        )
                                      ],
                                    ),
                                    Text(
                                      item.commentlist[index].CommentsofProduct,
                                      style: txtTheme(context)
                                          .headlineSmall
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: colorScheme(context)
                                                  .surface
                                                  .withOpacity(0.6)),
                                    ),
                                    Spacer(),
                                    Consumer<CheckingController>(
                                      builder: (context, value, child) {
                                        return value.itemSelected
                                            ? Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: item
                                                    .commentlist[index].images
                                                    .map<Widget>((imagePath) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  right: 8.0),
                                                          child: Image.asset(
                                                              imagePath,
                                                              width: 60,
                                                              height: 100),
                                                        ))
                                                    .toList(),
                                              )
                                            : SizedBox(); // Show nothing if unchecked
                                      },
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Helpful",
                                          style: txtTheme(context)
                                              .headlineSmall
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: colorScheme(context)
                                                      .surface
                                                      .withOpacity(0.6)),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(
                                          Icons.thumb_up_alt,
                                          size: 25,
                                          color: colorScheme(context)
                                              .surface
                                              .withOpacity(0.6),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage: AssetImage(
                                item.commentlist[index].profileimage),
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

  Widget _buildStarProgressRow(int starCount) {
    Map<int, int> ratingCounts = {
      5: 12,
      4: 7,
      3: 4,
      2: 2,
      1: 1,
    };

    int count = ratingCounts[starCount] ?? 0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Row(
            children: List.generate(
              starCount,
              (index) => const Icon(Icons.star, color: Colors.amber, size: 15),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: LinearProgressIndicator(
              value: starCount / 5,
              backgroundColor: Colors.grey.shade300,
              color: Colors.amber,
              minHeight: 5,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "$count",
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoFilterCheckbox() {
    return Consumer<CheckingController>(
      builder: (context, value, child) {
        return Row(
          children: [
            Checkbox(
              side: const BorderSide(color: Colors.black),
              value: value.itemSelected,
              onChanged: (newValue) {
                value.isChecked();
              },
            ),
            Text(
              "With Photo",
              style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface,
                  ),
            ),
          ],
        );
      },
    );
  }
}
