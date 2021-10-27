import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<dynamic> backgroundMessageHandler(RemoteMessage message) async {
  try {
    // await Firebase.initializeApp();
    RemoteNotification? notification = message.notification;
    //
    // log('data  --> $message ');
    // ActivityDatum notificationData = ActivityDatum.fromJson(
    //     Map<String, dynamic>.from(Platform.isAndroid ? message['data'] : data));
    //
    // return InAppNotification.showNotification(
    //   title: Platform.isAndroid ? notification['title'] : data['title'],
    //   description: Platform.isAndroid ? notification['body'] : data['body'],
    //   imageUrl: notificationData.user.avatar,
    //   data: notificationData,
    // );
  } catch (e, s) {
    debugPrint('Notification StackTrace $e $s');
  }
}

void onNotificationTapped(dynamic activityDatum) {
//   // String type = activityDatum.action.trim();
//   debugPrint('onNotificationTapped ${activityDatum.toJson()}');
//
//   switch (activityDatum.entityType) {
//     case 'user':
//       if (activityDatum.action == 'follow-request')
//         Get.toNamed(PendingRequestsPage.routeName, preventDuplicates: false);
//       else
//         Get.toNamed(OtherProfilePage.routeName,
//             arguments: activityDatum.user.id, preventDuplicates: false);
//       break;
//     case 'post':
//       Get.toNamed(SingleVideoPage.routeName,
//           arguments: {
//             'videoId': (activityDatum.entityId as VideoDatum).id,
//           },
//           preventDuplicates: false);
//       break;
//     case 'link':
//       try {
//         launch(activityDatum.link);
//       } catch (_) {
//         log('Link open error', error: _.toString());
//       }
//       break;
//     case 'hashTag':
//       log((activityDatum.entityId as HashTagDatum).id);
//       Get.toNamed(HashTagDetailsPage.routeName,
//           arguments: {
//             'hashTag': (activityDatum.entityId as HashTagDatum).tag,
//           },
//           preventDuplicates: false);
//       break;
//     case 'audio':
//       Get.toNamed(AudioDetailsPage.routeName,
//           arguments: {
//             'audioId': (activityDatum.entityId as AudioData).id,
//           },
//           preventDuplicates: false);
//       break;
//     case 'chat':
//       Get.to(ChatPage.secondUser(activityDatum.user), preventDuplicates: false);
//       break;
//     default:
//       if (activityDatum.action == 'link') {
//         try {
//           launch(activityDatum.link);
//         } catch (_) {
//           log('Link open error', error: _.toString());
//         }
//       }
//   }
}
