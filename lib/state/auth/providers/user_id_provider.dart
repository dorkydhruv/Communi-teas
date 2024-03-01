import 'package:community_app/state/auth/providers/auth_provider.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final userIdProvider =
    Provider<UserId?>((ref) => ref.watch(authStateProvider).userId);
