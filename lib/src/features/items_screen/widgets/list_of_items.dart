import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';

class Items {
  final String image;
  final List star;
  final String numberOfIcons;
  final String brandName;
  final String itemName;
  final String price;
  final Icon chatIcon;
  Items(
    this.image,
    this.star,
    this.numberOfIcons,
    this.brandName,
    this.itemName,
    this.price,
    this.chatIcon,
  );
}

List<Items> myItems = [
  Items(
      AppImages.photo,
      [
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.grey.withOpacity(0.5),
          size: 15,
        ),
      ],
      "(3)",
      "mango",
      "T-Shirt SPANISH",
      "PKR 500",
      Icon(
        Icons.chat,
        size: 20,
        color: Colors.grey.withOpacity(0.3),
      )),
  Items(
      AppImages.girlspic,
      [
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.grey.withOpacity(0.5),
          size: 15,
        ),
      ],
      "(3)",
      "Shahid",
      "Blouse",
      "PKR 600",
      Icon(
        Icons.chat,
        size: 20,
        color: Colors.grey.withOpacity(0.3),
      )),
  Items(
      AppImages.anothershirt,
      [
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.grey.withOpacity(0.5),
          size: 15,
        ),
      ],
      "(5)",
      "Ahmad",
      "Light Blouse",
      "PKR 500",
      Icon(
        Icons.chat,
        size: 20,
        color: Colors.grey.withOpacity(0.3),
      )),
  Items(
      AppImages.menshirt,
      [
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.grey.withOpacity(0.5),
          size: 15,
        ),
      ],
      "(2)",
      "Rashid",
      "T-Shirt ",
      "PKR 500",
      Icon(
        Icons.chat,
        size: 20,
        color: Colors.grey.withOpacity(0.3),
      )),
  Items(
      AppImages.whiteshirt,
      [
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star,
          color: Color(0xffDB3022).withOpacity(0.5),
          size: 15,
        ),
        Icon(
          Icons.star_outline,
          color: Colors.grey.withOpacity(0.5),
          size: 15,
        ),
      ],
      "(4)",
      "Abdul basit",
      "Shirt",
      "PKR 500",
      Icon(
        Icons.chat,
        size: 20,
        color: Colors.grey.withOpacity(0.3),
      )),
];
List<DropdownMenuItem<String>> colorOfItems = [
  DropdownMenuItem(child: Text("Black")),
  DropdownMenuItem(child: Text("Green")),
  DropdownMenuItem(child: Text("White")),
  DropdownMenuItem(child: Text("Red")),
  DropdownMenuItem(child: Text("Yellow")),
];
