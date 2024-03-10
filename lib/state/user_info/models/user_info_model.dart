import 'dart:collection';
import 'package:community_app/state/constansts/firebase_field_name.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:flutter/material.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;

  UserInfoModel(
      {required this.displayName, required this.userId, required this.email})
      : super({
          FirebaseFieldName.userId: userId,
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email,
        });

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
            displayName: json[FirebaseFieldName.displayName] ?? "",
            userId: userId,
            email: json[FirebaseFieldName.email] ?? "");

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email;

  @override
  int get hashCode => Object.hashAll([userId, displayName, email]);
}
