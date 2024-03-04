import 'dart:io';

import 'package:community_app/state/auth/providers/user_id_provider.dart';
import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/image_upload/model/thumbnail_request.dart';
import 'package:community_app/state/image_upload/providers/image_upload_provider.dart';
import 'package:community_app/state/post_setting/models/post_setting.dart';
import 'package:community_app/state/post_setting/provider/post_setting_provider.dart';
import 'package:community_app/views/components/file_thumbnail_view.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateNewPostView extends StatefulHookConsumerWidget {
  final File file;
  final FileType fileType;

  const CreateNewPostView({
    super.key,
    required this.file,
    required this.fileType,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest =
        ThumbnailRequest(file: widget.file, fileType: widget.fileType);
    final postSettings = ref.watch(postSettingProvider);
    final postController = useTextEditingController();
    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () {
        postController.removeListener(listener);
      };
    }, [postController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
              onPressed: isPostButtonEnabled.value
                  ? () async {
                      final userId = ref.read(userIdProvider);
                      if (userId == null) return;
                      final message = postController.text;
                      final isUploaded =
                          await ref.read(imageUplaodProvider.notifier).upload(
                                file: widget.file,
                                fileType: widget.fileType,
                                message: message,
                                postSettings: postSettings,
                                userId: userId,
                              );
                      if (isUploaded && mounted) {
                        Navigator.pop(context);
                      }
                    }
                  : null,
              icon: const Icon(Icons.send))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FileThumbnailview(request: thumbnailRequest),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: Strings.pleaseWriteYourMessageHere,
                ),
                autocorrect: true,
                maxLines: null,
                controller: postController,
              ),
            ),
            ...PostSetting.values.map((postSetting) {
              return ListTile(
                title: Text(postSetting.title),
                subtitle: Text(postSetting.description),
                trailing: Switch(
                    value: postSettings[postSetting] ?? false,
                    onChanged: (value) {
                      ref
                          .read(postSettingProvider.notifier)
                          .setSetting(postSetting, value);
                    }),
              );
            })
          ],
        ),
      ),
    );
  }
}
