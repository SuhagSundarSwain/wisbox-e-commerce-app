import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/pages/dashboard/home/widgets/deal_of_ther_slider.dart';
import 'package:nexmat/pages/dashboard/home/widgets/home_category.dart';
import 'package:nexmat/pages/dashboard/home/widgets/most_trending_store_widget.dart';
import 'package:nexmat/pages/dashboard/home/widgets/near_by_stores.dart';
import 'package:nexmat/pages/dashboard/home/widgets/nearby_industry_widget.dart';
import 'package:nexmat/pages/dashboard/home/widgets/new_openings.dart';
import 'package:nexmat/pages/dashboard/home/widgets/our_recomendations_widget.dart';
import 'package:nexmat/pages/dashboard/home/widgets/recomended_products_slider.dart';
import 'package:nexmat/pages/dashboard/home/widgets/sponsered_ads.dart';
import 'package:nexmat/pages/dashboard/home/widgets/top_recommendation_tile.dart';
import 'package:nexmat/pages/onboarding/select_location_page.dart';
import 'package:nexmat/pages/store/all_nearby_stores.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/pages/dashboard/home/home_page.dart';
import 'package:nexmat/pages/dashboard/widgets/moment_icon_page.dart';
import 'package:nexmat/pages/dashboard/widgets/wallet_page.dart';
import 'package:nexmat/pages/profile/profile_page.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';
import 'widgets/nearby_shop_tile.dart';

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
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.primaryColor),
        actionsIconTheme: IconThemeData(color: theme.primaryColor),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.logo,
              width: 38,
              color: Colors.grey,
            ),
            const SizedBox(width: 10),
            Text(
              "NEXTMAT",
              style: TextStyle(
                  color: theme.primaryColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_outlined)),
          GestureDetector(
            onTap: () {
              Get.toNamed(ProfilePage.routeName);
            },
            child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseCollectionRefs.userRef.snapshots(),
                builder: (context, snapshot) {
                  return UserCircleAvatar(
                    snapshot.data?.data()?["image"],
                    name: snapshot.data?.data()?["customerName"],
                    userId: snapshot.data?.data()?["userUID"],
                    radius: 18,
                  );
                }),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: ListView(
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(16),
          //   child: Material(
          //     color: Colors.grey.shade200,
          //     borderRadius: BorderRadius.circular(6),
          //     clipBehavior: Clip.antiAlias,
          //     child: Padding(
          //       padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          //       child: Row(
          //         children: const [
          //           Icon(Icons.search),
          //           SizedBox(width: 4),
          //           Expanded(child: Text("Search for your location"))
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          ListTile(
            title: Text(
              SharedPreferenceHelper.location?.formattedAddress ??
                  "Choose location",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            minLeadingWidth: 22,
            tileColor: Colors.grey.shade200,
            onTap: () {
              Get.toNamed(SelectLocationPage.routeName,
                  arguments: {"isIndividual": true});
            },
            leading: const Icon(Icons.location_on),
          ),
          const MostTrendingStoreTile(),
          const SizedBox(height: 16),
          const HomeCategory(),
          const SizedBox(height: 16),
          const NearByIndustryWidget(),
          const NearByStores(),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
              child: TextButton(
                child: const Text("View More"),
                onPressed: () {
                  Get.toNamed(AllNearByStoresPage.routeName);
                },
              ),
            ),
          ),
          const OurRecommendations(),
          const SizedBox(height: 18),
          const RecommendedProductsSlider(),
          const SizedBox(height: 12),
          const SponsoredAdds(),
          const SizedBox(height: 12),
          const DealOfTheDaySlider(),
          const SizedBox(height: 32),
          const NewOpenings(),
          const SizedBox(height: 12),
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
      ),
    );
  }
}
