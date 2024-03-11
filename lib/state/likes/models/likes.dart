import 'dart:collection' show MapView;
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:flutter/material.dart' show immutable;

@immutable
class Like extends MapView<String, String> {
  Like({
    required PostId postId,
    required UserId likedBy,
    required DateTime dateTime,
  }) : super({
          FirebaseFieldName.postId: postId,
          FirebaseFieldName.userId: likedBy,
          FirebaseFieldName.date: dateTime.toIso8601String(),
        });
}
