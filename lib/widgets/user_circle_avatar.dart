import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class UserCircleAvatar extends StatelessWidget {
  final String? userId;
  final String? name;
  final String? imageUrl;
  final double? radius;

  const UserCircleAvatar(this.imageUrl, {this.userId, this.name, this.radius});

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return AvatarPlaceholder(
        name ?? ' ',
        backgroundColor: const Color(0xffF3F3F3),
        radius: radius ?? 32,
        textColor: Colors.black,
      );
    }
    return Hero(
      tag: userId ?? UniqueKey().toString(),
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        fit: BoxFit.cover,
        imageBuilder: (context, provider) => CircleAvatar(
          backgroundImage: provider,
          radius: radius ?? 32,
        ),
        errorWidget: (c, s, d) => AvatarPlaceholder(
          name ?? ' ',
          backgroundColor: const Color(0xffF3F3F3),
          radius: radius ?? 32,
          textColor: Colors.black,
        ),
        placeholder: (context, url) => AvatarPlaceholder(
          name ?? ' ',
          backgroundColor: const Color(0xffF3F3F3),
          radius: radius ?? 32,
          textColor: Colors.black,
        ),
      ),
    );
  }
}

class AvatarPlaceholder extends StatelessWidget {
  final String? firstLetter;
  final double? radius;
  final Color? backgroundColor, textColor;
  AvatarPlaceholder(this.firstLetter,
      {Key? key, this.radius, this.backgroundColor, this.textColor})
      : assert(firstLetter != null, firstLetter?.isNotEmpty),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Text(firstLetter?[0] ?? "", style: const TextStyle(fontSize: 22)),
      radius: radius,
      backgroundColor: Colors.grey[300],
    );
  }
}
