import 'package:community_app/state/post/models/post.dart';
import 'package:flutter/material.dart';

class PostImageView extends StatelessWidget {
  final Posts post;
  const PostImageView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: post.aspectRatio,
        child: Image.network(
          post.fileUrl,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          fit: BoxFit.cover,
        ));
  }
}
