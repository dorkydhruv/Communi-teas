import 'package:community_app/state/image_upload/extension/get_image_aspect_ratio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;

extension GetImageDataAspectRatio on Uint8List {
  Future<double> getAspectRatio() async {
    final image = material.Image.memory(this);
    return await image.getAspectRatio();
  }
}
