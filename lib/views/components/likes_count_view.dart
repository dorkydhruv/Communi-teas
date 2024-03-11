import 'package:community_app/state/likes/provider/post_likes.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/views/components/animations/loading_animation_view.dart';
import 'package:community_app/views/components/animations/small_error_animation_view.dart';
import 'package:community_app/views/components/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LikesCountView extends ConsumerWidget {
  final PostId postId;
  const LikesCountView({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (count) {
        final personOrPeople = count == 1 ? Strings.person : Strings.people;
        final likesText = '$count $personOrPeople ${Strings.likedThis}.';
        return Text(likesText);
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const LoadingAnimationView(),
    );
  }
}
