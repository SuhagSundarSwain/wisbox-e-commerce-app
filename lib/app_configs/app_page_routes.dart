import 'package:get/get.dart';
import 'package:nexmat/pages/dashboard/dashboard_page.dart';
import 'package:nexmat/pages/intro/intro_page.dart';
import 'package:nexmat/pages/login/login_page.dart';
import 'package:nexmat/pages/onboarding/onboard_shop_details.dart';
import 'package:nexmat/pages/onboarding/select_location_page.dart';
import 'package:nexmat/pages/register/register_otp_verification_page.dart';
import 'package:nexmat/pages/register/register_page.dart';
import 'package:nexmat/pages/splash/splash_screen.dart';
import 'package:nexmat/pages/static/app_webview_page.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPages {
  static final pages = [
    GetPage(name: SplashPage.routeName, page: () => const SplashPage()),
    GetPage(name: IntroPage.routeName, page: () => const IntroPage()),
    GetPage(name: LoginPage.routeName, page: () => const LoginPage()),
    GetPage(name: RegisterPage.routeName, page: () => const RegisterPage()),
    GetPage(
        name: RegisterOtpVerificationPage.routeName,
        page: () => const RegisterOtpVerificationPage()),
    GetPage(
        name: OnboardShopDetails.routeName,
        page: () => const OnboardShopDetails()),
    GetPage(
        name: SelectLocationPage.routeName,
        page: () => const SelectLocationPage()),
    GetPage(
        name: DashboardPage.routeName,
        page: () => const DashboardPage(),
        children: const []),
    GetPage(name: AppWebViewPage.routeName, page: () => const AppWebViewPage()),
  ];
}
