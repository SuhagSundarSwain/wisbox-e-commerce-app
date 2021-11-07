import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 05-11-2021 08:00 PM
///
class MostTrendingStoreTile extends StatelessWidget {
  const MostTrendingStoreTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 0.95,
      child: Stack(
        children: [
          const Positioned.fill(child: ColoredBox(color: Color(0xffDFDBFF))),
          Positioned(
              top: 48,
              bottom: 48,
              width: size.width / 1.3,
              right: 16,
              child: const ColoredBox(color: Color(0x4d7a69ff))),
          Positioned(
              top: 22,
              left: 32,
              child: Material(
                type: MaterialType.circle,
                clipBehavior: Clip.antiAlias,
                color: const Color(0xff1A2A3A),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 6, 12, 12),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.people,
                        color: Colors.red,
                      ),
                      Text(
                        "73 Now",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ),
              )),
          Positioned(
              top: 100,
              left: 32,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "CAESARS",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Awaits you",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              )),
          Positioned(
              right: 38,
              top: 22,
              bottom: 100,
              width: 140,
              child: Material(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(8)),
                child: Image.network(
                  "https://images.pexels.com/photos/462030/pexels-photo-462030.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  fit: BoxFit.cover,
                ),
              )),
          const Positioned(
              height: 160,
              bottom: 16,
              width: 80,
              left: 16,
              child: ColoredBox(color: Color(0xffD9E2FF))),
          Positioned(
              height: 200,
              bottom: 32,
              width: 140,
              left: 32,
              child: Material(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    side: const BorderSide(color: Colors.white, width: 1.2),
                    borderRadius: BorderRadius.circular(8)),
                child: Image.network(
                  "https://images.pexels.com/photos/462030/pexels-photo-462030.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
              right: 32,
              bottom: 22,
              child: ElevatedButton(
                onPressed: () {},
                child: Row(
                  children: const [
                    Text("Visit Now"),
                    SizedBox(width: 2),
                    Icon(Icons.navigate_next)
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
