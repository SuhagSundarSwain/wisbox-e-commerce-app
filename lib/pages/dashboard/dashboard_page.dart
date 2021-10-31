import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/pages/dashboard/widgets/home_page.dart';
import 'package:nexmat/pages/dashboard/widgets/moment_icon_page.dart';
import 'package:nexmat/pages/dashboard/widgets/wallet_page.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/pages/onboarding/onboard_shop_details.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';
import 'package:nexmat/widgets/alert_dialog.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 27-10-2021 03:44 PM
///
class DashboardPage extends StatefulWidget {
  static const String routeName = '/';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        if (_currentIndex == 0) {
          return true;
        } else {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          iconTheme: IconThemeData(color: theme.primaryColor),
          actionsIconTheme: IconThemeData(color: theme.primaryColor),
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.splashLogo,
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
            IconButton(
                onPressed: () {
                  showAppAlertDialog(
                          title: "Logout?",
                          description: "Are you sure want to logout?")
                      .then((value) {
                    if (value == true) {
                      FirebaseAuth.instance.signOut();
                      SharedPreferenceHelper.logout();
                      Get.offAllNamed(LoginPage.routeName);
                    }
                  });
                },
                icon: const Icon(Icons.power_settings_new_rounded)),
            const UserCircleAvatar(
              "https://image.freepik.com/free-vector/diwali-festival-nice-yellow-decorative-card-design_1017-34266.jpg",
              radius: 18,
            ),
            const SizedBox(width: 8)
          ],
        ),
        body: [
          const HomePage(),
          const MomentIconPage(),
          const WalletPage()
        ][_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (i) {
            setState(() {
              _currentIndex = i;
            });
          },
          backgroundColor: const Color(0xffA398F9),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          items: const [
            BottomNavigationBarItem(
                icon: BottomNavIcon(AppAssets.home),
                activeIcon: BottomNavIcon(
                  AppAssets.home,
                  active: true,
                ),
                label: 'Home',
                tooltip: 'Home'),
            BottomNavigationBarItem(
                icon: BottomNavIcon(AppAssets.momentIcon),
                activeIcon: BottomNavIcon(
                  AppAssets.momentIcon,
                  active: true,
                ),
                label: 'Moment Icon',
                tooltip: 'Moment Icon'),
            BottomNavigationBarItem(
                icon: BottomNavIcon(AppAssets.wallet),
                activeIcon: BottomNavIcon(
                  AppAssets.wallet,
                  active: true,
                ),
                label: 'Wallet',
                tooltip: 'Wallet'),
          ],
        ),
      ),
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  final String asset;
  final bool active;
  const BottomNavIcon(this.asset, {this.active = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SvgPicture.asset(asset, width: 26),
      if (active)
        const Center(
          child: Material(
            color: Colors.white,
            type: MaterialType.circle,
            child: SizedBox.square(
              dimension: 8,
            ),
          ),
        )
    ]);
  }
}
