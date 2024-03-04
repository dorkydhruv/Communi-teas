import 'package:community_app/state/auth/providers/auth_provider.dart';
import 'package:community_app/state/image_upload/providers/image_upload_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingProvider = Provider<bool>((ref) {
  final authstate = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUplaodProvider);
  return authstate.isLoading || isUploadingImage;
});
