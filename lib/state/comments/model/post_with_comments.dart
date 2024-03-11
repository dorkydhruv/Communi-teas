import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:flutter/foundation.dart';

@immutable
class PostWithComments {
  final Posts post;
  final Iterable<Comment> comments;
  const PostWithComments({required this.post, required this.comments});

  @override
  operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PostWithComments &&
        other.post == post &&
        other.comments == comments;
  }

  @override
  int get hashCode => post.hashCode ^ comments.hashCode;
}
