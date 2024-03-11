import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final hasLikePostProvider =
    StreamProvider.family.autoDispose<bool, PostId>((ref, PostId postId) {
  final userId = ref.watch(userIdProvider);
  if (userId == null) {
    return const Stream.empty();
  }

  final controller = StreamController<bool>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: postId)
      .where(FirebaseFieldName.userId, isEqualTo: userId)
      .snapshots()
      .listen((snapshot) {
    controller.add(snapshot.docs.isNotEmpty);
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
