import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 11:19 AM
///
class SponsoredAdds extends StatelessWidget {
  const SponsoredAdds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        "https://image.freepik.com/free-vector/big-diwali-sale-banner-with-crackers-decoration_1017-21252.jpg",
        height: 100,
        fit: BoxFit.cover,
      ),
    );
  }
}
