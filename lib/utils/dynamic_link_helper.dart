/// DynamicLinkHelper.generateDynamicLink(DynamicLinkType, "1234").then((value) => print(value));
///
/// DynamicLinkHelper.generateDynamicLink(DynamicLinkType, "1234",imageUrl: "Your Photo link").then((value) => print(value));

class AppDynamicLinkHelper {
  static final _baseLink = 'https://sunil.page.link';

// static Future<String> generateDynamicLink(DynamicLinkType type, String data,
//     {String imageUrl = "https://alapweb.com/assets/img/logo.png",
//     String title = "Demo",
//     String description = "Demo Description"}) async {
//   if (imageUrl == null) imageUrl = 'http://via.placeholder.com/128x128/00FF00/000000';
//   final DynamicLinkParameters parameters = DynamicLinkParameters(
//     uriPrefix: _baseLink,
//     link: Uri.parse('$_baseLink/${type.type}?${type.queryName}=$data'),
//     androidParameters: AndroidParameters(
//         packageName: 'com.smarttersstudio.pro_learner_student',
//         minimumVersion: 1,
//         fallbackUrl: Uri.parse('https://google.com')),
//     iosParameters: IosParameters(
//         bundleId: 'com.smarttersstudio.pro_learner_student',
//         customScheme: 'com.smarttersstudio.pro_learner_student',
//         fallbackUrl: Uri.parse('https://google.com')),
//     socialMetaTagParameters: SocialMetaTagParameters(
//         title: title,
//         description: description,
//         imageUrl: Uri.parse(imageUrl)),
//   );
//   final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();
//   print(dynamicUrl.shortUrl.toString());
//   return dynamicUrl.shortUrl.toString();
// }
}

class DynamicLinkType {
  static DynamicLinkType post = DynamicLinkType("post", "id");
  static DynamicLinkType profile = DynamicLinkType("profile", "id");

  final String type;

  final String queryName;

  DynamicLinkType(this.type, this.queryName);
}
