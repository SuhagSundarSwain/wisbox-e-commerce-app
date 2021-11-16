import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/data_models/rest_error.dart';
import 'package:nexmat/widgets/app_error_widget.dart';
import 'package:nexmat/widgets/app_loader.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 31-10-2021 08:03 PM
///
class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "Shopping History",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseCollectionRefs.ordersRef.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return AppErrorWidget(
                        title: parseFirebaseError(snapshot.error));
                  }
                  if (snapshot.hasData) {
                    List docs = snapshot.data!.docs
                        .where((element) =>
                            element.data()["userId"] ==
                            FirebaseAuth.instance.currentUser?.uid)
                        .toList();
                    if (docs.isEmpty) {
                      return const AppEmptyWidget(title: "No data found");
                    }
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
                          child: Material(
                            elevation: 2,
                            borderRadius: BorderRadius.circular(8),
                            clipBehavior: Clip.antiAlias,
                            child: StreamBuilder<
                                    DocumentSnapshot<Map<String, dynamic>>>(
                                stream: FirebaseCollectionRefs.storeItemsRef
                                    .doc(snapshot.data!.docs[index]
                                        .data()["productId"])
                                    .snapshots(),
                                builder: (context, productSnapshot) {
                                  return Row(
                                    children: [
                                      if (productSnapshot.hasData)
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 2,
                                                child: Image.network(
                                                  productSnapshot.data!
                                                      .data()!["image"],
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Expanded(
                                                flex: 3,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      productSnapshot.data!
                                                          .data()!["name"],
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                    Text(
                                                      "${productSnapshot.data!.data()!["storeName"] ?? ""}",
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      const SizedBox(width: 6),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            6, 6, 16, 6),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "₹ ${snapshot.data!.docs[index].data()["amount"]} ",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(DateFormat("dd MMM yyyy")
                                                .format(DateTime
                                                    .fromMicrosecondsSinceEpoch(
                                                        snapshot
                                                            .data!.docs[index]
                                                            .data()["date"]
                                                            .microsecondsSinceEpoch))),
                                            if (snapshot.data!.docs[index]
                                                    .data()["status"] ==
                                                -1)
                                              const Text(
                                                "Cancelled",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.red),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                          ),
                        );
                      },
                      itemCount: docs.length,
                    );
                  } else {
                    return const Center(child: AppProgress());
                  }
                }),
          )
        ],
      ),
    );
  }
}
