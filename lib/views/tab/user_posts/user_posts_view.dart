import 'package:community_app/state/post/providers/user_post_provider.dart';
import 'package:community_app/views/components/animations/empty_contents_with_text.dart';
import 'package:community_app/views/components/animations/error_animation_view.dart';
import 'package:community_app/views/components/animations/loading_animation_view.dart';
import 'package:community_app/views/components/post/list_view_post.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostProvider);
    return RefreshIndicator.adaptive(
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithText(
              text: Strings.noPostsAvailable,
            );
          }
          return PostGridView(posts: posts);
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () {
          return const LoadingAnimationView();
        },
      ),
      onRefresh: () {
        Future.delayed(const Duration(seconds: 1));
        return ref.refresh(userPostProvider as Refreshable<Future<void>>);
      },
    );
  }
}
