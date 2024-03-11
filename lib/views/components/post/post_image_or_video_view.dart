import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/views/components/post/post_image_view.dart';
import 'package:community_app/views/components/post/post_video.dart';
import 'package:flutter/material.dart';

class PostImageOrVideoView extends StatelessWidget {
  final Posts post;
  const PostImageOrVideoView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    switch (post.fileType) {
      case FileType.image:
        return PostImageView(post: post);
      case FileType.video:
        return PostVideoView(post: post);
      default:
        return const SizedBox();
    }
  }
}
