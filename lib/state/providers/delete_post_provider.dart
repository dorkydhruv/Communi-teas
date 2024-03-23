import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:community_app/state/post/notifier/post_delete_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final deltePOstProvider = StateNotifierProvider<DeltePostNotifier, IsLoading>(
    (ref) => DeltePostNotifier());
