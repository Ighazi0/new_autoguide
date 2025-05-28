import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final Function? onPressed;
  final String title;
  final bool loading;
  final double? fontSize;

  const CustomTextButton({
    super.key,
    this.onPressed,
    required this.title,
    this.fontSize,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed == null
          ? null
          : () {
              if (!loading) {
                onPressed!();
              }
            },
      child: Text(
        title.tr,
        style: TextStyle(
          color: AppStyle.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
