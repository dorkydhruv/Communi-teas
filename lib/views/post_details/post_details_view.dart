import 'package:community_app/enums/date_sorting.dart';
import 'package:community_app/state/comments/model/post_comment_request.dart';
import 'package:community_app/state/comments/providers/specific_post_with_comment_provider.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/state/providers/can_current_delete_provider.dart';
import 'package:community_app/state/providers/delete_post_provider.dart';
import 'package:community_app/views/components/animations/error_animation_view.dart';
import 'package:community_app/views/components/animations/loading_animation_view.dart';
import 'package:community_app/views/components/animations/small_error_animation_view.dart';
import 'package:community_app/views/components/comments/comapct_comment_tile.dart';
import 'package:community_app/views/components/comments/copmact_column_comment.dart';
import 'package:community_app/views/components/dialogs/alert.dart';
import 'package:community_app/views/components/dialogs/delete_dialog.dart';
import 'package:community_app/views/components/likebutton.dart';
import 'package:community_app/views/components/likes_count_view.dart';
import 'package:community_app/views/components/post/post_date_view.dart';
import 'package:community_app/views/components/post/post_display_name_and_view.dart';
import 'package:community_app/views/components/post/post_image_or_video_view.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:community_app/views/post_comments_/post_comments.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

class PostDetailView extends ConsumerStatefulWidget {
  final Posts post;
  const PostDetailView({super.key, required this.post});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends ConsumerState<PostDetailView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComments(
        postId: widget.post.postId,
        limit: 3,
        sortByCreatedAt: true,
        dateSorting: DateSorting.oldestOnTop);
    //get post and comments
    final postWithComments =
        ref.watch(specificPostWithCommentProvider(request));
    //can delete post
    final canDelete = ref.watch(canCurrentUserDelteProvider(widget.post));
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          //share button
          postWithComments.when(
            data: (postWithComments) {
              return IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  //share post
                  final url = postWithComments.post.fileUrl;
                  Share.share(url, subject: postWithComments.post.message);
                },
              );
            },
            error: (e, s) => const SmallErrorAnimationView(),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
          //deletButton
          if (canDelete.valueOrNull ?? false)
            IconButton(
                onPressed: () async {
                  //delete post
                  final shouldDeletePOst =
                      await DeleteDialog(titleOfObjectToDelete: Strings.post)
                          .present(context)
                          .then((value) => value ?? false);
                  if (shouldDeletePOst) {
                    ref
                        .read(deltePOstProvider.notifier)
                        .deletePost(post: widget.post);
                  }
                  if (mounted) Navigator.pop(context);
                },
                icon: const Icon(Icons.delete))
        ],
      ),
      body: postWithComments.when(
        data: (postWithComments) {
          final postId = postWithComments.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostImageOrVideoView(post: postWithComments.post),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (postWithComments.post.allowLikes)
                      LikeButton(postId: postId),
                    if (postWithComments.post.allowComments)
                      IconButton(
                          onPressed: () {
                            //navigate to comments
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PostCommentView(
                                  postId: postId,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.comment))
                  ],
                ),
                PostDisplayAndMessageView(post: postWithComments.post),
                PostDateView(dateTime: postWithComments.post.createdAt),
                const Divider(
                  color: Colors.white70,
                ),
                CommentColumn(comments: postWithComments.comments),
                if (postWithComments.post.allowLikes)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        LikesCountView(postId: postId),
                      ],
                    ),
                  ),
                //add spacing
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          );
        },
        error: (s, e) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
