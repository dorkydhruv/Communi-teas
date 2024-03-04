import 'package:community_app/firebase_options.dart';
import 'package:community_app/state/auth/providers/is_logged_in.dart';
import 'package:community_app/state/providers/is_loading_provider.dart';
import 'package:community_app/views/components/loading/loading_screen.dart';
import 'package:community_app/views/login/login_view.dart';
import 'package:community_app/views/main/main_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import "dart:developer" as developer show log;
// extension Log on Object {
//   void log() => developer.log(toString());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ),
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: Consumer(builder: ((context, ref, child) {
        //listening loading state but getting the complete value not asynnc value like in watch
        ref.listen(isLoadingProvider, (_, isloading) {
          if (isloading) {
            LoadingScreen.instance().show(context: context);
          } else {
            LoadingScreen.instance().hide();
          }
        });
        final isLoggedIn = ref.watch(isLoggedInProvider);
        return isLoggedIn ? const MainView() : const LoginView();
      })),
    );
  }
}
