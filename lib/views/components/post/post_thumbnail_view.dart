import 'package:community_app/state/post/models/post.dart';
import 'package:flutter/material.dart';

class PostThumbailView extends StatelessWidget {
  final Posts post;
  final VoidCallback onTap;
  const PostThumbailView({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Image.network(
          post.thumbnailUrl,
          fit: BoxFit.cover,
        ));
  }
}
