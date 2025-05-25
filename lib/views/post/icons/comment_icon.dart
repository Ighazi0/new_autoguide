import 'package:autoguide/app/app_style.dart';
import 'package:autoguide/services/locale_services.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CommentIcon extends StatelessWidget {
  const CommentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: AppStyle.borderRadius,

      onTap: () async {},
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FontAwesome.comment),
          const SizedBox(width: 5),
          Text('comment'.tr),
        ],
      ),
    );
  }
}
