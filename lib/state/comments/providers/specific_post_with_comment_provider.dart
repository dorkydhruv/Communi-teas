import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/comments/extensiion/comments_sorting_bu_request.dart';
import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/comments/model/post_comment_request.dart';
import 'package:community_app/state/comments/model/post_with_comments.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final specificPostWithCommentProvider = StreamProvider.autoDispose
    .family<PostWithComments, RequestForPostAndComments>(
        (ref, RequestForPostAndComments request) {
  final controller = StreamController<PostWithComments>();
  Posts? post;
  Iterable<Comment>? comments;
  void notify() {
    final localPost = post;
    if (localPost == null) return;
    final outputComments = (comments ?? []).applySortingFrom(request);
    final result = PostWithComments(post: localPost, comments: outputComments);
    controller.sink.add(result);
  }

  //watch changes
  final postSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .where(FieldPath.documentId, isEqualTo: request.postId)
      .limit(1)
      .snapshots()
      .listen((event) {
    if (event.docs.isEmpty) {
      post = null;
      comments = null;
      notify();
      return;
    }
    final doc = event.docs.first;
    if (doc.metadata.hasPendingWrites) return;
    post = Posts(postId: doc.id, json: doc.data());
  });

  final comment = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .orderBy(FirebaseFieldName.createdAt, descending: true);

  final limitedRequestQuery =
      request.limit != null ? comment.limit(request.limit!) : comment;

  final commentsSub = limitedRequestQuery.snapshots().listen((event) {
    comments = event.docs
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((doc) => Comment(commentId: doc.id, doc.data()))
        .toList();
    notify();
  });

  ref.onDispose(() {
    controller.close();
    commentsSub.cancel();
    postSub.cancel();
  });

  return controller.stream;
});
