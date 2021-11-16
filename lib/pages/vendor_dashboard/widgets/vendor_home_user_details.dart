import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nexmat/app_configs/firebase_collections_refs.dart';
import 'package:nexmat/widgets/user_circle_avatar.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 09-11-2021 04:01 PM
///
class VendorHomeUserDetails extends StatelessWidget {
  const VendorHomeUserDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffDDD8FF),
      child: Column(
        children: [
          const SizedBox(height: 16),
          StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseCollectionRefs.userRef.snapshots(),
              builder: (context, snapshot) {
                return Row(
                  children: [
                    const SizedBox(width: 16),
                    UserCircleAvatar(
                      snapshot.data?.data()?["image"],
                      name: snapshot.data?.data()?["customerName"],
                      userId: snapshot.data?.data()?["userUID"],
                      radius: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                        child: Text(
                      snapshot.data?.data()?["customerName"] ?? "",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.w500),
                    )),
                    Material(
                      color: Colors.black26,
                      child: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.navigate_before,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      type: MaterialType.circle,
                      clipBehavior: Clip.antiAlias,
                    ),
                    const SizedBox(width: 8),
                    Material(
                      color: Colors.black26,
                      child: InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      type: MaterialType.circle,
                      clipBehavior: Clip.antiAlias,
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              }),
          SizedBox(
            height: 130,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(16),
              children: const [
                ImageTile(),
                ImageTile(),
                ImageTile(),
                ImageTile(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ImageTile extends StatelessWidget {
  const ImageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: AspectRatio(
        aspectRatio: 1,
        child: Material(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  "https://images.pexels.com/photos/9884243/pexels-photo-9884243.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: -16,
                top: -16,
                child: Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {},
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(12, 22, 22, 12),
                      child: Icon(
                        Icons.close,
                        size: 18,
                      ),
                    ),
                  ),
                  type: MaterialType.circle,
                  clipBehavior: Clip.antiAlias,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
