import 'package:community_app/views/components/constants/strings.dart';
import 'package:community_app/views/components/dialogs/alert.dart';
import 'package:flutter/foundation.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  DeleteDialog({
    required String titleOfObjectToDelete,
  }) : super(
            title: "${Strings.delete} $titleOfObjectToDelete?",
            message:
                "${Strings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete?",
            buttons: {
              Strings.cancel: false,
              Strings.delete: true,
            });
}
