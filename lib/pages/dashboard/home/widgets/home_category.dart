import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 15-11-2021 08:59 PM
///
class HomeCategory extends StatelessWidget {
  const HomeCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = [
      "assets/icons/dress_category.png",
      "assets/icons/shirt_category.png",
      "assets/icons/watch_category.png",
      "assets/icons/vegetable_category.png",
      "assets/icons/coffee_category.png",
      "assets/icons/electronic_category.png",
    ];

    return GridView.builder(
        itemCount: list.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (context, index) {
          return Image.asset(
            list[index],
            fit: BoxFit.cover,
          );
        });
  }
}
