import 'package:community_app/state/post/providers/posts_by_search_term_provider.dart';
import 'package:community_app/views/components/animations/data_not_found_animation.dart';
import 'package:community_app/views/components/animations/empty_contents_with_text.dart';
import 'package:community_app/views/components/animations/error_animation_view.dart';
import 'package:community_app/views/components/post/list_view_post.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchGridView extends ConsumerWidget {
  final String searchTerm;
  const SearchGridView({super.key, required this.searchTerm});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const EmptyContentsWithText(text: Strings.enterYourSearchTerm);
    }
    final posts = ref.watch(postSearchByTermProvider(searchTerm));
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const DataNotFoundView();
        } else {
          return PostGridView(posts: posts);
        }
      },
      error: (s, e) => const ErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
