import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/views/components/comments/comapct_comment_tile.dart';
import 'package:flutter/material.dart';

class CommentColumn extends StatelessWidget {
  final Iterable<Comment> comments;
  const CommentColumn({super.key, required this.comments});

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: comments
              .map((comment) => CompactCommentTile(comment: comment))
              .toList(),
        ),
      );
    }
  }
}
