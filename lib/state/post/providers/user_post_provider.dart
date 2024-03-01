import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/state/post/models/post_key.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userPostProvider = StreamProvider.autoDispose<Iterable<Posts>>((ref) {
  final userId = ref.watch(userIdProvider);
  final controller = StreamController<Iterable<Posts>>();
  controller.onListen = () {
    controller.sink.add([]);
  };
  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.posts,
      )
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .where(PostKey.userId, isEqualTo: userId)
      .snapshots()
      .listen((snapshot) {
    final documents = snapshot.docs;
    final posts = documents.where((doc) => !doc.metadata.hasPendingWrites).map(
          (doc) => Posts(
            postId: doc.id,
            json: doc.data(),
          ),
        );
    controller.sink.add(posts);
  });
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });
  return controller.stream;
});
