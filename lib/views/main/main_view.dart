//loggedin
import 'package:community_app/state/auth/providers/auth_provider.dart';
import 'package:community_app/state/image_upload/helpers/image_picker_helper.dart';
import 'package:community_app/state/image_upload/model/file_type.dart';
import 'package:community_app/state/post_setting/provider/post_setting_provider.dart';
import 'package:community_app/views/components/dialogs/alert.dart';
import 'package:community_app/views/components/dialogs/logout_dialogs.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:community_app/views/create_new_post/create_new_post.dart';
import 'package:community_app/views/tab/home/home_view.dart';
import 'package:community_app/views/tab/search_view/search_view.dart';
import 'package:community_app/views/tab/user_posts/user_posts_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Strings.appName),
          actions: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.film),
              onPressed: () async {
                //pick video
                final videoPath =
                    await ImagePickerHelper.pickVideofromGallery();
                if (videoPath == null) return;
                // ignore: unused_result
                ref.refresh(postSettingProvider);
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                        file: videoPath, fileType: FileType.video),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_photo_alternate),
              onPressed: () async {
                //pick image
                final imagePath =
                    await ImagePickerHelper.pickImageFromGallery();
                if (imagePath == null) return;
                // ignore: unused_result
                ref.refresh(postSettingProvider);
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CreateNewPostView(
                        file: imagePath, fileType: FileType.image),
                  ),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final shouldLogout = await LogoutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogout) {
                  await ref.read(authStateProvider.notifier).logOut();
                }
              },
            ),
          ],
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(Icons.person),
            ),
            Tab(
              icon: Icon(Icons.search),
            ),
            Tab(
              icon: Icon(Icons.home),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [
            HomeView(),
            SearchView(),
            UserPostView(),
          ],
        ),
      ),
    );
  }
}
