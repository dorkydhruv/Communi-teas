import 'package:community_app/views/components/animations/models/lottie_animation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationView extends StatelessWidget {
  final LottieAnimation animation;
  final bool? repeat;
  final bool? reverse;
  const LottieAnimationView(
      {super.key, required this.animation, this.repeat, this.reverse});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      animation.fullPath,
      repeat: repeat,
      reverse: repeat,
    );
  }
}

extension GetFullPath on LottieAnimation {
  String get fullPath => 'assets/$name.json';
}
