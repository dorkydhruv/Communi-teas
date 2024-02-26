import 'package:community_app/firebase_options.dart';
import 'package:community_app/state/auth/backend/authenticator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import "dart:developer" as developer show log;

extension Log on Object {
  void log() => developer.log(toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
            onPressed: () async {
              final res = await Authenticator().loginWithGoogle();
              res.log();
            },
            child: const Text("Sign In with Google")),
        TextButton(
            onPressed: () async {
              final res = await Authenticator().logInWithFacebook();
              res.log();
            },
            child: const Text("Sign In with Facebook"))
      ],
    ));
  }
}
