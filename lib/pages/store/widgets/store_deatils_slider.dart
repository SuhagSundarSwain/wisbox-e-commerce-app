import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 06-11-2021 05:44 PM
///
class StoreDetailsSlider extends StatefulWidget {
  const StoreDetailsSlider(this.data, {Key? key}) : super(key: key);
  final Map<String, dynamic>? data;
  @override
  State<StoreDetailsSlider> createState() => _StoreDetailsSliderState();
}

class _StoreDetailsSliderState extends State<StoreDetailsSlider> {
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Positioned.fill(
                child: CarouselSlider.builder(
                    itemCount: 5,
                    itemBuilder: (context, index, prevIndex) {
                      return Card(
                        margin: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: widget.data == null
                            ? const SizedBox()
                            : Image.network(
                                widget.data!["image"],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      );
                    },
                    options: CarouselOptions(
                        aspectRatio: 1,
                        viewportFraction: 0.75,
                        autoPlay: true,
                        onPageChanged: (i, reason) {
                          setState(() {
                            _currentPage = i;
                          });
                        }))),
            Positioned(
              left: 22,
              right: 22,
              bottom: 42,
              child: Center(
                child: Wrap(
                    spacing: 6,
                    children: List.generate(
                      5,
                      (index) => Material(
                        color: _currentPage == index
                            ? Colors.white
                            : Colors.transparent,
                        shape: const CircleBorder(
                            side: BorderSide(color: Colors.white)),
                        child: const SizedBox.square(dimension: 8),
                      ),
                    )),
              ),
            ),
            Positioned(
              left: 22,
              top: 22,
              child: Material(
                color: Colors.white,
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back_rounded),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 22,
              top: 22,
              child: Material(
                color: Colors.white,
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () {},
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.bookmark),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
