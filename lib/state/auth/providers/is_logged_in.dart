import 'package:community_app/state/auth/models/auth_result.dart';
import 'package:community_app/state/auth/providers/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoggedInProvider = Provider<bool>((ref) {
  final state = ref.watch(authStateProvider);
  return state.result == AuthResult.success;
});
