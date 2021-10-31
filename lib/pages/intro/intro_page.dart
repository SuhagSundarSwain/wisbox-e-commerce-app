import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexmat/app_configs/app_assets.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class IntroPage extends StatefulWidget {
  static const String routeName = '/intro';

  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<String> avatars = [
    AppAssets.intro1,
    AppAssets.intro2,
    AppAssets.intro3,
  ];
  final List<String> titles = ['Watch out!', 'Live Offers ', 'Hangout Now '];
  final List<String> descriptions = [
    'Know whats going on in your nearby market with just one click.',
    'Catch live offers and win exciting prices along with your shopping process.',
    'Catch live offers and win exciting prices along with your shopping process.',
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      SharedPreferenceHelper.storeFirstTime();
                      Get.offAllNamed(LoginPage.routeName);
                    },
                    child: const Text("Skip"))),
            Expanded(
              flex: 5,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: List.generate(
                    3,
                    (index) => Column(
                          children: [
                            const Spacer(),
                            Image.asset(avatars[index], width: Get.width / 1.5),
                            const Spacer(),
                            Center(
                                child: Text(
                              titles[index],
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.w600),
                            )),
                            const SizedBox(height: 4),
                            Center(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
                              child: Text(
                                descriptions[index],
                                textAlign: TextAlign.center,
                              ),
                            )),
                            const Spacer(),
                          ],
                        )),
              ),
            ),
            Flexible(
              flex: 2,
              child: Material(
                shape: const CircleBorder(
                    side: BorderSide(width: 2, color: Color(0xff0090ff))),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Material(
                    color: const Color(0xff0090ff),
                    shape: const CircleBorder(),
                    child: InkWell(
                      onTap: () {
                        if (_pageController.page != 2) {
                          _pageController.nextPage(
                              duration: kThemeAnimationDuration,
                              curve: Curves.linear);
                        } else {
                          SharedPreferenceHelper.storeFirstTime();
                          Get.offAllNamed(LoginPage.routeName);
                        }
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(Icons.arrow_forward_rounded,
                            color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
