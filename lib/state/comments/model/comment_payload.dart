import 'dart:collection' show MapView;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
class CommentPayload extends MapView<String, dynamic> {
  CommentPayload({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) : super({
          FirebaseFieldName.userId: fromUserId,
          FirebaseFieldName.comment: comment,
          FirebaseFieldName.postId: onPostId,
          FirebaseFieldName.createdAt: FieldValue.serverTimestamp(),
        });
}
