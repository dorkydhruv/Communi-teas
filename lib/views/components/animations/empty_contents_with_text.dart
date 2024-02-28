import 'package:community_app/views/components/animations/empty_contents_Animation_view.dart';
import 'package:flutter/material.dart';

class EmptyContentsWithText extends StatelessWidget {
  final String text;
  const EmptyContentsWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white54),
            ),
          ),
          const EmptyAnimationView(),
        ],
      ),
    );
  }
}
