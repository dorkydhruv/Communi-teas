import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
class LikeDislikeRequest {
  final PostId postId;
  final UserId likedBy;
  const LikeDislikeRequest({
    required this.postId,
    required this.likedBy,
  });
}
