import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/app/init_app.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:autoguide/ui/snack_dialog.dart';
import 'package:flutter/material.dart';

class DialogUI {
  showAlertDialog(
    String title,
    String content, {
    String? yesBtn,
    String? cancelBtn,
    Function? yesAction,
    Function? cancelAction,
    isDissmiss = true,
  }) {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      barrierDismissible: isDissmiss,
      builder: (BuildContext context) {
        return PopScope(
          canPop: isDissmiss,
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: AppStyle.borderRadius),
            titlePadding: EdgeInsets.fromLTRB(25, 20, 25, 0),
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            title: Text(title.tr, style: TextStyle(fontSize: 18)),
            content: content.isEmpty
                ? null
                : Text(content.tr, style: TextStyle(height: 1.5)),
            actions: [
              if (cancelAction != null)
                TextButton(
                  onPressed: () {
                    cancelAction();
                  },
                  child: Text(
                    (cancelBtn ?? 'cancel').tr,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              if (yesAction != null)
                TextButton(
                  onPressed: () {
                    yesAction();
                  },
                  child: Text(
                    (yesBtn ?? 'yes').tr,
                    style: TextStyle(color: AppStyle.primaryColor),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  showGeneralDialog(Widget child) {
    showDialog(
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  showSnackDialog(String? message, {bool error = true}) {
    showDialog(
      barrierColor: Colors.transparent,
      context: navigatorKey.currentState!.overlay!.context,
      builder: (BuildContext context) {
        return SnackDialog(message: message, error: error);
      },
    );
  }
}
