import 'package:community_app/state/post_setting/constants/constants.dart';

enum PostSetting {
  allowLikes(
    title: Constants.allowLikes,
    description: Constants.allowLikesDescription,
    storageKey: Constants.allowLikesStorage,
  ),
  allowComments(
    title: Constants.alllowCommentsTile,
    description: Constants.allowCommentsDescription,
    storageKey: Constants.allowCommentsStorage,
  );

  final String title;
  final String description;
  final String storageKey;

  const PostSetting({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
