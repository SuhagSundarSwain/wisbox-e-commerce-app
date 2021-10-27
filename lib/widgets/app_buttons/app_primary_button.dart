import 'package:flutter/material.dart';
import 'package:nexmat/app_configs/environment.dart';

import '../app_loader.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton(
      {required this.child,
      Key? key,
      this.onPressed,
      this.height,
      this.width,
      this.color,
      this.shape,
      this.padding,
      this.textStyle})
      : super(key: key);

  final ShapeBorder? shape;
  final Widget child;
  final VoidCallback? onPressed;
  final double? height, width;
  final Color? color;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  @override
  AppPrimaryButtonState createState() => AppPrimaryButtonState();
}

class AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isLoading = false;

  void showLoader() {
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoader() {
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading
        ? Center(child: AppProgress(color: widget.color ?? theme.primaryColor))
        : Container(
            constraints: BoxConstraints(
                minWidth: widget.width ?? 200, minHeight: widget.height ?? 54),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: <BoxShadow>[
                if (widget.onPressed != null)
                  BoxShadow(
                    color: theme.primaryColor
                        .withOpacity(0.5), // Color(0xffff9a7a),
                    blurRadius: 12,
                    offset: Offset(0.5, 2.5),
                  ),
              ],
            ),
            child: ElevatedButton(
              // style: ButtonStyle(
              //   padding: MaterialStateProperty.all(
              //     widget.padding ??
              //         const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
              //   ),
              //   textStyle: MaterialStateProperty.resolveWith(
              //       (Set<MaterialState> states) {
              //     if (states.contains(MaterialState.disabled))
              //       return TextStyle(color: Colors.grey.shade500);

              //     return TextStyle(color: AppColors.brightPrimary);
              //   }),
              //   foregroundColor: MaterialStateProperty.resolveWith<Color?>(
              //     (Set<MaterialState> states) {
              //       if (states.contains(MaterialState.pressed))
              //         return AppColors.brightPrimary.shade800;
              //       else if (states.contains(MaterialState.disabled))
              //         return Colors.grey.shade500;
              //         return AppColors.brightPrimary;
              //     },
              //   )
              // ),
              style: ButtonStyle(
                  elevation: ButtonStyleButton.allOrNull(0),
                  foregroundColor: ButtonStyleButton.allOrNull(Colors.white),
                  textStyle: ButtonStyleButton.allOrNull(
                    TextStyle(
                      fontSize: 16,
                      fontFamily: Environment.fontFamily,
                    ),
                  ),
                  overlayColor: ButtonStyleButton.allOrNull(Colors.black12)),
              // style: ElevatedButton.styleFrom(
              //   primary: theme.primaryColor,
              //   shadowColor: Color(0xffff9a7a),
              //   elevation: 0,
              //   padding: widget.padding ??
              //       const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(16)),
              //   onPrimary: Colors.white,
              //   textStyle: widget.textStyle ??
              //       TextStyle(
              //           fontSize: 18,
              //           fontFamily: Environment.fontFamily,
              //           letterSpacing: 1.4,
              //           fontWeight: FontWeight.w500),
              // ),
              onPressed: widget.onPressed,
              child: widget.child,
            ),
          );
  }
}
