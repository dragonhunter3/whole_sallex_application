import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';
import 'package:whole_selle_x_application/src/common/const/global_variables.dart';
import 'package:whole_selle_x_application/src/router/route.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _pickedImage;

  Future<void> pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    } else {
      // User canceled the picker
      print("No image selected.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorScheme(context).onPrimary,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: colorScheme(context).surface),
        backgroundColor: colorScheme(context).onPrimary,
        title: Text(
          "Profile Page",
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold, color: colorScheme(context).surface),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: GestureDetector(
                  onTap: () => pickImageFromGallery(),
                  child: _pickedImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(
                            _pickedImage!,
                            width: 70,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: AssetImage(AppImages.ahmadpic),
                        )),
              title: Text(
                "Muhammad Ahmad",
                style: txtTheme(context)
                    .headlineMedium
                    ?.copyWith(color: colorScheme(context).surface),
              ),
              subtitle: Text(
                "ahmad@gmail.com",
                style: txtTheme(context).headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme(context).surface.withOpacity(0.3)),
              ),
            ),
            CustomListile("My order", "Already 12 orders", () {
              context.pushNamed(AppRoute.orderDetailScreen);
            }),
            CustomListile("Shipping address", "3 Shipping address ", () {}),
            CustomListile("Payment methods", "Via ****314", () {}),
            CustomListile("My reviews", "4 Items ", () {}),
          ],
        ),
      ),
    );
  }

  Widget CustomListile(String text, String text2, VoidCallback function) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(text,
          style: txtTheme(context).headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme(context).surface)),
      subtitle: Text(
        text2,
        style: txtTheme(context).headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme(context).surface.withOpacity(0.4)),
      ),
      trailing: GestureDetector(
          onTap: function,
          child: Icon(Icons.chevron_right, color: Colors.black)),
    );
  }
}
