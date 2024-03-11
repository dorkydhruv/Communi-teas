import 'package:community_app/state/comments/model/comment.dart';
import 'package:community_app/state/user_info/providers/user_info_provider.dart';
import 'package:community_app/views/components/animations/loading_animation_view.dart';
import 'package:community_app/views/components/animations/small_error_animation_view.dart';
import 'package:community_app/views/components/rich_two_parts_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CompactCommentTile extends ConsumerWidget {
  final Comment comment;
  const CompactCommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(
      userInfoModelProvider(comment.fromUserId),
    );
    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartsText(
            leftPart: userInfo.displayName, rightPart: comment.comment);
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: LoadingAnimationView(),
      ),
    );
  }
}
