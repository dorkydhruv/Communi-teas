import 'package:community_app/views/components/rich_text/link_text.dart';
import 'package:flutter/material.dart'
    show Colors, TextDecoration, TextStyle, VoidCallback, immutable;

@immutable
class BaseText {
  final String text;
  final TextStyle? style;
  const BaseText({
    required this.text,
    this.style,
  });
  factory BaseText.plain({
    required String text,
    TextStyle? style = const TextStyle(),
  }) =>
      BaseText(text: text, style: style);

  factory BaseText.link({
    required String text,
    required VoidCallback onTap,
    TextStyle? style = const TextStyle(
      color: Colors.blue,
      decoration: TextDecoration.underline,
    ),
  }) =>
      LinkText(text: text, style: style, onTap: onTap);
}
