import 'package:flutter/material.dart';

import 'nearby_shop_tile.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 31-10-2021 08:02 PM
///
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Material(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6),
            clipBehavior: Clip.antiAlias,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Row(
                children: const [
                  Icon(Icons.search),
                  SizedBox(width: 4),
                  Expanded(child: Text("Search for your location"))
                ],
              ),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            "https://image.freepik.com/free-vector/super-sale-banner-design-vector-illustration_1035-14931.jpg",
            fit: BoxFit.cover,
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 24, 16, 0),
          child: Text(
            "Shops near you",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
        ),
        const NearByShopTile(),
        const NearByShopTile(),
        const NearByShopTile(),
        const NearByShopTile(),
        // const Text(
        //   "Our Top Recommendations",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        // ),
        // const Text(
        //   "Deals of the day",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        // ),
        // const Text(
        //   "NEW Openings",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        // ),
        // const Text(
        //   "Top Picks near you",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        // ),
        // const Text(
        //   "Similar Shops ",
        //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        // ),
        const SizedBox(height: 54),
      ],
    );
  }
}
