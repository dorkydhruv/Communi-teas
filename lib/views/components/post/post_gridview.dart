import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/views/components/post/post_thumbnail_view.dart';
import 'package:flutter/material.dart';

class PostGridView extends StatelessWidget {
  final Iterable<Posts> posts;
  const PostGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisExtent: 8,
        crossAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbailView(
            post: post,
            onTap: () {
              //post detail view
            });
      },
    );
  }
}
