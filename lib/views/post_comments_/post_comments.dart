import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/comments/model/post_comment_request.dart';
import 'package:community_app/state/comments/providers/post_comment_provider.dart';
import 'package:community_app/state/comments/providers/send_comment_provider.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/views/components/animations/empty_contents_Animation_view.dart';
import 'package:community_app/views/components/animations/empty_contents_with_text.dart';
import 'package:community_app/views/components/animations/loading_animation_view.dart';
import 'package:community_app/views/components/comments/comments_tile.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:community_app/views/extensions/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostCommentView extends HookConsumerWidget {
  final PostId postId;
  const PostCommentView({super.key, required this.postId});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasText = useState(false);
    final request = useState(RequestForPostAndComments(postId: postId));
    final comments = ref.watch(postCommentProvider(request.value));
    useEffect(() {
      commentController.addListener(() {
        hasText.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          IconButton(
              onPressed: hasText.value
                  ? () {
                      submitController(controller: commentController, ref: ref);
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SafeArea(
          child: Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            flex: 4,
            child: comments.when(
              data: (data) {
                if (data.isEmpty) {
                  return const SingleChildScrollView(
                    child: EmptyContentsWithText(text: Strings.noCommentsYet),
                  );
                } else {
                  return RefreshIndicator(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          final comment = data.elementAt(index);
                          return CommentTile(comment: comment);
                        },
                        itemCount: data.length,
                        padding: EdgeInsets.all(8),
                      ),
                      onRefresh: () {
                        ref.refresh(postCommentProvider(request.value));
                        return Future.delayed(Durations.long1);
                      });
                }
              },
              error: (error, stackTrace) => const EmptyAnimationView(),
              loading: () => const LoadingAnimationView(),
            ),
          ),
          Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    textInputAction: TextInputAction.send,
                    controller: commentController,
                    onSubmitted: (comment) {
                      if (comment.isNotEmpty) {
                        submitController(
                            controller: commentController, ref: ref);
                      }
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: Strings.writeYourCommentHere,
                    ),
                  ),
                ),
              ))
        ],
      )),
    );
  }

  Future<void> submitController({
    required TextEditingController controller,
    required WidgetRef ref,
  }) async {
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSent = await ref.read(sendCommentProvider.notifier).sendComment(
        userId: userId, onPostId: postId, comment: controller.text);
    if (isSent) {
      controller.clear();
      dismissKeyBoard();
    }
  }
}
