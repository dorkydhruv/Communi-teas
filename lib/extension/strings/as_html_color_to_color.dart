import 'package:community_app/extension/strings/remove_all.dart';
import 'package:flutter/material.dart';

extension AsHtmlColorToColor on String {
  Color asHtmlColorToColor() =>
      Color(int.parse(removeAll(['0x', '#']).padLeft(8, 'ff'), radix: 16));
}
