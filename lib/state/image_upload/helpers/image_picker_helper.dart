import 'dart:io';

import 'package:community_app/state/image_upload/extension/to_file.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _imagePicker = ImagePicker();
  static Future<File?> pickImageFromGallery() async =>
      _imagePicker.pickImage(source: ImageSource.gallery).toFile();
  static Future<File?> pickVideofromGallery() async =>
      _imagePicker.pickVideo(source: ImageSource.gallery).toFile();
}
