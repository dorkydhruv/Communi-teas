import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/comments/providers/delete_comment_provider.dart';
import 'package:community_app/state/user_info/providers/user_info_provider.dart';
import 'package:community_app/views/components/animations/small_error_animation_view.dart';
import 'package:community_app/views/components/constants/strings.dart';
import 'package:community_app/views/components/dialogs/alert.dart';
import 'package:community_app/views/components/dialogs/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CommentTile extends ConsumerWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (data) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  onPressed: () async {
                    final shouldDeleteComment =
                        await displayDeleteDialog(context);
                    if (shouldDeleteComment) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.commentId);
                    }
                  },
                  icon: const Icon(Icons.delete),
                )
              : null,
          title: Text(data.displayName),
          subtitle: Text(comment.comment),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }

  Future<bool> displayDeleteDialog(
    BuildContext context,
  ) =>
      DeleteDialog(titleOfObjectToDelete: Strings.comment)
          .present(context)
          .then((value) => value ?? false);
}
