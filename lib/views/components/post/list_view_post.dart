import 'package:community_app/state/post/models/post.dart';
import 'package:community_app/views/components/post/post_thumbnail_view.dart';
import 'package:community_app/views/post_details/post_details_view.dart';
import 'package:flutter/material.dart';

class PostGridView extends StatelessWidget {
  final Iterable<Posts> posts;
  const PostGridView({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (context, index) {
          final post = posts.elementAt(index);
          return PostThumbailView(
            post: post,
            onTap: () {
              //open post
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => PostDetailView(post: post),
              ));
            },
          );
        },
        itemCount: posts.length);
  }
}
