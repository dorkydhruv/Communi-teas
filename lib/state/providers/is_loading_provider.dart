import 'package:community_app/state/auth/providers/auth_provider.dart';
import 'package:community_app/state/comments/providers/delete_comment_provider.dart';
import 'package:community_app/state/comments/providers/send_comment_provider.dart';
import 'package:community_app/state/image_upload/providers/image_upload_provider.dart';
import 'package:community_app/state/providers/delete_post_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authstate = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUplaodProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeltingPost = ref.watch(deltePOstProvider);
  return authstate.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingComment ||
      isDeltingPost;
});
