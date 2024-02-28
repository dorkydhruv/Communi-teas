import 'package:community_app/views/components/animations/lottie_animation_view.dart';
import 'package:community_app/views/components/animations/models/lottie_animation.dart';

class EmptyAnimationView extends LottieAnimationView {
  const EmptyAnimationView({super.key})
      : super(
          animation: LottieAnimation.empty,
        );
}
