import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/features/categories/controller/sort_controller.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height * 0.4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: const BorderRadius.only(
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
                  "Sort by",
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.6),
                      ),
                ),
              ),
              const SizedBox(height: 10),
              Consumer<SortProvider>(
                builder: (context, sortProvider, child) {
                  List<String> sortOptions = [
                    "Popular",
                    "Newest",
                    "Price: High to Low",
                    "Price: Low to High"
                  ];

                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ListView.builder(
                      itemCount: sortOptions.length,
                      itemBuilder: (context, index) {
                        String option = sortOptions[index];
                        bool isSelected = sortProvider.selectedSort == option;

                        return GestureDetector(
                          onTap: () {
                            sortProvider.setSortOption(option);
                            Navigator.pop(context); // Close Bottom Sheet
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context).colorScheme.onPrimary,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                option,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isSelected
                                          ? Colors.white
                                          : Theme.of(context)
                                              .colorScheme
                                              .surface,
                                    ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
