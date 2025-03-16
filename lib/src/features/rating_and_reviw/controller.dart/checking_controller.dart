import 'package:flutter/material.dart';

class CheckingController extends ChangeNotifier {
  bool isSelected = false;
  bool get itemSelected => isSelected;
  void isChecked() {
    isSelected = !isSelected;
    notifyListeners();
  }
}

//  Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "${item!.commentlist.length.toString()} reviews",
//                     style: txtTheme(context).headlineMedium?.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: colorScheme(context).surface),
//                   ),
//                   SizedBox(
//                     height: 40,
//                     width: 120,
//                     child: Row(
//                       children: [
//                         Consumer<CheckingController>(
//                           builder: (context, value, child) {
//                             return Checkbox(
//                               side: BorderSide(color: Colors.black),
//                               value: value.itemSelected,
//                               onChanged: (newvalue) {
//                                 value.isChecked();
//                               },
//                             );
//                           },
//                         ),
//                         Text(
//                           "With Photo",
//                           style: txtTheme(context).bodyLarge?.copyWith(
//                               fontWeight: FontWeight.bold,
//                               color: colorScheme(context).surface),
//                         )
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
