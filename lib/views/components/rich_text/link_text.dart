import 'package:community_app/views/components/rich_text/base_text.dart';
import 'package:flutter/material.dart';

@immutable
class LinkText extends BaseText {
  final VoidCallback onTap;
  const LinkText({
    required super.text,
    super.style,
    required this.onTap,
  });
}
