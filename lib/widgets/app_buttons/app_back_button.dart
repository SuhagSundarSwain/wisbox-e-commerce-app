import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppBackButton extends StatelessWidget {
  final Color? color;
  final EdgeInsets? padding;
  final VoidCallback? onPressed;

  const AppBackButton({this.color, this.padding, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      color: Colors.transparent,
      type: MaterialType.circle,
      child: InkWell(
        onTap: onPressed ??
            () {
              FocusScope.of(context).unfocus();
              Navigator.maybePop(context);
            },
        child: Center(
          child: Padding(
              padding: padding ?? const EdgeInsets.only(right: 16, left: 16),
              child: Icon(Icons.arrow_back_rounded,
                  color: color ?? Theme.of(context).iconTheme.color)),
        ),
      ),
    );
  }
}
