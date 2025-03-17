import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/common/widgets/custom_elevated_button.dart';
import 'package:whole_selle_x_application/src/features/rating_and_reviw/controller.dart/rating_controller.dart';

class CustomRatingBottomSheet extends StatelessWidget {
  const CustomRatingBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.7,
      minChildSize: 0.5,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: colorScheme(context).onPrimary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "What is you rate?",
                    style: txtTheme(context).headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme(context).surface),
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<RatingProvider>(
                  builder: (context, ratingProvider, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onHorizontalDragUpdate: (details) {
                            double newRating =
                                (details.localPosition.dx / 50).clamp(0, 5);
                            ratingProvider.setRating(newRating);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(5, (index) {
                              return Icon(
                                Icons.star,
                                size: 50,
                                color: index < ratingProvider.rating
                                    ? Colors.amber
                                    : Colors.grey,
                              );
                            }),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
                Text(
                  "Please share your opinion about the product",
                  textAlign: TextAlign.center,
                  style: txtTheme(context).headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme(context).surface),
                ),
                const SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  color: Colors.white,
                  child: TextField(
                    controller: controller,
                    maxLines: 5,
                    style: txtTheme(context)
                        .headlineMedium
                        ?.copyWith(color: colorScheme(context).surface),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Your Review",
                      hintStyle: txtTheme(context).headlineSmall?.copyWith(
                          color: colorScheme(context).surface.withOpacity(0.5)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Consumer<RatingProvider>(
                  builder: (context, imageProvider, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (imageProvider.images.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: imageProvider.images
                                    .map((file) => Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.file(file,
                                                width: 80,
                                                height: 80,
                                                fit: BoxFit.cover),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: imageProvider.images.isEmpty
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: Center(
                              child: IconButton(
                                icon: const Icon(Icons.camera_alt,
                                    size: 20, color: Colors.blue),
                                onPressed: () {
                                  imageProvider.pickImage();
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
                SizedBox(height: 15),
                CustomGradientButton(
                  onPressed: () {},
                  buttonText: "SEND REVIEW",
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
