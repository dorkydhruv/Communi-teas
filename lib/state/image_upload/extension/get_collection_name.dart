import 'package:community_app/state/image_upload/model/file_type.dart';

extension GetCollectionName on FileType {
  String get collectionName {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}

extension GetFileType on String {
  FileType get fileTypes {
    switch (this) {
      case 'images':
        return FileType.image;
      case 'videos':
        return FileType.video;
      default:
        throw Exception('Unknown file type');
    }
  }
}
