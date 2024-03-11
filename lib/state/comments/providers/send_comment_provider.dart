import 'package:community_app/state/comments/notifires/send_comment_notifier.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sendCommentProvider =
    StateNotifierProvider<SendCommentNotifier, IsLoading>(
        (_) => SendCommentNotifier());
