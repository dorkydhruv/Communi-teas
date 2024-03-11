import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/views/components/animations/loading_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:video_player/video_player.dart';

class PostVideoView extends HookWidget {
  final Posts post;
  const PostVideoView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final controller =
        VideoPlayerController.networkUrl(Uri.parse(post.fileUrl));
    final isVideoPlayerReady = useState(false);
    useEffect(() {
      controller.initialize().then((value) {
        isVideoPlayerReady.value = true;
        controller.setLooping(true);
        controller.play();
      });
      return controller.dispose;
    }, [controller]);

    if (isVideoPlayerReady.value) {
      return AspectRatio(
        aspectRatio: post.aspectRatio,
        child: VideoPlayer(controller),
      );
    } else {
      return const LoadingAnimationView();
    }
  }
}
