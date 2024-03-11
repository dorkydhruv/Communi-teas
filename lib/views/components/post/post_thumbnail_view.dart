import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:flutter/material.dart';

class PostThumbailView extends StatelessWidget {
  final Posts post;
  final VoidCallback onTap;
  const PostThumbailView({super.key, required this.post, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          margin: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[500],
                  ),
                  child: post.fileType == FileType.image
                      ? Image.network(
                          post.fileUrl,
                          height: 200,
                          fit: BoxFit.fitWidth,
                        )
                      : Stack(
                          children: [
                            Image.network(
                              post.thumbnailUrl,
                              height: 200,
                              fit: BoxFit.fitWidth,
                            ),
                            const Icon(
                              Icons.play_arrow,
                              size: 200,
                            ),
                          ],
                        )),
              const SizedBox(
                height: 8,
              ),
              Text(
                post.message,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                post.createdAt.toString(),
                style: const TextStyle(
                  fontSize: 8,
                ),
              ),
            ],
          ),
        ));
  }
}
