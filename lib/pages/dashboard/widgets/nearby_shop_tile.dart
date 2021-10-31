import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar (sunil@smarttersstudio.com)
/// On 31-10-2021 08:51 PM
///
class NearByShopTile extends StatelessWidget {
  const NearByShopTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                "https://image.freepik.com/free-vector/flat-sale-background_23-2147750048.jpg",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: const [
              SizedBox(width: 8),
              Expanded(
                  child: Text(
                "Goldmine record",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              )),
              SizedBox(width: 8),
              Material(
                color: Color(0xffC245BA),
                shape: StadiumBorder(),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(6, 4, 6, 4),
                  child: Text(
                    "CLASSY",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(width: 8),
            ],
          ),
          Row(
            children: const [
              Icon(
                Icons.location_on,
                size: 20,
                color: Colors.grey,
              ),
              Expanded(child: Text("Jaydev Vihar, Bbsr")),
              SizedBox(width: 6),
              Icon(
                Icons.directions_walk,
                size: 20,
                color: Colors.grey,
              ),
              Text("2 km"),
              SizedBox(width: 6),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
