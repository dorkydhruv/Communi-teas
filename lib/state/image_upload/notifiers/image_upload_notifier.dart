import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_app/state/constansts/firebase_collection_names.dart';
import 'package:community_app/state/image_upload/constants/constants.dart';
import 'package:community_app/state/image_upload/exception/could_not_build_thumbnail_exception.dart';
import 'package:community_app/state/image_upload/extension/get_collection_name.dart';
import 'package:community_app/state/image_upload/extension/get_image_data_aspect_ratio.dart';
import 'package:community_app/state/post/models/post_payload.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/image_upload/tytpedefs/is_loading.dart';
import 'package:community_app/state/post/typedefs/user_id.dart';
import 'package:community_app/state/post_setting/models/post_setting.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);
  set isLoading(bool value) => state = value;
  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUInt8List;
    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw CouldNotBuildThumbnailException('Could not build thumbnail');
        }
        //now thumbnail
        final thumbnail =
            img.copyResize(fileAsImage, width: Constants.imageThumbnailWidth);
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUInt8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumbnail = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbnailMaxheight,
          quality: Constants.videoThumbnailMaxQuality,
        );
        if (thumbnail == null) {
          isLoading = false;
          throw CouldNotBuildThumbnailException('Could not build thumbnail');
        } else {
          thumbnailUInt8List = thumbnail;
        }
        break;
    }
    //calculate aspect ratio
    final thumbnailAspectRatio = thumbnailUInt8List.getAspectRatio();

    //calculate references
    final filename = const Uuid().v4();

    //create references to thumbnail and file
    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(filename);
    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.collectionName)
        .child(filename);

    try {
      //upload thumbnail to firebase storage
      final thumbnailUploadtask =
          await thumbnailRef.putData(thumbnailUInt8List);
      final thumbnailStorageId = thumbnailUploadtask.ref.name;
      //upload original file to firebase storage
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalFileStorageId = originalFileUploadTask.ref.name;
      //post payload
      final postPayload = PostPayload(
          userId: userId,
          message: message,
          thumbnailUrl: await thumbnailRef.getDownloadURL(),
          fileUrl: await originalFileRef.getDownloadURL(),
          fileTye: fileType.collectionName,
          fileName: filename,
          aspecTRatio: await thumbnailAspectRatio,
          thumbnailStorageId: thumbnailStorageId,
          originalFileStorageId: originalFileStorageId,
          postSetting: postSettings);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
