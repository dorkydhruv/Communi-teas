import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/state/post/typedefs/search_term.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final postSearchByTermProvider = StreamProvider.family
    .autoDispose<Iterable<Posts>, SearchTerm>((ref, SearchTerm searchTerm) {
  final controller = StreamController<Iterable<Posts>>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(FirebaseFieldName.createdAt, descending: true)
      .snapshots()
      .listen((snapshot) {
    final posts =
        snapshot.docs.map((doc) => Posts(postId: doc.id, json: doc.data()));
    controller.add(
        posts.where((post) => post.message.contains(searchTerm.toLowerCase())));
  });

  ref.onDispose(() {
    controller.close();
    sub.cancel();
  });

  return controller.stream;
});
