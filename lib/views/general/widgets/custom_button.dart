import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/device_services.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Function? onPressed;
  final String title;
  final Color? color;
  final Color? textColor;
  final Widget? icon;
  final double? height;
  final double? fontSize;
  final double? minWidth;
  final bool loading;
  final bool border;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.title,
    this.color,
    this.icon,
    this.height,
    this.fontSize,
    this.textColor,
    this.minWidth,
    this.loading = false,
    this.border = false,
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
      height: height ?? 45,
      minWidth: minWidth ?? DeviceServices.width,
      shape: RoundedRectangleBorder(
        borderRadius: AppStyle.borderRadius,
        side: border
            ? BorderSide(color: color ?? AppStyle.primaryColor)
            : BorderSide.none,
      ),
      color: border ? null : color ?? AppStyle.primaryColor,
      disabledColor: AppStyle.lightGrey,
      child: loading
          ? FittedBox(
              child: CircularProgressIndicator(
                color: border ? AppStyle.primaryColor : Colors.white,
                strokeWidth: 2,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: icon == null ? MainAxisSize.min : MainAxisSize.max,
              children: [
                Text(
                  title.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontSize,
                    color: onPressed == null
                        ? Colors.grey
                        : textColor ?? Colors.white,
                  ),
                ),
                if (icon != null) SizedBox(width: 10),
                if (icon != null) icon!,
              ],
            ),
    );
  }
}
