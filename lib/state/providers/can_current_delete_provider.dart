import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/post/models/post.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final canCurrentUserDelteProvider =
    StreamProvider.family.autoDispose<bool, Posts>((ref, Posts post) async* {
  final userId = ref.watch(userIdProvider);
  yield userId == post.userId;
});
