import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nexmat/pages/dashboard/home/widgets/recomended_products_slider.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 11:23 AM
///
class DealOfTheDaySlider extends StatelessWidget {
  const DealOfTheDaySlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
          child: Text(
            "Deals of the day",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          height: 240,
          color: const Color(0xffa880ff),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              Padding(
                padding: EdgeInsets.all(32),
                child: Center(
                  child: Text(
                    "Best\nDeals",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              DealOfDayProduct(),
              DealOfDayProduct(),
              DealOfDayProduct(),
              DealOfDayProduct(),
            ],
          ),
        )
      ],
    );
  }
}

class DealOfDayProduct extends StatelessWidget {
  const DealOfDayProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      padding: const EdgeInsets.fromLTRB(0, 12, 16, 12),
      child: Material(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 2,
        child: Column(children: <Widget>[
          Expanded(
              child: Stack(children: [
            Positioned.fill(
                child: Image.network(
              "https://images.pexels.com/photos/3987333/pexels-photo-3987333.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              fit: BoxFit.cover,
            )),
            Positioned(
                right: 22,
                top: 0,
                width: 48,
                height: 70,
                child: CustomPaint(
                  painter: OfferCustomPaint(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "20%",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "off",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                )),
          ])),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "Tokyo Talkies",
                    maxLines: 1,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
                Text(
                  "₹ 440",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: const [
                Expanded(
                  child: Text(
                    "Women Grey Regular Sneakers",
                    maxLines: 1,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Icon(Icons.share_outlined)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
