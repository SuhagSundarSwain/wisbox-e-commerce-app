import 'package:flutter/material.dart';
import 'package:nexmat/pages/dashboard/home/widgets/top_recommendation_tile.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 05-11-2021 08:45 PM
///
class OurRecommendations extends StatelessWidget {
  const OurRecommendations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            "Our Top Recommendations",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
              children: const [
                TopRecommendationTile(
                    "https://images.pexels.com/photos/10027871/pexels-photo-10027871.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    "Fashion"),
                TopRecommendationTile(
                    "https://images.pexels.com/photos/10027871/pexels-photo-10027871.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    "Grocery"),
                TopRecommendationTile(
                    "https://images.pexels.com/photos/10027871/pexels-photo-10027871.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    "Decoration"),
                TopRecommendationTile(
                    "https://images.pexels.com/photos/10027871/pexels-photo-10027871.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                    "Fashion"),
              ],
            )),
      ],
    );
  }
}
