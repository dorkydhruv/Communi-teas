import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/likes/models/likes.dart';
import 'package:community_app/state/likes/models/likes_dislike_req.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final likeDislikePostProvider = FutureProvider.family
    .autoDispose<bool, LikeDislikeRequest>(
        (ref, LikeDislikeRequest request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.likes)
      .where(FirebaseFieldName.postId, isEqualTo: request.postId)
      .where(FirebaseFieldName.userId, isEqualTo: request.likedBy)
      .get();
  //check if liked
  final hasLiked = await query.then(
    (snapshot) => snapshot.docs.isNotEmpty,
  );
  if (hasLiked) {
    //delete Liked
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  } else {
    //add like
    final like = Like(
      postId: request.postId,
      likedBy: request.postId,
      dateTime: DateTime.now(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.likes)
          .add(like);
      return true;
    } catch (_) {
      return false;
    }
  }
});
