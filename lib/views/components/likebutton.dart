import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/likes/models/likes_dislike_req.dart';
import 'package:community_app/state/likes/provider/like_dislike_provider.dart';
import 'package:community_app/state/likes/provider/like_value_provider.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/views/components/animations/small_error_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LikeButton extends ConsumerWidget {
  final PostId postId;
  const LikeButton({super.key, required this.postId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(
      hasLikePostProvider(
        postId,
      ),
    );
    return hasLiked.when(
      data: (hasLiked) {
        return IconButton(
            onPressed: () {
              final userId = ref.read(userIdProvider);
              if (userId == null) {
                return;
              }
              final likeRequest =
                  LikeDislikeRequest(postId: postId, likedBy: userId);
              ref.read(likeDislikePostProvider(likeRequest));
            },
            icon: Icon(
              hasLiked ? Icons.favorite : Icons.favorite_border,
            ));
      },
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
