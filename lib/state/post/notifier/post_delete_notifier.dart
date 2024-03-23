import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/image_upload/extension/get_collection_name.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeltePostNotifier extends StateNotifier<IsLoading> {
  DeltePostNotifier() : super(false);
  set isLoading(bool value) => state = value;

  Future<bool> deletePost({
    required Posts post,
  }) async {
    isLoading = true;
    try {
      //delete thumbnail
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(FirebaseCollectionName.thumbnails)
          .child(post.thumbnailStorageId)
          .delete();
      //delete original file
      await FirebaseStorage.instance
          .ref()
          .child(post.userId)
          .child(post.fileType.collectionName)
          .child(post.originalFileStorageId)
          .delete();
      //delete comments
      await deleteAllDoc(
        postId: post.postId,
        inCollection: FirebaseCollectionName.comments,
      );
      //delete likes
      await deleteAllDoc(
        postId: post.postId,
        inCollection: FirebaseCollectionName.likes,
      );
      //delete post
      final postInCollection = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .where(FieldPath.documentId, isEqualTo: post.postId)
          .limit(1)
          .get();
      for (final doc in postInCollection.docs) {
        await doc.reference.delete();
      }

      return true;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
    }
  }

  Future<void> deleteAllDoc({
    required String postId,
    required String inCollection,
  }) {
    return FirebaseFirestore.instance.runTransaction(
        maxAttempts: 3,
        timeout: const Duration(seconds: 30), (transaction) async {
      final query = await FirebaseFirestore.instance
          .collection(inCollection)
          .where(FirebaseFieldName.postId, isEqualTo: postId)
          .get();
      for (final doc in query.docs) {
        transaction.delete(doc.reference);
      }
    });
  }
}
