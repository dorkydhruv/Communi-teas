import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/post/models/post_key.dart';
import 'package:community_app/state/post_setting/models/post_setting.dart';
import 'package:flutter/material.dart';

@immutable
class Posts {
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final double aspectRatio;
  final String thumbnailStorageId;
  final String originalFileStorageId;
  final Map<PostSetting, bool> postSettings;

  Posts({
    required this.postId,
    required Map<String, dynamic> json,
  })  : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createdAt = ((json[PostKey.createdAt]) as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileUrl],
        fileType = FileType.values.firstWhere(
          (filetype) => json[PostKey.fileType] == filetype.name,
          orElse: () => FileType.image,
        ),
        aspectRatio = json[PostKey.aspectRatio],
        fileName = json[PostKey.fileName],
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalFileStorageId = json[PostKey.originalFileStorageId],
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSetting.values
                    .firstWhere((element) => element.storageKey == entry.key):
                entry.value
        };

  bool get allowLikes => postSettings[PostSetting.allowLikes] ?? false;
  bool get allowComments => postSettings[PostSetting.allowComments] ?? false;
}
