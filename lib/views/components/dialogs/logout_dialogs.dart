import 'package:community_app/views/components/constants/strings.dart';
import 'package:community_app/views/components/dialogs/alert.dart';
import 'package:flutter/material.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  LogoutDialog()
      : super(
            title: Strings.logOut,
            message: Strings.areYouSureThatYouWantToLogOutOfTheApp,
            buttons: {Strings.cancel: false, Strings.logOut: true});
}
