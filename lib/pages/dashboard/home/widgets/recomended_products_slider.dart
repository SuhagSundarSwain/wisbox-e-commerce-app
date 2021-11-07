import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 05-11-2021 08:47 PM
///
class RecommendedProductsSlider extends StatelessWidget {
  const RecommendedProductsSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: 5,
        itemBuilder: (context, index, prevIndex) {
          return const RecommendedProduct();
        },
        options: CarouselOptions(
            enlargeCenterPage: true, aspectRatio: 1, viewportFraction: 0.75));
  }
}

class RecommendedProduct extends StatelessWidget {
  const RecommendedProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
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
                Icon(Icons.bookmark)
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class OfferCustomPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xff472198)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width / 2, size.height - 16)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant OfferCustomPaint oldDelegate) {
    return false;
  }
}
