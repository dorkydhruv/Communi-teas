import 'dart:async';

import 'package:flutter/material.dart' as material;

extension GetImageAspectRatio on material.Image {
  Future<double> getAspectRatio() async {
    final completer = Completer<double>();
    image
        .resolve(const material.ImageConfiguration())
        .addListener(material.ImageStreamListener((imageInfo, synchronousCall) {
      final aspectRatio = imageInfo.image.width / imageInfo.image.height;
      completer.complete(aspectRatio);
    }));
    return completer.future;
  }
}
