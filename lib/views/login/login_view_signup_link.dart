import 'package:community_app/views/components/rich_text/base_text.dart';
import 'package:community_app/views/components/rich_text/rich_text_widget.dart';
import 'package:community_app/views/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignUpLink extends StatelessWidget {
  const LoginViewSignUpLink({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      text: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        BaseText.plain(text: Strings.signUpOn),
        BaseText.link(
            text: Strings.facebook,
            onTap: () {
              launchUrl(Uri.parse(Strings.facebookSignupUrl));
            }),
        BaseText.plain(text: Strings.orCreateAnAccountOn),
        BaseText.link(
            text: Strings.google,
            onTap: () {
              launchUrl(Uri.parse(Strings.googleSignupUrl));
            }),
      ],
      styleForAll: Theme.of(context).textTheme.subtitle1?.copyWith(height: 1.5),
    );
  }
}
