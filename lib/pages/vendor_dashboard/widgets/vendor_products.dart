import 'package:flutter/material.dart';
import 'package:nexmat/pages/dashboard/home/widgets/deal_of_ther_slider.dart';
import 'package:nexmat/pages/dashboard/home/widgets/recomended_products_slider.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 09-11-2021 04:42 PM
///
class VendorProducts extends StatelessWidget {
  const VendorProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.all(16),
            children: [
              'a',
              'b',
              'c',
              'd',
              'e',
              'f',
              'g',
              'h',
              'i',
              'j',
              'k',
              'l',
              'm',
              'n',
              'o',
              'p',
              'q',
              'r',
              's',
              't',
              'u',
              'v',
              'w',
              'x',
              'y',
              'z'
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ActionChip(
                        onPressed: () {},
                        label: Text(e),
                        labelStyle: const TextStyle(fontSize: 18),
                        backgroundColor: const Color(0xffDDD8FF),
                        padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
                      ),
                    ))
                .toList(),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Text(
            "Add product to Customer\'s cart",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          height: 400,
          child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.2),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return DealOfDayProduct();
              }),
        )
      ],
    );
  }
}

class DealOfDayProduct extends StatelessWidget {
  const DealOfDayProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
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
      ]),
    );
  }
}
