import 'package:flutter/material.dart';

///
/// Created by Sunil Kumar from Boiler plate
///
mixin AppDecorations {
  static InputDecoration textFieldDecoration(BuildContext context,
      {double radius = 8}) {
    return const InputDecoration(
        filled: false,
        counterText: '',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
        contentPadding: EdgeInsets.fromLTRB(20.0, 16.0, 20.0, 16.0),
        border: InputBorder.none);
  }

  static BoxDecoration get appBoxDecoration => BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x1ac29146),
            blurRadius: 12,
            offset: Offset(0.5, 2.5),
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      );
}
