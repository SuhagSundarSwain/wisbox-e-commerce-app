import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nexmat/utils/shared_preference_helper.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 08:04 PM
///
mixin FirebaseCollectionRefs {
  static CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection("CustomerDetails");

  static CollectionReference<Map<String, dynamic>> storesRef =
      FirebaseFirestore.instance.collection("StoreDetails");

  static CollectionReference<Map<String, dynamic>> storeCategoriesRef =
      FirebaseFirestore.instance.collection("StoreCategory");

  static CollectionReference<Map<String, dynamic>> storeItemsRef =
      FirebaseFirestore.instance.collection("Item");

  static DocumentReference<Map<String, dynamic>> userRef =
      usersRef.doc(SharedPreferenceHelper.user!.email);
}
