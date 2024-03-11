import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/comments/extensiion/comments_sorting_bu_request.dart';
import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/comments/model/post_comment_request.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postCommentProvider = StreamProvider.family
    .autoDispose<Iterable<Comment>, RequestForPostAndComments>(
        (ref, RequestForPostAndComments request) {
  final controller = StreamController<Iterable<Comment>>();
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.comments)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .snapshots()
      .listen((snaps) {
    final doc = snaps.docs;
    final limitDocuments =
        request.limit != null ? doc.take(request.limit!) : doc;
    final comments = limitDocuments
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Comment(
            doc.data(),
            commentId: doc.id,
          ),
        );
    final result = comments.applySortingFrom(request);
    controller.sink.add(result);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
