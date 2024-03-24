import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final allPostProvider = StreamProvider.autoDispose<Iterable<Posts>>((ref) {
  final controller = StreamController<Iterable<Posts>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((event) {
    final posts = event.docs.map((e) => Posts(postId: e.id, json: e.data()));
    controller.add(posts);
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
