import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/post/models/post_key.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:community_app/state/post_setting/models/post_setting.dart';
import 'package:flutter/material.dart';

@immutable
class PostPayload extends MapView<String, dynamic> {
  PostPayload({
    required UserId userId,
    required String message,
    required String thumbnailUrl,
    required String fileUrl,
    required String fileTye,
    required String fileName,
    required double aspecTRatio,
    required String thumbnailStorageId,
    required String originalFileStorageId,
    required Map<PostSetting, bool> postSetting,
  }) : super({
          PostKey.userId: userId,
          PostKey.message: message,
          PostKey.createdAt: FieldValue.serverTimestamp(),
          PostKey.thumbnailUrl: thumbnailUrl,
          PostKey.fileUrl: fileUrl,
          PostKey.fileType: fileTye,
          PostKey.fileName: fileName,
          PostKey.aspectRatio: aspecTRatio,
          PostKey.thumbnailStorageId: thumbnailStorageId,
          PostKey.originalFileStorageId: originalFileStorageId,
          PostKey.postSettings:
              postSetting.map((key, value) => MapEntry(key.storageKey, value)),
        });
}
