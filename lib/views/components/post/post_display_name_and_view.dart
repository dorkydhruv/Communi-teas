import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/state/user_info/providers/user_info_provider.dart';
import 'package:community_app/views/components/animations/small_error_animation_view.dart';
import 'package:community_app/views/components/rich_two_parts_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostDisplayAndMessageView extends ConsumerWidget {
  final Posts post;
  const PostDisplayAndMessageView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(
      userInfoModelProvider(
        post.userId,
      ),
    );
    return userInfoModel.when(
      data: (userInfo) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: RichTwoPartsText(
            leftPart: userInfo.displayName,
            rightPart: post.message,
          ),
        );
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
