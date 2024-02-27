import 'package:community_app/state/auth/models/auth_result.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:flutter/material.dart';

@immutable
class AuthState {
  final AuthResult? result;
  final bool isLoading;
  final UserId? userId;
  const AuthState({
    required this.result,
    required this.isLoading,
    required this.userId,
  });

  const AuthState.unknown()
      : result = null,
        isLoading = false,
        userId = null;

  AuthState copyWithIsLoading(bool isLoadig) =>
      AuthState(result: result, isLoading: isLoadig, userId: userId);

  @override
  bool operator ==(covariant AuthState other) =>
      identical(this, other) ||
      (runtimeType == other.runtimeType &&
          result == other.result &&
          isLoading == other.isLoading &&
          userId == other.userId);

  @override
  int get hashCode => Object.hash(result, isLoading, userId);
}
