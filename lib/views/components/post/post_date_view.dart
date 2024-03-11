import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  final DateTime dateTime;
  const PostDateView({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final formattor = DateFormat('dd MMM, yyyy, hh:mm a');
    return Padding(
      padding: const EdgeInsets.only(
        left: 9,
      ),
      child: Text(
        formattor.format(
          dateTime,
        ),
      ),
    );
  }
}
