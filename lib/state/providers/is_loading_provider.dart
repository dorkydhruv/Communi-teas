import 'package:community_app/state/auth/providers/auth_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authstate = ref.watch(authStateProvider);
  return authstate.isLoading;
});
