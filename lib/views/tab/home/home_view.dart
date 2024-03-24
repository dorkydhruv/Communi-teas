import 'package:community_app/state/post/providers/all_post_provider.dart';
import 'package:community_app/views/components/animations/empty_contents_Animation_view.dart';
import 'package:community_app/views/components/animations/error_animation_view.dart';
import 'package:community_app/views/components/post/list_view_post.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostProvider);
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1), () {
          ref.refresh(allPostProvider);
        });
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyAnimationView();
          }
          return PostGridView(posts: posts);
        },
        error: (s, e) => const ErrorAnimationView(),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
