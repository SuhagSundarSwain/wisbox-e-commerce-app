import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 01-11-2021 03:21 PM
///
class TopRecommendationTile extends StatelessWidget {
  final String avatar, title;

  const TopRecommendationTile(this.avatar, this.title, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Material(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
            width: 150,
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    avatar,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned.fill(
                    child: ColoredBox(
                  color: Colors.black26,
                )),
                Center(
                    child: Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      letterSpacing: 1),
                ))
              ],
            )),
      ),
    );
  }
}
