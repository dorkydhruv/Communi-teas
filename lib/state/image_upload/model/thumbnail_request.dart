import 'dart:io';

import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:flutter/material.dart';

@immutable
class ThumbnailRequest {
  final File file;
  final FileType fileType;

  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ThumbnailRequest &&
        runtimeType == other.runtimeType &&
        other.file == file &&
        other.fileType == fileType;
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        file,
        fileType,
      ]);
}
