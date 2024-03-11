import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postLikesCountProvider =
    StreamProvider.autoDispose.family<int, PostId>((ref, PostId postId) {
  final controller = StreamController<int>.broadcast();
  controller.onListen = () => controller.sink.add(0);
  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .snapshots()
      .listen((event) {
    controller.sink.add(
      event.docs.length,
    );
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
