import 'dart:collection';

import 'package:community_app/state/post_setting/models/post_setting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PostSettingNotifier extends StateNotifier<Map<PostSetting, bool>> {
  PostSettingNotifier()
      : super(UnmodifiableMapView({
          for (final setting in PostSetting.values) setting: true,
        }));

  void setSetting(PostSetting setting, bool value) {
    final existingValue = state[setting];
    if (existingValue == null || existingValue == value) {
      return;
    }
    state = Map.unmodifiable(Map.of(state)..[setting] = value);
  }
}
