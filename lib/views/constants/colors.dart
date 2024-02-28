import 'package:community_app/extension/strings/as_html_color_to_color.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart' show Colors;

@immutable
class AppColors {
  static final loginButtonColor = '#cfc9c2'.asHtmlColorToColor();
  static const loginButtonTextColor = Colors.black;
  static final googleColor = '#4285F4'.asHtmlColorToColor();
  static final facebookColor = '#3b5998'.asHtmlColorToColor();
  const AppColors._();
}
