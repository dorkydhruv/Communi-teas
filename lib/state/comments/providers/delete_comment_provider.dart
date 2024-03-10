import 'package:community_app/state/comments/notifires/comment_delete_notifiers.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deleteCommentProvider =
    StateNotifierProvider<DeleteCommentNotifier, IsLoading>(
        (ref) => DeleteCommentNotifier());
