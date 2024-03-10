import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/comments/typedefs/comment.dart';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/typedefs/post_id.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:flutter/material.dart';

@immutable
class Comment {
  final CommentId commentId;
  final DateTime createdAt;
  final String comment;
  final UserId fromUserId;
  final PostId onPostId;

  Comment(
    Map<String, dynamic> json, {
    required this.commentId,
  })  : comment = json[FirebaseFieldName.comment] as String,
        createdAt = (json[FirebaseFieldName.createdAt] as Timestamp).toDate(),
        fromUserId = json[FirebaseFieldName.userId] as String,
        onPostId = json[FirebaseFieldName.postId] as String;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Comment &&
          commentId == other.commentId &&
          comment == other.comment &&
          runtimeType == other.runtimeType &&
          createdAt == other.createdAt &&
          fromUserId == other.fromUserId &&
          onPostId == other.onPostId;

  @override
  int get hashCode =>
      Object.hashAll([commentId, comment, createdAt, fromUserId, onPostId]);
}
