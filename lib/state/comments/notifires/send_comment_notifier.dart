import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/comments/model/comment_payload.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SendCommentNotifier extends StateNotifier<IsLoading> {
  SendCommentNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> sendComment({
    required UserId userId,
    required PostId onPostId,
    required String comment,
  }) async {
    isLoading = true;
    try {
      final payload = CommentPayload(
          fromUserId: userId, onPostId: onPostId, comment: comment);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
