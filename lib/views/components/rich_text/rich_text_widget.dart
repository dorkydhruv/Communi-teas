import 'package:community_app/views/components/rich_text/base_text.dart';
import 'package:community_app/views/components/rich_text/link_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final Iterable<BaseText> text;
  final TextStyle? styleForAll;
  const RichTextWidget({
    super.key,
    required this.text,
    this.styleForAll,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(
      children: text.map((basetext) {
        if (basetext is LinkText) {
          return TextSpan(
            text: basetext.text,
            style: styleForAll?.merge(basetext.style),
            recognizer: TapGestureRecognizer()..onTap = basetext.onTap,
          );
        } else {
          return TextSpan(
            text: basetext.text,
            style: styleForAll?.merge(basetext.style),
          );
        }
      }).toList(),
    ));
  }
}
