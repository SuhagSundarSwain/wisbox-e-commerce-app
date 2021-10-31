// import 'dart:convert';
// import 'dart:io';
//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:nexmat/app_configs/app_colors.dart';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// import 'fcm_services.dart';
//
// ///
// ///Created By Aurosmruti (aurosmruti@smarttersstudio.com) on 6/17/2020 8:16 AM
// ///
//
// const String channelId = 'net.mylocalstore.my_localstore/notification';
// const String channelName = 'LocalStore-Notification';
// const String channelDescription = 'Localstore Notification Channel';
// const String notificationTicker = 'ticker';
//
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//
// NotificationAppLaunchDetails? notificationAppLaunchDetails;
//
// class InAppNotification {
//   ///Configuration for flutter local notifications both android and ios
//   static Future<void> configureInAppNotification(
//       {bool reqAlert = true,
//       bool reqBadge = true,
//       bool reqSound = true}) async {
//     await Firebase.initializeApp();
//
//     notificationAppLaunchDetails =
//         await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
//     var initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettingsIOS = IOSInitializationSettings(
//         requestAlertPermission: reqAlert,
//         requestBadgePermission: reqBadge,
//         requestSoundPermission: reqSound,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {
//           if (payload != null) onNotificationTapped(json.decode(payload));
//         });
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings,
//         onSelectNotification: (payload) async =>
//             {if (payload != null) onNotificationTapped(json.decode(payload))});
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
//     await flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin>()
//         ?.createNotificationChannel(const AndroidNotificationChannel(
//           channelId,
//           channelName,
//           description: channelDescription,
//           importance: Importance.high,
//         ));
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     // FirebaseMessaging.instance.configure(
//     //     onMessage: backgroundMessageHandler,
//     //     onBackgroundMessage: Platform.isIOS ? null : backgroundMessageHandler,
//     //     onLaunch: (message) async {
//     //       try {
//     //         Map<dynamic, dynamic> data = message['data'];
//     //         // Get.offAndToNamed(DashboardPage.routeName);
//     //         log('onLaunch $data');
//     //         // Get.offAndToNamed(DashboardPage.routeName);
//     //         // Future.delayed(Duration(seconds: 2)).then((value) {
//     //         //   onNotificationTapped(
//     //         //       ActivityDatum.fromJson(Map<String, dynamic>.from(data)));
//     //         // });
//     //       } catch (e, s) {
//     //         debugPrint('$e $s');
//     //       }
//     //     },
//     //     onResume: (message) async {
//     //       try {
//     //         Map<dynamic, dynamic> data = message['data'];
//     //         log('onResume $data');
//     //
//     //         // onNotificationTapped(
//     //         //     ActivityDatum.fromJson(Map<String, dynamic>.from(data)));
//     //       } catch (e, s) {
//     //         debugPrint('$e $s');
//     //       }
//     //     });
//     // _firebaseMessaging.requestNotificationPermissions(
//     //     const IosNotificationSettings(
//     //         sound: true, badge: true, alert: true, provisional: true));
//     // _firebaseMessaging.onIosSettingsRegistered
//     //     .listen((IosNotificationSettings settings) {});
//   }
//
//   ///request IOS notification permission
//   static void requestIOSPermissions(
//       {bool alert = true, bool badge = true, bool sound = true}) {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//             IOSFlutterLocalNotificationsPlugin>()
//         ?.requestPermissions(
//           alert: alert,
//           badge: badge,
//           sound: sound,
//         );
//   }
//
//   static Future<void> showNotification(
//       {String title = 'Demo',
//       String description = 'Demo notification.',
//       String imageUrl = 'http://via.placeholder.com/128x128/00FF00/000000',
//       dynamic data}) async {
//     // final String? largeIconPath =
//     //     await _downloadAndSaveFile(imageUrl, 'largeIcon');
//
//     var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
//         channelId, channelName,
//         channelDescription: channelDescription,
//         icon: '@mipmap/ic_launcher',
//         // largeIcon:
//         //     largeIconPath == null ? null : FilePathAndroidBitmap(largeIconPath),
//         styleInformation: DefaultStyleInformation(true, true),
//         importance: Importance.max,
//         priority: Priority.max,
//         ticker: notificationTicker,
//         enableLights: true,
//         color: AppColors.brightPrimary,
//         ledColor: AppColors.brightPrimary,
//         ledOnMs: 1000,
//         ledOffMs: 500);
//     var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
//         presentSound: true,
//         presentAlert: true,
//         presentBadge: true,
//         badgeNumber: 1);
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: iOSPlatformChannelSpecifics);
//     try {
//       await flutterLocalNotificationsPlugin.show(
//           data.hashCode, title, description, platformChannelSpecifics,
//           payload: json.encode(data));
//     } catch (e, s) {
//       debugPrint('$e $s');
//     }
//   }
//
// //   static Future<void> showMessagingNotification(MessageDatum data) async {
// //     List<Message> messages = List();
// //
// //     final largeIconPath =
// //         await _downloadAndSaveFile(data.user.avatar, 'largeIcon');
// //
// //     final user = Person(
// //       name: data.user.name,
// //       important: true,
// //       key: data.user.id,
// //       bot: false,
// //       icon: largeIconPath != null
// //           ? BitmapFilePathAndroidIcon(largeIconPath)
// //           : null,
// //     );
// //
// //     // if (data.attachments != null && data.attachments.isNotEmpty) {
// //     //   final chatImage =
// //     //   await _downloadAndSaveFile(data.attachments[0].file, 'chatImage');
// //     //   messages.add(Message('📸 Photo', data.createdAt, user,
// //     //       dataMimeType: chatImage != null ? 'image/jpg' : null,
// //     //       dataUri: chatImage != null
// //     //           ? FilePathAndroidBitmap(chatImage).bitmap
// //     //           : null));
// //     // } else {
// //     messages.add(Message(data.content.text, data.createdAt, user));
// //     // }
// //
// //     final messagingStyle = MessagingStyleInformation(user,
// //         groupConversation: false,
// // //      conversationTitle: 'Group conversation',
// //         htmlFormatContent: true,
// //         htmlFormatTitle: true,
// //         messages: messages);
// //     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
// //         'alap message channel',
// //         'alap message',
// //         'alap message channel description',
// //         importance: Importance.Max,
// //         priority: Priority.Max,
// //         category: 'msg',
// //         styleInformation: messagingStyle);
// //     var platformChannelSpecifics = NotificationDetails(
// //         androidPlatformChannelSpecifics, IOSNotificationDetails());
// //     final notification = ActivityDatum(
// //         entityType: 'chat',
// //         action: 'chat',
// //         entityId: data.conversation,
// //         user: data.user,
// //         link: data.user.name,
// //         createdAt: data.createdAt,
// //         updatedAt: data.updatedAt);
// //     await flutterLocalNotificationsPlugin.show(
// //         0, data.user.name, data.content.text, platformChannelSpecifics,
// //         payload: json.encode(notification.toJson()));
// //
// //     // wait 10 seconds and add another message to simulate another response
// // //    for (int i = 0; i < 5; i++) {
// // //      await Future.delayed(Duration(seconds: 1), () async {
// // //        messages.add(
// // //            Message('Thai', DateTime.now().add(Duration(minutes: 11)), null));
// // //        await flutterLocalNotificationsPlugin.show(
// // //            0, 'message title', 'message body', platformChannelSpecifics);
// // //      });
// // //    }
// //   }
// }
//
// ///downloads and saves the network image
// // Future<String?> _downloadAndSaveFile(String url, String fileName) async {
// //   final status = await Permission.storage.status;
// //   if (status.isGranted) {
// //     final directory = await getApplicationDocumentsDirectory();
// //     final filePath = '${directory.path}/$fileName';
// //     final response = await http.get(url);
// //     if (response.statusCode == 200) {
// //       final file = File(filePath);
// //       await file.writeAsBytes(response.bodyBytes);
// //       debugPrint('Download service done for : $url to $filePath.');
// //       return filePath;
// //     } else {
// //       debugPrint(
// //           'Download service received for : $url to $fileName but failed because of 404 url.');
// //       return null;
// //     }
// //   } else {
// //     debugPrint(
// //         'Download service received for : $url to $fileName but denied because of Storage permission.');
// //     return null;
// //   }
// // }
