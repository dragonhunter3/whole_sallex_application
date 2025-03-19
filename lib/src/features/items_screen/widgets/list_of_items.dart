import 'package:flutter/material.dart';
import 'package:whole_selle_x_application/src/common/const/app_images.dart';

class Commments {
  final String profileimage;
  final String name;
  final String CommentsofProduct;
  final List newstar;
  final String date;
  final List images;
  Commments(this.profileimage, this.name, this.CommentsofProduct, this.newstar,
      this.date, this.images);
}

class Items {
  final String image;
  final List star;
  final String numberOfIcons;
  final String brandName;
  final String itemName;
  final String price;
  final Icon chatIcon;
  final int id;
  final String comment;
  final List<Commments> commentlist;
  final List<String> availableColors;
  final List<String> availableSizes;
  String selectedColor;
  String selectedSize;

  Items(
    this.image,
    this.star,
    this.numberOfIcons,
    this.brandName,
    this.itemName,
    this.price,
    this.chatIcon,
    this.id,
    this.comment,
    this.commentlist,
    this.availableColors,
    this.availableSizes,
    this.selectedColor,
    this.selectedSize,
  );
  void updateSelection(String color, String size) {
    selectedColor = color;
    selectedSize = size;
  }
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
    ),
    1,
    "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
    [
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
    ],
    ["Black", "Green", "Blue", "White", "Yellow"],
    ["S", "M", "L", "XL"],
    "Black",
    "M",
  ),
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
    ),
    2,
    "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
    [
      Commments(
          AppImages.ahmadpic,
          "Muhammad Ahmad",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.ahmadpic,
          "Muhammad Ahmad",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.ahmadpic,
          "Muhammad Ahmad",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.ahmadpic,
          "Muhammad Ahmad",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.ahmadpic,
          "Muhammad Ahmad",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
    ],
    ["Black", "Green", "Blue", "White", "Yellow"],
    ["S", "M", "L", "XL"],
    "Black",
    "M",
  ),
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
    ),
    3,
    "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
    [
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad ",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
    ],
    ["Black", "Green", "Blue", "White", "Yellow"],
    ["S", "M", "L", "XL"],
    "Black",
    "M",
  ),
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
    ),
    4,
    "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
    [
      Commments(
          AppImages.basitpic,
          "Abdul Basit",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.basitpic,
          "Abdul Basit",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.basitpic,
          "Abdul Basit",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.basitpic,
          "Abdul Basit",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.basitpic,
          "Abdul Basit",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.basitpic,
          "Abdul Basit",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
    ],
    ["Black", "Green", "Blue", "White", "Yellow"],
    ["S", "M", "L", "XL"],
    "Black",
    "M",
  ),
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
    ),
    5,
    "Short dress in soft cotton jersey with decorative buttons down the front and a wide, frill-trimmed square neckline with concealed elastication. Elasticated seam under the bust and short puff sleeves with a small frill trim.",
    [
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
      Commments(
          AppImages.shahidpic,
          "Muhammad Shahid",
          "This is a amzing product which never you seen it in your life",
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
          "15-12-2025",
          [
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
            AppImages.assleries,
          ]),
    ],
    ["Black", "Green", "Blue", "White", "Yellow"],
    ["S", "M", "L", "XL"],
    "Black",
    "M",
  ),
];
