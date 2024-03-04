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
