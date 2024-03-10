import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/comments/typedefs/comment.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteCommentNotifier extends StateNotifier<IsLoading> {
  DeleteCommentNotifier() : super(false);
  set isLoading(bool val) => state = val;

  Future<bool> deleteComment({
    required CommentId commentId,
  }) async {
    try {
      isLoading = true;
      final query = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.comments)
          .where(FirebaseFieldName.comment, isEqualTo: commentId)
          .limit(1)
          .get();
      await query.then((query) async {
        for (final doc in query.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
