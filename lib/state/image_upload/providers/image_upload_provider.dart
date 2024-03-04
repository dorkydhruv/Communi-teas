import 'package:community_app/state/image_upload/notifiers/image_upload_notifier.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final imageUplaodProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
        (_) => ImageUploadNotifier());
