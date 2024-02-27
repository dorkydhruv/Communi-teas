import 'package:community_app/state/auth/backend/authenticator.dart';
import 'package:community_app/state/auth/models/auth_result.dart';
import 'package:community_app/state/auth/models/auth_state.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:community_app/state/user_info/backend/user_info_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.userLoggedIn) {
      state = AuthState(
          result: AuthResult.success,
          isLoading: false,
          userId: _authenticator.userId);
    }
  }

  Future<void> logOut() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final res = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (res == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(result: res, isLoading: false, userId: userId);
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWithIsLoading(true);
    final res = await _authenticator.logInWithFacebook();
    final userId = _authenticator.userId;
    if (res == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: res,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
          userId: userId,
          displayName: _authenticator.userDisplayName,
          email: _authenticator.email);
}
