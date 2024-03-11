import 'dart:async';

import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/comments/model/post_comment_request.dart';
import 'package:community_app/state/comments/model/post_with_comments.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final specificPostWithCommentProvider = StreamProvider.autoDispose
    .family<PostWithComments, RequestForPostAndComments>(
        (ref, RequestForPostAndComments request) {
  final controller = StreamController<PostWithComments>();
  Posts? post;
  Iterable<Comment> comments;
  void notify() {
    final localPost = post;
    if (localPost == null) return;
    // final outputComments = (comments ?? []);
  }

  ref.onDispose(() {
    controller.close();
  });
  return controller.stream;
});
